From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: HDMI hot-plug/ELD issues
Date: Mon, 23 Aug 2010 09:01:22 +0800
Message-ID: <20100823010122.GA5740@localhost>
References: <AANLkTi=Nmtn8DsXH7u+tt0j_Cs1tnjaHO4XoLAPoyAAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 31B0810380C
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 03:01:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Nmtn8DsXH7u+tt0j_Cs1tnjaHO4XoLAPoyAAs@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

On Thu, Aug 19, 2010 at 05:25:53PM -0500, pl bossart wrote:
> Hi,
> I was testing my pulseaudio AC3 passthrough patch on my new laptop
> (all Intel hw, Corei5/IbexPeak, 2.6.35) and noticed a set of issues
> with the HDMI output:
> 1. Playback can happen even if there's no HDMI cable plugged. Or when
> I remove the cable, the player isn't notified and keeps sending data
> to the driver. This is fine for PCM but I noticed that the receiver
> can handle some trouble synchronizing with in AC3-passthrough mode if
> the cable is inserted after the playback starts. It would be much
> cleaner to allow playback only when there's an actual cable connected,
> and to return -ENODEV or something to apps when this happens.

We used to turn off HDMI link when not playing. However that caused
loss of 0.5s samples when starting next playback, due to the slow
responding HDMI sink devices (in fact all my tested monitors/AV
receivers have this problem).

What's your test case? Keep playing during plug/unplug, or
play -- plug -- stop playing -- unplug -- play a new track?

Then there's the question whether to send -ENODEV to the audio player,
or to send udev events (for pulseaudio) on hotplug events, or to
disable HDMI link only for passthrough mode, or whatever policy.
Any ideas?

> 2. It looks like the ELD info is invalid in /proc/asound/cards/. Tried
> both with my TV and AV receiver, no luck, all zeroes except for
> 'monitor_present'
> 
> monitor_present         1
> eld_valid               0
> monitor_name
> connection_type         HDMI
> eld_version             [0x0] reserved
> edid_version            [0x0] no CEA EDID Timing Extension block present
> manufacture_id          0x0
> product_id              0x0
> port_id                 0x0
> support_hdcp            0
> support_ai              0
> audio_sync_delay        0
> speakers                [0xffff] FL/FR LFE FC RL/RR RC FLC/FRC RLC/RRC
> FLW/FRW FLH/FRH TC FCH
> sad_count               0
> 
> Is there a missing link with the display driver so that this info
> would make sense? I remember having a conversation with Fengguang Wu
> on this, but I can't remember what the outcome was. Or is this a case
> of back luck with broken hardware not sending the legal EDID info?
> Thanks for your help on this.

Sorry we have not implemented the ELD feature in video driver.  The
Intel gfx driver should read&parse HW EDID and pass the ELD info to
the audio driver.

Thanks,
Fengguang
