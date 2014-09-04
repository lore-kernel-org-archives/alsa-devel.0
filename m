From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/5] hda-emu: Quit early if requested codec
	index is above limit
Date: Thu,  4 Sep 2014 14:21:04 +0200
Message-ID: <1409833267-9778-3-git-send-email-david.henningsson@canonical.com>
References: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4DB2658A1
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 14:21:07 +0200 (CEST)
In-Reply-To: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-parse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hda-parse.c b/hda-parse.c
index d9fc311..57e9ee3 100644
--- a/hda-parse.c
+++ b/hda-parse.c
@@ -687,6 +687,11 @@ int parse_codec_proc(FILE *fp, struct xhda_codec *codecp, int codec_index)
 		}
 	}
 
+	if (curidx < codec_index) {
+		hda_log(HDA_LOG_ERR, "Codec index %d requested, but found only %d codecs\n", codec_index, curidx+1);
+		return -ENODEV;
+	}
+
 	add_codec_extensions(codec);
 
 	return 0;
-- 
1.9.1
