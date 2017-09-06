From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: FireWire-MOTU: Use common error handling
 code in snd_motu_stream_start_duplex()
Date: Wed, 6 Sep 2017 13:35:51 +0200
Message-ID: <9f50358a-0357-82ec-ee38-deae60eb53e9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D5DD266E02
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 13:36:03 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Sep 2017 13:30:14 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/firewire/motu/motu-stream.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index dc5541c8b359..73e7a5e527fc 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -253,24 +253,21 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 		if (err < 0) {
 			dev_err(&motu->unit->device,
 				"fail to start isochronous comm: %d\n", err);
-			stop_both_streams(motu);
-			return err;
+			goto stop_streams;
 		}
 
 		err = start_isoc_ctx(motu, &motu->rx_stream);
 		if (err < 0) {
 			dev_err(&motu->unit->device,
 				"fail to start IT context: %d\n", err);
-			stop_both_streams(motu);
-			return err;
+			goto stop_streams;
 		}
 
 		err = protocol->switch_fetching_mode(motu, true);
 		if (err < 0) {
 			dev_err(&motu->unit->device,
 				"fail to enable frame fetching: %d\n", err);
-			stop_both_streams(motu);
-			return err;
+			goto stop_streams;
 		}
 	}
 
@@ -281,12 +278,15 @@ int snd_motu_stream_start_duplex(struct snd_motu *motu, unsigned int rate)
 			dev_err(&motu->unit->device,
 				"fail to start IR context: %d", err);
 			amdtp_stream_stop(&motu->rx_stream);
-			stop_both_streams(motu);
-			return err;
+			goto stop_streams;
 		}
 	}
 
 	return 0;
+
+stop_streams:
+	stop_both_streams(motu);
+	return err;
 }
 
 void snd_motu_stream_stop_duplex(struct snd_motu *motu)
-- 
2.14.1
