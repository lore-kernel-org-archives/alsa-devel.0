From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC: pcm: Fix lack of platform bespoke_trigger() call
Date: Fri, 3 Jan 2014 09:19:18 +0100
Message-ID: <20140103091918.7387cfb5@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When the platform driver has no ops, the platform function
bespoke_trigger() is no more called.

The problem was introduced by the commit c5914b0aaea6494aaa9e415cbd32f8=
b7eb604af0
	"ASoC: pcm: Check for ops before deferencing them"

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 891b9a9..df79101 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -672,7 +672,7 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_s=
ubstream *substream,
 			return ret;
 	}
=20
-	if (platform->driver->ops && platform->driver->bespoke_trigger) {
+	if (platform->driver->bespoke_trigger) {
 		ret =3D platform->driver->bespoke_trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
