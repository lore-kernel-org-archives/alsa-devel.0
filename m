From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] sound: oxygen: simply setting of the shortname
 for Xonar DG cards
Date: Wed, 29 Mar 2017 20:55:50 +0200
Message-ID: <3be118b8-c133-a9e7-4971-bd6d805c47e7@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B5BD6267024
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 20:56:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Eugene Ganeev <easymodofrf@gmail.com>
List-Id: alsa-devel@alsa-project.org

We don't need to manually set the card name; with an entry in the
names[] array, this happens automatically.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/oxygen/oxygen.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/oxygen/oxygen.c b/sound/pci/oxygen/oxygen.c
index 74afb6b75976..e36ed8af55ad 100644
--- a/sound/pci/oxygen/oxygen.c
+++ b/sound/pci/oxygen/oxygen.c
@@ -767,6 +767,8 @@ static int get_oxygen_model(struct oxygen *chip,
 		[MODEL_FANTASIA]	= "TempoTec HiFier Fantasia",
 		[MODEL_SERENADE]	= "TempoTec HiFier Serenade",
 		[MODEL_HG2PCI]		= "CMI8787-HG2PCI",
+		[MODEL_XONAR_DG]        = "Xonar DG",
+		[MODEL_XONAR_DGX]       = "Xonar DGX",
 	};

 	chip->model = model_generic;
@@ -829,12 +831,8 @@ static int get_oxygen_model(struct oxygen *chip,
 		chip->model.dac_channels_mixer = 2;
 		break;
 	case MODEL_XONAR_DG:
-		chip->model = model_xonar_dg;
-		chip->model.shortname = "Xonar DG";
-		break;
 	case MODEL_XONAR_DGX:
 		chip->model = model_xonar_dg;
-		chip->model.shortname = "Xonar DGX";
 		break;
 	}
 	if (id->driver_data == MODEL_MERIDIAN ||
