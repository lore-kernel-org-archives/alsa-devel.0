From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ASoC: rcar: mark device data as constant
Date: Tue, 31 Mar 2015 20:35:09 +0200
Message-ID: <20150331183509.GN17728@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7B324264F0A
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 20:35:12 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Fabian Frederick <fabf@skynet.be>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

A driver's device data should and can be const. This is a follow-up on
commit 33187fb4a203 (ASoC: rsnd: constify of_device_id array) which
marked the of_device_id as const.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
This is also patch 4 of my series[1] which degraded to this hunk when
rebasing to next because all the other changes were already addressed by
Fabian.

Best regards
Uwe

[1] http://thread.gmane.org/gmane.linux.alsa.devel/136241/

 sound/soc/sh/rcar/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 3d8e4d60c83d..9f48d75fa992 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -99,11 +99,11 @@
 #define RSND_RATES SNDRV_PCM_RATE_8000_96000
 #define RSND_FMTS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
 =

-static struct rsnd_of_data rsnd_of_data_gen1 =3D {
+static const struct rsnd_of_data rsnd_of_data_gen1 =3D {
 	.flags =3D RSND_GEN1,
 };
 =

-static struct rsnd_of_data rsnd_of_data_gen2 =3D {
+static const struct rsnd_of_data rsnd_of_data_gen2 =3D {
 	.flags =3D RSND_GEN2,
 };
 =

-- =

2.1.4

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
