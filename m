From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Fix bug in snd-usb-usx2y's
	usX2Y_pcms_lock_check()
Date: Tue, 3 Oct 2006 14:33:56 +0200
Message-ID: <200610031433.56957.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Fix bug in snd-usb-usx2y's usX2Y_pcms_lock_check()

substream can be NULL......
in mainline, bug was introduced by:
2006-06-22  [ALSA] Add O_APPEND flag support to PCM

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>



--- alsa-kernel/usb/usx2y/usx2yhwdeppcm.c~	2006-06-29 23:25:30.000000000 +0200
+++ alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	2006-10-03 14:05:12.000000000 +0200
@@ -632,7 +632,7 @@ static int usX2Y_pcms_lock_check(struct 
 		for (s = 0; s < 2; ++s) {
 			struct snd_pcm_substream *substream;
 			substream = pcm->streams[s].substream;
-			if (SUBSTREAM_BUSY(substream))
+			if (substream && SUBSTREAM_BUSY(substream))
 				err = -EBUSY;
 		}
 	}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
