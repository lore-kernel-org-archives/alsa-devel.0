From: Daniel Ritz <daniel.ritz@gmx.ch>
Subject: [PATCH] snd_opl3sa2: add missing pnp_unregister_driver() calls
Date: Sun, 11 Sep 2005 21:32:05 +0200
Message-ID: <200509112132.05779.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id BFD07186
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2005 21:32:08 +0200 (MEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[PATCH] snd_opl3sa2: add missing pnp_unregister_driver() calls

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -904,6 +904,7 @@ static int __init alsa_card_opl3sa2_init
 #endif
 #ifdef CONFIG_PNP
 		pnp_unregister_card_driver(&opl3sa2_pnpc_driver);
+		pnp_unregister_driver(&opl3sa2_pnp_driver);
 #endif
 		return -ENODEV;
 	}
@@ -917,6 +918,7 @@ static void __exit alsa_card_opl3sa2_exi
 #ifdef CONFIG_PNP
 	/* PnP cards first */
 	pnp_unregister_card_driver(&opl3sa2_pnpc_driver);
+	pnp_unregister_driver(&opl3sa2_pnp_driver);
 #endif
 	for (idx = 0; idx < SNDRV_CARDS; idx++)
 		snd_card_free(snd_opl3sa2_legacy[idx]);


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
