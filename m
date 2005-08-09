From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Obsolete open_flag
Date: Wed, 10 Aug 2005 00:18:28 +0200
Message-ID: <200508100018.28175.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Runs fine here, saves a little space and is obviously correct.
Erm ... I think.
Please apply, if you agree.

   Thanks,
   Karsten

------
Summary: ALSA's struct _snd_pcm_substream: Obsolete open_flag
From: Karsten Wiese <annabellesgarden@yahoo.de>

This patch removes open_flag from struct _snd_pcm_substream.
All of its uses are substituted by querying struct _snd_pcm_substream's
member ffile instead.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>


Index: alsa-kernel/core/pcm_native.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_native.c,v
retrieving revision 1.120
diff -U3 -r1.120 pcm_native.c
--- alsa-kernel/core/pcm_native.c	31 May 2005 13:35:31 -0000	1.120
+++ alsa-kernel/core/pcm_native.c	9 Aug 2005 21:22:39 -0000
@@ -1967,13 +1967,12 @@
 	runtime = substream->runtime;
 	str = substream->pstr;
 	snd_pcm_unlink(substream);
-	if (substream->open_flag) {
+	if (substream->ffile != NULL) {
 		if (substream->ops->hw_free != NULL)
 			substream->ops->hw_free(substream);
 		substream->ops->close(substream);
-		substream->open_flag = 0;
+		substream->ffile = NULL;
 	}
-	substream->ffile = NULL;
 	snd_pcm_remove_file(str, pcm_file);
 	snd_pcm_release_substream(substream);
 	kfree(pcm_file);
@@ -2022,7 +2021,7 @@
 		snd_pcm_release_file(pcm_file);
 		return err;
 	}
-	substream->open_flag = 1;
+	substream->ffile = file;
 
 	err = snd_pcm_hw_constraints_complete(substream);
 	if (err < 0) {
@@ -2032,8 +2031,6 @@
 		return err;
 	}
 
-	substream->ffile = file;
-
 	file->private_data = pcm_file;
 	*rpcm_file = pcm_file;
 	return 0;
Index: alsa-kernel/core/oss/pcm_oss.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_oss.c,v
retrieving revision 1.95
diff -U3 -r1.95 pcm_oss.c
--- alsa-kernel/core/oss/pcm_oss.c	30 Jun 2005 09:50:23 -0000	1.95
+++ alsa-kernel/core/oss/pcm_oss.c	9 Aug 2005 21:22:44 -0000
@@ -1705,13 +1705,12 @@
 		if (snd_pcm_running(substream))
 			snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 		snd_pcm_stream_unlock_irq(substream);
-		if (substream->open_flag) {
+		if (substream->ffile != NULL) {
 			if (substream->ops->hw_free != NULL)
 				substream->ops->hw_free(substream);
 			substream->ops->close(substream);
-			substream->open_flag = 0;
+			substream->ffile = NULL;
 		}
-		substream->ffile = NULL;
 		snd_pcm_oss_release_substream(substream);
 		snd_pcm_release_substream(substream);
 	}
@@ -1778,14 +1777,13 @@
 			snd_pcm_oss_release_file(pcm_oss_file);
 			return err;
 		}
-		psubstream->open_flag = 1;
+		psubstream->ffile = file;
 		err = snd_pcm_hw_constraints_complete(psubstream);
 		if (err < 0) {
 			snd_printd("snd_pcm_hw_constraint_complete failed\n");
 			snd_pcm_oss_release_file(pcm_oss_file);
 			return err;
 		}
-		psubstream->ffile = file;
 		snd_pcm_oss_init_substream(psubstream, psetup, minor);
 	}
 	if (csubstream != NULL) {
@@ -1800,14 +1798,13 @@
 			snd_pcm_oss_release_file(pcm_oss_file);
 			return err;
 		}
-		csubstream->open_flag = 1;
+		csubstream->ffile = file;
 		err = snd_pcm_hw_constraints_complete(csubstream);
 		if (err < 0) {
 			snd_printd("snd_pcm_hw_constraint_complete failed\n");
 			snd_pcm_oss_release_file(pcm_oss_file);
 			return err;
 		}
-		csubstream->ffile = file;
 		snd_pcm_oss_init_substream(csubstream, csetup, minor);
 	}
 
Index: alsa-kernel/include/pcm.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/pcm.h,v
retrieving revision 1.54
diff -U3 -r1.54 pcm.h
--- alsa-kernel/include/pcm.h	18 May 2005 17:02:06 -0000	1.54
+++ alsa-kernel/include/pcm.h	9 Aug 2005 21:22:46 -0000
@@ -379,7 +379,6 @@
 	unsigned int dma_buf_id;
 	size_t dma_max;
 	/* -- hardware operations -- */
-	unsigned int open_flag: 1;	/* lowlevel device has been opened */
 	snd_pcm_ops_t *ops;
 	/* -- runtime information -- */
 	snd_pcm_runtime_t *runtime;
Index: alsa-kernel/usb/usx2y/usx2yhwdeppcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usx2yhwdeppcm.c,v
retrieving revision 1.3
diff -U3 -r1.3 usx2yhwdeppcm.c
--- alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	9 Jul 2005 09:54:37 -0000	1.3
+++ alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	9 Aug 2005 21:22:49 -0000
@@ -624,7 +624,7 @@
 		for (s = 0; s < 2; ++s) {
 			snd_pcm_substream_t *substream;
 			substream = pcm->streams[s].substream;
-			if (substream && substream->open_flag)
+			if (substream && substream->ffile != NULL)
 				err = -EBUSY;
 		}
 	}
_
 

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
