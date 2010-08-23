From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: HDMI hot-plug/ELD issues
Date: Mon, 23 Aug 2010 10:16:48 -0500
Message-ID: <AANLkTimyAGDPmhk4CEPSjTFAk12vE6nbMp5CLHQ=7eqS@mail.gmail.com>
References: <AANLkTi=Nmtn8DsXH7u+tt0j_Cs1tnjaHO4XoLAPoyAAs@mail.gmail.com>
	<20100823010122.GA5740@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 67BAF2412E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 17:16:51 +0200 (CEST)
Received: by yxp4 with SMTP id 4so2309256yxp.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 08:16:50 -0700 (PDT)
In-Reply-To: <20100823010122.GA5740@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> 1. Playback can happen even if there's no HDMI cable plugged. Or when
>> I remove the cable, the player isn't notified and keeps sending data
>> to the driver. This is fine for PCM but I noticed that the receiver
>> can handle some trouble synchronizing with in AC3-passthrough mode if
>> the cable is inserted after the playback starts. It would be much
>> cleaner to allow playback only when there's an actual cable connected,
>> and to return -ENODEV or something to apps when this happens.
>
> We used to turn off HDMI link when not playing. However that caused
> loss of 0.5s samples when starting next playback, due to the slow
> responding HDMI sink devices (in fact all my tested monitors/AV
> receivers have this problem).

I think it's fine if you leave the link on.

> What's your test case? Keep playing during plug/unplug, or
> play -- plug -- stop playing -- unplug -- play a new track?

The player keeps playing, and then I unplug/replug/unplug/replug the
cable. At some point the receiver will lose the sync with compressed
data.

> Then there's the question whether to send -ENODEV to the audio player,
> or to send udev events (for pulseaudio) on hotplug events, or to
> disable HDMI link only for passthrough mode, or whatever policy.
> Any ideas?

I think we really need a consistent approach for all HDMI devices so
that middleware, PulseAudio specifically works without quirks and
hardware-specific work-arounds.
Ideally when the HDMI cable is plugged you would register a new card
and this would generate the relevant hot-plug events.However in the
case of HDAudio you have 2 devices for the same card. I am not sure
ALSA would generate hot-plug events if you registered/exposed the
HDMI-related devices only when a cable is played. Alternatively we
could leave the devices exposed at all times generate a dedicated HDMI
event, and have PulseAudio handle it.
How is this handled on non-Intel hardware?

>> Is there a missing link with the display driver so that this info
>> would make sense? I remember having a conversation with Fengguang Wu
>> on this, but I can't remember what the outcome was. Or is this a case
>> of back luck with broken hardware not sending the legal EDID info?
>> Thanks for your help on this.
>
> Sorry we have not implemented the ELD feature in video driver. =A0The
> Intel gfx driver should read&parse HW EDID and pass the ELD info to
> the audio driver.

It doesn't seem like rocket science, is this something that could be
patched? That really needs to be fixed, so that we can work with
Takashi and expose the ELD info to user-space. All this information is
badly needed by middleware.
-Pierre
