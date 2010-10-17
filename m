From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Sun, 17 Oct 2010 11:39:36 +0800
Message-ID: <AANLkTi=+ymN8DWx2G0c6o0HfExKRs7fu-K1XzaOSw-pS@mail.gmail.com>
References: <s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org> <4CA46E98.10402@ladisch.de>
	<4CA4A844.7060403@colin.guthr.ie>
	<20100930164753.GB9431@sirena.org.uk>
	<s5hr5gb9k83.wl%tiwai@suse.de> <4CA5834D.5030408@ladisch.de>
	<4CA59976.2020306@colin.guthr.ie> <4CA5A38A.7050006@ladisch.de>
	<i8ce5u$fj3$1@dough.gmane.org> <4CAD7F3D.3090205@ladisch.de>
	<4CAF1AF2.3060907@colin.guthr.ie> <4CAF1FA3.5000402@ladisch.de>
	<4CAF2533.1060102@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 56A5710381D
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 05:39:37 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1298639ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 16 Oct 2010 20:39:36 -0700 (PDT)
In-Reply-To: <4CAF2533.1060102@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/8 Colin Guthrie <gmane@colin.guthr.ie>

> D: alsa-mixer.c: Activating path analog-output
> D: alsa-mixer.c: Path analog-output (Analog Output), direction=1,
> priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
> has_dB=yes, min_volume=0, max_volume=31, min_dB=-97.5, max_dB=0
> D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
> enumeration=0, required=0, required_absent=0, mask=0x3600000000f66,
> n_channels=2, override_map=yes
> D: alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1,
> enumeration=0, required=0, required_absent=0, mask=0x3600000000f66,
> n_channels=2, override_map=yes
> I: alsa-sink.c: Hardware volume ranges from -97.50 dB to 0.00 dB.
> I: alsa-sink.c: No particular base volume set, fixing to 0 dB
> I: alsa-sink.c: Using hardware volume control. Hardware dB scale supported.
> I: alsa-sink.c: Using hardware mute control.
>

If step 0 of the Master Volume control is SND_CTL_TLV_DB_GAIN_MUTE (i.e.
-99999dB) , step 1 is -45dB and step 31 is 0dB

does it mean that the mixer application can no longer rely on
snd_mixer_selem_get_playback_dB_range() to get the correct min dB at min
step from snd_mixer_selem_set_playback_volume_range() ?

the dB range of PCM soft is -51dB to 0dB

how do PA calculate the range -97.5dB to -dB as it is not possible to set
total dB value to -97.5dB any more ?
