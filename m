From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/core/pcm.c: make snd_pcm_format_name() static
Date: Tue, 11 Apr 2006 00:18:01 +0200
Message-ID: <20060410221801.GK2408__36009.733627043$1144707559$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id EEAF8188
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 00:18:00 +0200 (MEST)
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
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch makes the needlessly global snd_pcm_format_name() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/sound/pcm.h |    1 -
 sound/core/pcm.c    |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.17-rc1-mm2-full/include/sound/pcm.h.old	2006-04-10 23:34:28.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/include/sound/pcm.h	2006-04-10 23:34:38.000000000 +0200
@@ -898,7 +898,6 @@
 const unsigned char *snd_pcm_format_silence_64(snd_pcm_format_t format);
 int snd_pcm_format_set_silence(snd_pcm_format_t format, void *buf, unsigned int frames);
 snd_pcm_format_t snd_pcm_build_linear_format(int width, int unsignd, int big_endian);
-const char *snd_pcm_format_name(snd_pcm_format_t format);
 
 void snd_pcm_set_ops(struct snd_pcm * pcm, int direction, struct snd_pcm_ops *ops);
 void snd_pcm_set_sync(struct snd_pcm_substream *substream);
--- linux-2.6.17-rc1-mm2-full/sound/core/pcm.c.old	2006-04-10 23:32:17.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/sound/core/pcm.c	2006-04-10 23:32:42.000000000 +0200
@@ -196,7 +196,7 @@
 	FORMAT(U18_3BE),
 };
 
-const char *snd_pcm_format_name(snd_pcm_format_t format)
+static const char *snd_pcm_format_name(snd_pcm_format_t format)
 {
 	return snd_pcm_format_names[format];
 }



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
