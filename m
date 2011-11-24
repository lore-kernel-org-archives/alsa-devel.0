From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hda - cut and paste typo in
	cs420x_models[]
Date: Thu, 24 Nov 2011 14:48:24 +0300
Message-ID: <20111124114824.GC32522@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by alsa0.perex.cz (Postfix) with ESMTP id E9BFE2451F
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 12:48:51 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, David Henningsson <david.henningsson@canonical.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The CS420X_IMAC27 was copied from the line before but CS420X_APPLE
was clearly intented.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 7bd2a52..70a7abd 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1278,7 +1278,7 @@ static const char * const cs420x_models[CS420X_MODELS] = {
 	[CS420X_MBP53] = "mbp53",
 	[CS420X_MBP55] = "mbp55",
 	[CS420X_IMAC27] = "imac27",
-	[CS420X_IMAC27] = "apple",
+	[CS420X_APPLE] = "apple",
 	[CS420X_AUTO] = "auto",
 };
 
