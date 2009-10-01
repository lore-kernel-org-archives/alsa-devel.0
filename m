From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 24/34] don't use __devexit_p to wrap snd_sgio2audio_remove
Date: Thu,  1 Oct 2009 10:28:28 +0200
Message-ID: <1254385718-14254-24-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091001082607.GA2181@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932314AbZJAI3x@vger.kernel.org>
In-Reply-To: <20091001082607.GA2181@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, "Figo.zhang" <figo1802@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The function snd_sgio2audio_remove is defined using __exit, so don't us=
e
__devexit_p but __exit_p to wrap it.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Figo.zhang <figo1802@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/mips/sgio2audio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index e497525..e24ba5a 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -984,7 +984,7 @@ static int __exit snd_sgio2audio_remove(struct plat=
form_device *pdev)
=20
 static struct platform_driver sgio2audio_driver =3D {
 	.probe	=3D snd_sgio2audio_probe,
-	.remove	=3D __devexit_p(snd_sgio2audio_remove),
+	.remove	=3D __exit_p(snd_sgio2audio_remove),
 	.driver =3D {
 		.name	=3D "sgio2audio",
 		.owner	=3D THIS_MODULE,
--=20
1.6.4.3
