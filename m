From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 3/3] ASoC: 88pm860x-codec: Fix possibly missing
	string termination
Date: Tue,  7 Oct 2014 13:41:25 +0200
Message-ID: <1412682085-5217-4-git-send-email-daniel@zonque.org>
References: <1412682085-5217-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id B9B0F26045E
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 13:41:33 +0200 (CEST)
In-Reply-To: <1412682085-5217-1-git-send-email-daniel@zonque.org>
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
Cc: broonie@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Coverity spotted an issue with strncpy() in pm860x_codec_probe()
which does not take the \0 termination byte into account. Fix this
by making the buffers one byte larger so the can really accommodate
MAX_NAME_LEN bytes long strings.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/88pm860x-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 4c3b0af..e88a6b6 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -146,7 +146,7 @@ struct pm860x_priv {
 	struct pm860x_det	det;
 
 	int			irq[4];
-	unsigned char		name[4][MAX_NAME_LEN];
+	unsigned char		name[4][MAX_NAME_LEN+1];
 };
 
 /* -9450dB to 0dB in 150dB steps ( mute instead of -9450dB) */
-- 
2.1.0
