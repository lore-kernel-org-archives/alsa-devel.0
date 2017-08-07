From: Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] ASoC: compress: Remove duplicated code
Date: Mon, 7 Aug 2017 21:18:09 +0800
Message-ID: <CAErzpmsPRYKmu_CMPPXEohjB-dbuqux4v12t5r9-E6dV3sXnMg@mail.gmail.com>
References: <1502111504-7996-1-git-send-email-pengdonglin137@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F9DD26721A
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 15:18:11 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id t37so401509qtg.2
 for <alsa-devel@alsa-project.org>; Mon, 07 Aug 2017 06:18:11 -0700 (PDT)
In-Reply-To: <1502111504-7996-1-git-send-email-pengdonglin137@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The value of the variable new_name is assigned repeatedly.

Signed-off-by: Peng Donglin <pengdonglin137@163.com>
---
 sound/soc/soc-compress.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 206f36b..2c16f42 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -737,9 +737,6 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime
*rtd, int num)
        }

        /* check client and interface hw capabilities */
-       snprintf(new_name, sizeof(new_name), "%s %s-%d",
-                       rtd->dai_link->stream_name, codec_dai->name, num);
-
        if (codec_dai->driver->playback.channels_min)
                playback = 1;
        if (codec_dai->driver->capture.channels_min)
--
1.9.1
