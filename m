From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] ASoC: sta350: Use snd_soc_kcontrol_codec()
Date: Sat, 19 Apr 2014 10:43:56 +0200
Message-ID: <1397897042-20092-2-git-send-email-lars@metafoo.de>
References: <1397897042-20092-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-120.synserver.de
 [212.40.185.120])
 by alsa0.perex.cz (Postfix) with ESMTP id DCBA426172D
 for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2014 10:44:10 +0200 (CEST)
In-Reply-To: <1397897042-20092-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sven Brandau <brandau@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

In preparation for componentisation of the kcontrol helpers use
snd_soc_kcontrol_codec() instead of snd_kcontrol_chip().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sta350.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sta350.c b/sound/soc/codecs/sta350.c
index 552e92a..12ebbaf 100644
--- a/sound/soc/codecs/sta350.c
+++ b/sound/soc/codecs/sta350.c
@@ -309,7 +309,7 @@ static int sta350_coefficient_info(struct snd_kcontrol *kcontrol,
 static int sta350_coefficient_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
 	int numcoef = kcontrol->private_value >> 16;
 	int index = kcontrol->private_value & 0xffff;
@@ -351,7 +351,7 @@ exit_unlock:
 static int sta350_coefficient_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct sta350_priv *sta350 = snd_soc_codec_get_drvdata(codec);
 	int numcoef = kcontrol->private_value >> 16;
 	int index = kcontrol->private_value & 0xffff;
-- 
1.8.0
