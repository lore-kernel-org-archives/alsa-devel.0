From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 10/13] sound: fix the comments that refers to kernel-doc
Date: Sun, 14 May 2017 12:38:44 -0300
Message-ID: <3514c2b81341c160bf6753cb47fa2346f3b5a0e7.1494775891.git.mchehab@s-opensource.com>
References: <cover.1494775891.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1494775891.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1494775891.git.mchehab@s-opensource.com>
References: <cover.1494775891.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The markup inside the #if 0 comment actually refers to a
kernel-doc markup. As we're getting rid of DocBook update it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 include/sound/pcm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 361749e60799..bbf97d4c4c17 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1054,7 +1054,7 @@ int snd_pcm_format_unsigned(snd_pcm_format_t format);
 int snd_pcm_format_linear(snd_pcm_format_t format);
 int snd_pcm_format_little_endian(snd_pcm_format_t format);
 int snd_pcm_format_big_endian(snd_pcm_format_t format);
-#if 0 /* just for DocBook */
+#if 0 /* just for kernel-doc */
 /**
  * snd_pcm_format_cpu_endian - Check the PCM format is CPU-endian
  * @format: the format to check
-- 
2.9.3

