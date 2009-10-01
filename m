From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 06/34] don't use __devexit_p to wrap hal2_remove
Date: Thu,  1 Oct 2009 10:28:10 +0200
Message-ID: <1254385718-14254-6-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091001082607.GA2181@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932349AbZJAIcF@vger.kernel.org>
In-Reply-To: <20091001082607.GA2181@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The function hal2_remove is defined using __exit, so don't use __devexi=
t_p
but __exit_p to wrap it.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/mips/hal2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index c52691c..72523a7 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -926,7 +926,7 @@ static int __exit hal2_remove(struct platform_devic=
e *pdev)
=20
 static struct platform_driver hal2_driver =3D {
 	.probe	=3D hal2_probe,
-	.remove	=3D __devexit_p(hal2_remove),
+	.remove	=3D __exit_p(hal2_remove),
 	.driver =3D {
 		.name	=3D "sgihal2",
 		.owner	=3D THIS_MODULE,
--=20
1.6.4.3
