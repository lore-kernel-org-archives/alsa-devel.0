From: Georgi Georgiev <chutz@gg3.net>
Subject: Re: Creative/emu10k1 status? (working Line-In2)
Date: Wed, 31 Dec 2003 06:04:41 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031230210440.GB17637@lion.gg3.net>
References: <S19421AbTKNSdA/20031114183300Z+1380@nic.funet.fi>
Reply-To: Georgi Georgiev <chutz-dated-1074027884.1287165cfb51@gg3.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <S19421AbTKNSdA/20031114183300Z+1380@nic.funet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kouhia@nic.funet.fi, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Hello. What is the latest status of Creative/emu10k1 support?
> 
> I have Alsa driver where the LiveDrive Line-In2 ("Line LiveDrive 1")
> on capture bus does not work. We checked the case with Alsa developers
> but the problem remained. A quick look at the Alsa-Devel archives
> reveals that others have had the same problem this year.
> 
> Before anyone jumps and tell that they are able to record from
> the Line-In2, I can tell that that is possible via AC97, which
> is wrong way.
> 
>  !! If you think your capture works, mail me and we   !!
>  !! *verify* it together with my test mixer settings. !!

I was playing with the alsa source in kernel-2.6.0 and after "fixing" a few
things, my Line-In2 started working as expected.

This is my testing procedure:

- Headset plugged in the Headphones and Mic of the LiveDrive. Card is Live
  Platinum (with the IEEE1394).

- Unload all alsa modules and confirm nothing is loaded.... cat
  /proc/asound/cards says "no cards". My sound-related modules are compiled in
  the kernel and only the card-specific drivers are modules.

- modprobe snd-emu10k1

- set a few volume levels (all are default, module is freshly loaded and
  alsactl is not used). I set the headphones, so I can be more than sure that I
  do not record what I am hearing. The names do not correspond to the original
  ones, because of the changes to the source.

  amixer cset numid=36,iface=MIXER,name='Headphone Playback Volume',index=1 50,50
  amixer cset numid=24,iface=MIXER,name='LiveDrive Line1 Capture Volume' 100,100
  amixer cset numid=25,iface=MIXER,name='LiveDrive Line1 Capture Switch' on,on

  In reality I used alsamixer to set these three values, but for clarity I show
  the amixer commands here.

- Test recording

  arecord -f cd > out.wav
  aplay out.wav

Works fine and nothing was heard while recording. AC97 capture level is down,
Capture switch is off etc.

The exact same procedure does not work using the original sources.

I attach my patch, but it is already too late (it is MORNING already) for me to
check what exactly "fixed" the problem. The reason I started playing with the
sources, was because gamix had trouble identifying some of the controls, so I
decided to change the names to more reasonable values. I also removed the
indexing of the "LiveDrive Line" controls and it suddenly worked as if by
magic. I hope some guru creates a more reasonable patch.

One more thing. Happy New Year! I hope this patch makes a bunch of us happy,
even in its present very ugly state.

-- 
\    Georgi Georgiev   \  A long memory is the most subversive idea in \
/     chutz@gg3.net    /  America.                                     /
\   +81(90)6266-1163   \                                               \

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-emu10k1.patch"

--- linux-2.6.0/sound/pci/emu10k1/emufx.c	2003-12-18 11:58:56.000000000 +0900
+++ linux-2.6.0/sound/pci/emu10k1/emufx.c	2003-12-31 04:52:31.907050521 +0900
@@ -159,7 +159,7 @@
 	/* 0x0f */ "Rear Right",
 	/* 0x10 */ "AC97 Front Left",
 	/* 0x11 */ "AC97 Front Right",
-	/* 0x12 */ "ADC Caputre Left",
+	/* 0x12 */ "ADC Capture Left",
 	/* 0x13 */ "ADC Capture Right",
 	/* 0x14 */ NULL,
 	/* 0x15 */ NULL,
@@ -1897,7 +1897,7 @@
 		/* Line LiveDrive Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_LINE1_L + z, gpr + z);
-		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Playback Volume", gpr, 0);
+		snd_emu10k1_init_stereo_control(controls + i++, "LiveDrive Line1 Playback Volume", gpr, 0);
 		gpr += 2;
 	
 		/* Line LiveDrive Capture Volume + Switch */
@@ -1905,8 +1905,8 @@
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_LINE1_L + z, gpr + 2 + z);
 			VOLUME_ADD(icode, &ptr, capture + z, tmp + 0, gpr + z);
 		}
-		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Capture Volume", gpr, 0);
-		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line LiveDrive Capture Switch", gpr + 2, 0);
+		snd_emu10k1_init_stereo_control(controls + i++, "LiveDrive Line1 Capture Volume", gpr, 0);
+		snd_emu10k1_init_stereo_onoff_control(controls + i++, "LiveDrive Line1 Capture Switch", gpr + 2, 0);
 		gpr += 4;
 	}
 	
@@ -1928,21 +1928,21 @@
 	}
 	
 	if (emu->fx8010.extin_mask & ((1<<EXTIN_LINE2_L)|(1<<EXTIN_LINE2_R))) {
-		/* Line LiveDrive Playback Volume */
+		/* Line2 LiveDrive Playback Volume */
 		for (z = 0; z < 2; z++)
 			VOLUME_ADDIN(icode, &ptr, playback + z, EXTIN_LINE2_L + z, gpr + z);
-		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Playback Volume", gpr, 0);
-		controls[i-1].id.index = 1;
+		snd_emu10k1_init_stereo_control(controls + i++, "LiveDrive Line2 Playback Volume", gpr, 0);
+		//controls[i-1].id.index = 1;
 		gpr += 2;
 	
-		/* Line LiveDrive Capture Volume */
+		/* Line2 LiveDrive Capture Volume */
 		for (z = 0; z < 2; z++) {
 			SWITCH_IN(icode, &ptr, tmp + 0, EXTIN_LINE2_L + z, gpr + 2 + z);
 			VOLUME_ADD(icode, &ptr, capture + z, tmp + 0, gpr + z);
 		}
-		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Capture Volume", gpr, 0);
-		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line LiveDrive Capture Switch", gpr + 2, 0);
-		controls[i-1].id.index = 1;
+		snd_emu10k1_init_stereo_control(controls + i++, "LiveDrive Line2 Capture Volume", gpr, 0);
+		snd_emu10k1_init_stereo_onoff_control(controls + i++, "LiveDrive Line2 Capture Switch", gpr + 2, 0);
+		//controls[i-1].id.index = 1;
 		gpr += 4;
 	}
 

--UlVJffcvxoiEqYs2--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
