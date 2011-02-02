From: Robin Neatherway <neatherway@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Wed, 2 Feb 2011 23:38:19 +0000
Message-ID: <AANLkTi=xW-_Myvi279yJEySDDRsktrMkVpFyQhu0mu0w@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
	<AANLkTimb+yqOhWP1Rc78F9pc+j6VEGp7v0SYvGi7mGrb@mail.gmail.com>
	<AANLkTim2ch5-QHoh67SuKwMmTMQL=HM6VG1iVCxxoo9+@mail.gmail.com>
	<AANLkTimszyfVj8pbt4jujQ3o96OqVHKb-bb7o8GXG5pU@mail.gmail.com>
	<AANLkTi=hFT5Sono3Sehq2WRZZcgEULs2jwwm-ZTDEb0R@mail.gmail.com>
	<AANLkTi=xPwCS0AH1jzGx9UB5=fSLNGMJa-J6tyFgjSaG@mail.gmail.com>
	<AANLkTi=u8QCzVRUjQVJVfPqOhy8wsA5P7bsFPP2t9w9Z@mail.gmail.com>
	<AANLkTimt3U7Dxs5ufTqJ1Qd5uCNcLs_Lexcp5B9MP6E1@mail.gmail.com>
	<s5hmxme5sue.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D9CB224441
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 00:38:45 +0100 (CET)
Received: by vxb40 with SMTP id 40so120722vxb.38
	for <alsa-devel@alsa-project.org>; Wed, 02 Feb 2011 15:38:42 -0800 (PST)
In-Reply-To: <s5hmxme5sue.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> hp_automute work only when it get the correct position of HP and speaker
>> [Pin complex]
>>
>> Can you post the output of alsa-info.sh using model=3Dauto after a cold =
boot
>> to find out whether BIOS setup pin default of node 0x0f and 0x10 to HP a=
nd
>> Speakers =A0?
>>
>> if not, you will need to find any alc269 model which create "Headphone
>> Playback Volume" at node 0x8 and "Speaker Playback volume" at node 0x09

OK, this produced some interesting behaviour, new alsa info at:
http://www.alsa-project.org/db/?f=3Dbdb19d75e4147d3ee294f2150db8b723e3ad3527

Headphone volume appears at node 0x8 and speakers at 0x9, however
there is no sound over the speakers now, possibly related to this
dmesg output:
[   25.417568] ALSA hda_codec.c:4633: autoconfig: line_outs=3D2
(0x10/0x15/0x0/0x0/0x0)
[   25.417575] ALSA hda_codec.c:4637:    speaker_outs=3D0 (0x0/0x0/0x0/0x0/=
0x0)
[   25.417581] ALSA hda_codec.c:4641:    hp_outs=3D1 (0x14/0x0/0x0/0x0/0x0)

> Or set up the pins dynamically via sysfs and reconfigure.
> If you find out a working setup, it can be initialized automatically
> via patch option of snd-hda-intel module.
>
> More details are found in HD-Audio.txt.


I've had a read through HD-Audio.txt and a quick look at the HD audio
spec from Intel. It isn't clear to me how the pin configs relate to
the way things are set up. The
/sys/class/sound/hwC0D0/init_pin_configs file looks like this:

0x0f 0x411111f0
0x10 0xb7031110
0x11 0x411111f0
0x12 0x02a11820
0x13 0xb7831121
0x14 0x0221101f
0x15 0x21011010
0x16 0x411111f0
0x17 0xb7931122
0x18 0x2145111e
0x19 0x411111f0

Does each of the hex values on the left refer to a node? If so, where
are those before 0xf and after 0x19?

Thanks,
Robin
