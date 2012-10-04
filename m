From: Laurence Darby <ldarby@tuffmail.com>
Subject: [PATCH] stop setup_dig_out_stream() causing clicks
Date: Thu, 4 Oct 2012 21:20:08 +0100
Message-ID: <20121004212008.dd604566.ldarby@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout-07.mxes.net (mxout-07.mxes.net [216.86.168.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 68333261625
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 22:20:12 +0200 (CEST)
Received: from home (unknown [81.187.127.120])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by smtp.mxes.net (Postfix) with ESMTPSA id 093F322E262
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 16:20:10 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Starting audio or seeking in various music players causes
setup_dig_out_stream() to be called, which resets the SPDIF stream,
which caused one DAC (but not another) to make a clicking noise every
time.

This patch turns off codec->spdif_status_reset after one reset which
stops further clicks.  One reset is still necessary to initialise the
codec properly.

Signed-off-by: Laurence Darby <ldarby@tuffmail.com>
---
2nd attempt at this, I hope I'm not doing anything wrong this time.

 sound/pci/hda/hda_codec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 1c65cc5..7742a77 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4731,9 +4731,11 @@ static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 						   format);
 	}
 	/* turn on again (if needed) */
-	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE))
+	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE)) {
 		set_dig_out_convert(codec, nid,
 				    spdif->ctls & 0xff, -1);
+		codec->spdif_status_reset = 0;
+	}
 }
 
 static void cleanup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid)
-- 
1.7.12
