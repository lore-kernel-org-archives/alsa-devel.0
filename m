From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hda-intel front headphone (8086:27d8 1043:83bc)
Date: Tue, 12 Jul 2011 17:13:36 +0800
Message-ID: <CAN8cciZsQ0C0kMFVWPLN-U6gNH2=t_uN7p2MzcEwpEc3GkeotA@mail.gmail.com>
References: <CAN8cciZG=Cx8_9W7DNtCgde9Xy9h=ZBA0cXh1sni6VQhy-veeg@mail.gmail.com>
	<201107112125.57804.xenogenesi@virgilio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id ADC0524514
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 11:13:39 +0200 (CEST)
Received: by fxh2 with SMTP id 2so5149099fxh.9
	for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2011 02:13:36 -0700 (PDT)
In-Reply-To: <201107112125.57804.xenogenesi@virgilio.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/7/12 Alex <xenogenesi@virgilio.it>:
>> > My knowledge of audio/alsa programming is really poor, but if someone
>> > suggest a patch I can setup the thing and do some debug.
>>
>> Try Takashi 's daily snapshot tarball
>>
>> you should able to get "Headphone Playback Volume" after this patch
>> "ALSA: hda - Code consolidation for ALC88x and ALC662 auto-parsers"
>>
>> using hda-emu and it seem the driver support 6 channels even when the
>> pink and blue jacks are not retasked
>
> Hi Raymond, thanks for your support
>
> built and installed the daily snapshot, the driver tarball only, now the mixer
> applications show adjustable headphone volume level, but still hear nothing.
> Should upgrade alsa lib or something else too?

you may need to provide output of alsa-info.sh

configure --with-debug=verbose


>
> Just a note, in the bios there's some related option:
> Audio Controller: [Azalia]/Disable all
> Front panel Support type: AC97/[HD Audio]
>
> I checkd both AC97 and HD with the new alsa-driver with the same result.

Do your computer chassis have a HD Front Audio Panel ?

http://www.intel.com/support/motherboards/desktop/sb/CS-020642.htm#standards

You can also physically check the audio cable of the front panel audio
solution. If there is a cable connected to Pin 4, you have an HD Audio
module; if there is no cable to Pin 4, you have an AC97 module.

The difference between AC97 and HD Audio  "Front panel Support type:"
in BIOS setup
is Misc[11:8] of Configuration Default  is a bit field used to
indicate other information about the jack.
If bit 0 is set, it indicates that the jack has no presence detect
capability, so even if a Pin Complex indicates that the codec hardware
supports the presence detect functionality on the jack, the external
circuitry is not capable of supporting the functionality


you can use hda-jack-sense-test

http://thread.gmane.org/gmane.linux.alsa.devel/85051
