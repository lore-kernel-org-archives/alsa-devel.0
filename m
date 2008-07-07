From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: removed redundant gpio_mask
Date: Mon, 07 Jul 2008 17:51:27 -0400
Message-ID: <48728FDF.3040807@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 5C73624701
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jul 2008 23:51:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

An gpio_mask value was defined twice needlessly.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index c4f3489..a6d1388 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -3669,7 +3669,6 @@ again:
 	/* GPIO0 High = EAPD */
 	spec->gpio_mask = 0x01;
 	spec->gpio_dir = 0x01;
-	spec->gpio_mask = 0x01;
 	spec->gpio_data = 0x01;

 	spec->mux_nids = stac92hd71bxx_mux_nids;
