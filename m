From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: Re: emu10k1 polishing?
Date: Thu, 12 Feb 2004 10:45:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <S21917AbUBLIpq/20040212084546Z+734@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>From: p z oooo <pzad@pobox.sk>
>
>>2. Alsamixer shows obscure names
>You could rename it in alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
>and send patch here.

I dislike patches, but I include one below if you insist.
Just don't apply the patch to the latest Alsa, because I have
alsa-driver-1.0.0pre3. (Sorry cannot download latest version; maybe
next year...)

Now the names are better but not perfect:

 Line2/Mic2 LiveDrive
 Line2/Mic2 LiveDrive Capture
 Aux2 LiveDrive
 Aux2 LiveDrive 1           should be:  Aux2 LiveDrive Capture

Why the last comes out wrong?

Regards,
Juhana

 == cut ==

1914c1914
< 		/* Line LiveDrive Playback Volume */
---
> 		/* Line2/Mic2 LiveDrive Playback Volume */
1917c1917
< 		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Playback Volume", gpr, 0);
---
> 		snd_emu10k1_init_stereo_control(controls + i++, "Line2/Mic2 LiveDrive Playback Volume", gpr, 0);
1920c1920
< 		/* Line LiveDrive Capture Volume + Switch */
---
> 		/* Line2/Mic2 LiveDrive Capture Volume + Switch */
1925,1926c1925,1926
< 		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Capture Volume", gpr, 0);
< 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line LiveDrive Capture Switch", gpr + 2, 0);
---
> 		snd_emu10k1_init_stereo_control(controls + i++, "Line2/Mic2 LiveDrive Capture Volume", gpr, 0);
> 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line2/Mic2 LiveDrive Capture Switch", gpr + 2, 0);
1948c1948
< 		/* Line LiveDrive Playback Volume */
---
> 		/* Aux2 LiveDrive Playback Volume */
1951c1951
< 		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Playback Volume", gpr, 0);
---
> 		snd_emu10k1_init_stereo_control(controls + i++, "Aux2 LiveDrive Playback Volume", gpr, 0);
1955c1955
< 		/* Line LiveDrive Capture Volume */
---
> 		/* Aux2 LiveDrive Capture Volume */
1960,1961c1960,1961
< 		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Capture Volume", gpr, 0);
< 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line LiveDrive Capture Switch", gpr + 2, 0);
---
> 		snd_emu10k1_init_stereo_control(controls + i++, "Aux2 LiveDrive Capture Volume", gpr, 0);
> 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Aux2 LiveDrive Capture Switch", gpr + 2, 0);


 == end ==


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
