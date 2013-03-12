From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: stream tag should always be non-zero
Date: Tue, 12 Mar 2013 17:06:06 +0100
Message-ID: <1363104366-16026-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F3F265D8F
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 17:06:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Sending zero as stream tag is discouraged, because it means no
data, and the real code doesn't do that. Avoid it here too.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-emu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hda-emu.c b/hda-emu.c
index c98a3ea..13756bb 100644
--- a/hda-emu.c
+++ b/hda-emu.c
@@ -760,7 +760,7 @@ void hda_test_pcm(int id, int op, int subid,
 		}
 		hda_log(HDA_LOG_INFO, "PCM format_val = 0x%x\n", format_val);
 #ifdef HAVE_COMMON_PREPARE
-		err = snd_hda_codec_prepare(_codec, hinfo, subid,
+		err = snd_hda_codec_prepare(_codec, hinfo, subid + 1,
 					    format_val, substream);
 #else
 		err = hinfo->ops.prepare(hinfo, _codec, 1, format_val, substream);
-- 
1.7.9.5
