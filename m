From: Georgi Georgiev <chutz@gg3.net>
Subject: RE:Creative/emu10k1 status?
Date: Sat, 3 Jan 2004 14:14:40 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040103051440.GA24684@lion.gg3.net>
References: <200311180718.hAI7ILOZ006781@www7.pobox.sk>
Reply-To: Georgi Georgiev <chutz-dated-1074316482.b43f75f930de@gg3.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200311180718.hAI7ILOZ006781@www7.pobox.sk>
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

It seems that all that the simplest solution is:

--- linux-2.6.0/sound/pci/emu10k1/emufx.c	2003-12-18 11:58:56.000000000 +0900
+++ linux-2.6.0/sound/pci/emu10k1/emufx.c	2004-01-03 13:54:16.812419915 +0900
@@ -1941,6 +1941,7 @@
 			VOLUME_ADD(icode, &ptr, capture + z, tmp + 0, gpr + z);
 		}
 		snd_emu10k1_init_stereo_control(controls + i++, "Line LiveDrive Capture Volume", gpr, 0);
+		controls[i-1].id.index = 1;
 		snd_emu10k1_init_stereo_onoff_control(controls + i++, "Line LiveDrive Capture Switch", gpr + 2, 0);
 		controls[i-1].id.index = 1;
 		gpr += 4;

Without this, the second control was overriding the last one or something and
the result is that the Capture Volume we needed was not accessible.

Before the patch:

$ amixer controls | grep LiveDrive | sort
numid=23,iface=MIXER,name='Line LiveDrive Playback Volume'
numid=24,iface=MIXER,name='Line LiveDrive Capture Volume'
numid=25,iface=MIXER,name='Line LiveDrive Capture Switch'
numid=29,iface=MIXER,name='Line LiveDrive Playback Volume',index=1
numid=30,iface=MIXER,name='Line LiveDrive Capture Switch',index=1

After the patch:

$ amixer controls | grep LiveDrive | sort
numid=23,iface=MIXER,name='Line LiveDrive Playback Volume'
numid=24,iface=MIXER,name='Line LiveDrive Capture Volume'
numid=25,iface=MIXER,name='Line LiveDrive Capture Switch'
numid=29,iface=MIXER,name='Line LiveDrive Playback Volume',index=1
numid=30,iface=MIXER,name='Line LiveDrive Capture Volume',index=1
numid=31,iface=MIXER,name='Line LiveDrive Capture Switch',index=1


-- 
 /   Georgi Georgiev    / QOTD: "It was so cold last winter that I saw  /
\     chutz@gg3.net    \  a lawyer with his hands in his own pockets." \
 /  +81(90)6266-1163    /                                               /


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
