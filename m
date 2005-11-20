From: Sascha Sommer <saschasommer@freenet.de>
Subject: [PATCH] abort snd_pcm_dmix_drain when state is SND_PCM_STATE_XRUN
Date: Sun, 20 Nov 2005 02:17:19 +0100
Message-ID: <200511200217.20070.saschasommer@freenet.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_g68fDue8KV8noZ6"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

--Boundary-00=_g68fDue8KV8noZ6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
this is a fix for bug 0001559.
Unlike my first guesses the real problem is not in the kernel driver but in 
alsa-lib. Whenever the current dmix status is xrun and snd_pcm_dmix_drain 
gets called the process will hang forever in the poll function. The reason is 
that poll gets called even though the timer already stopped.
As described in the bugtracking system this bug was not noticable with alsa 
versions that used the old IOCTLS because the SNDRV_TIMER_IOCTL_STOP ioctl 
never reached the timer kernel module.

Attached patch fixes this problem for alsa-lib 1.0.10 by simply calling  
snd_pcm_dmix_drop when snd_pcm_dmix_drain gets called in the state
SND_PCM_STATE_XRUN.

Regards

Sascha 

--Boundary-00=_g68fDue8KV8noZ6
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-lib-1.0.10-dmix-drain-xrun.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-lib-1.0.10-dmix-drain-xrun.patch"

--- src/pcm/pcm_dmix.c.org	2005-11-20 01:51:04.000000000 +0100
+++ src/pcm/pcm_dmix.c	2005-11-20 01:53:41.000000000 +0100
@@ -532,6 +532,12 @@
 			return 0;
 		}
 	}
+
+	if (dmix->state == SND_PCM_STATE_XRUN) {
+		snd_pcm_dmix_drop(pcm);
+		return 0;
+	}
+
 	stop_threshold = pcm->stop_threshold;
 	if (pcm->stop_threshold > pcm->buffer_size)
 		pcm->stop_threshold = pcm->buffer_size;

--Boundary-00=_g68fDue8KV8noZ6--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
