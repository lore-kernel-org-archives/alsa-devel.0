From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: bebob: Use common error handling
 code in snd_bebob_stream_start_duplex()
Date: Wed, 6 Sep 2017 12:22:16 +0200
Message-ID: <541f0f9f-fc87-f65b-bbd8-fec5d45d5d2e@users.sourceforge.net>
References: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 497C7266E02
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 12:22:54 +0200 (CEST)
In-Reply-To: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Sep 2017 11:40:53 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/firewire/bebob/bebob_stream.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 4d3034a68bdf..bc9e42b6368e 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -629,8 +629,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 		if (err < 0) {
 			dev_err(&bebob->unit->device,
 				"fail to run AMDTP master stream:%d\n", err);
-			break_both_connections(bebob);
-			goto end;
+			goto break_connections;
 		}
 
 		/*
@@ -644,19 +643,15 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 				dev_err(&bebob->unit->device,
 					"fail to ensure sampling rate: %d\n",
 					err);
-				amdtp_stream_stop(&bebob->rx_stream);
-				break_both_connections(bebob);
-				goto end;
+				goto stop_rx_stream;
 			}
 		}
 
 		/* wait first callback */
 		if (!amdtp_stream_wait_callback(&bebob->rx_stream,
 						CALLBACK_TIMEOUT)) {
-			amdtp_stream_stop(&bebob->rx_stream);
-			break_both_connections(bebob);
 			err = -ETIMEDOUT;
-			goto end;
+			goto stop_rx_stream;
 		}
 	}
 
@@ -666,9 +661,7 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 		if (err < 0) {
 			dev_err(&bebob->unit->device,
 				"fail to run AMDTP slave stream:%d\n", err);
-			amdtp_stream_stop(&bebob->rx_stream);
-			break_both_connections(bebob);
-			goto end;
+			goto stop_rx_stream;
 		}
 
 		/* wait first callback */
@@ -682,6 +675,12 @@ int snd_bebob_stream_start_duplex(struct snd_bebob *bebob, unsigned int rate)
 	}
 end:
 	return err;
+
+stop_rx_stream:
+	amdtp_stream_stop(&bebob->rx_stream);
+break_connections:
+	break_both_connections(bebob);
+	return err;
 }
 
 void snd_bebob_stream_stop_duplex(struct snd_bebob *bebob)
-- 
2.14.1
