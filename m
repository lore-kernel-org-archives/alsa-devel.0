From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] ASoC: WM8958: correctly show firmware magic on mismatch
Date: Sun, 11 Dec 2011 19:15:49 +0100
Message-ID: <1323627349-2488-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
This patch is untested.

 sound/soc/codecs/wm8958-dsp2.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-d=
sp2.c
index 0293763..5a14d5c 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -60,6 +60,8 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec=
, const char *name,
 	}
=20
 	if (memcmp(fw->data, "WMFW", 4) !=3D 0) {
+		memcpy(&data32, fw->data, sizeof(data32));
+		data32 =3D be32_to_cpu(data32);
 		dev_err(codec->dev, "%s: firmware has bad file magic %08x\n",
 			name, data32);
 		goto err;
--=20
1.7.7.3
