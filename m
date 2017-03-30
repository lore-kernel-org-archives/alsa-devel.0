From: Eugene Ganeev <easymodofrf@gmail.com>
Subject: Re: [PATCH] ALSA: oxygen - Fix snd_oxygen module not loading for
 some (new?) Xonar DG SI cards.
Date: Thu, 30 Mar 2017 03:55:08 +0100
Message-ID: <20170330025507.GA961@unit02.localdomain>
References: <20170329211311.GA4751@unit02.localdomain>
 <51152705-a2af-f1d9-b51a-019237e9d334@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51152705-a2af-f1d9-b51a-019237e9d334@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 29, 2017 at 08:56:16PM +0200, Clemens Ladisch wrote:
> Eugene Ganeev wrote:
> > My Xonar DG SI card is showing up in lspci but no module is loaded for
> > it.
> >
> > The patch just adds a new value with card's PCI ID to oxygen_ids array.
> 
> Is the hardware identical?  Do all the inputs and outputs work?
 
According to asus website they both use C-MEDIA CMI8786. The difference is that DG SI is 7.1 surround compared to 5.1 in DG.
I've tested the patch, all ports seem to work except rear out. So basically the card is usable unless you use 7.1 setup. 

> Please add the correct name to the names[] array.
> 
> 
> Regards.
> Clemens.

[PATCH v2] sound: oxygen: add Xonar DG SI support

Add PCI ID for the Asus Xonar DG SI card.

Signed-off-by: Eugene Ganeev <easymodofrf@gmail.com>

---

v2:
	- Added model name to names[] array.

 sound/pci/oxygen/oxygen.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/oxygen/oxygen.c b/sound/pci/oxygen/oxygen.c
index 74afb6b75976..7ba1099fefb1 100644
--- a/sound/pci/oxygen/oxygen.c
+++ b/sound/pci/oxygen/oxygen.c
@@ -94,6 +94,7 @@ enum {
 	MODEL_2CH_OUTPUT,
 	MODEL_HG2PCI,
 	MODEL_XONAR_DG,
+	MODEL_XONAR_DG_SI,
 	MODEL_XONAR_DGX,
 };
 
@@ -110,6 +111,8 @@ static const struct pci_device_id oxygen_ids[] = {
 	{ OXYGEN_PCI_SUBID(0x1a58, 0x0910), .driver_data = MODEL_CMEDIA_REF },
 	/* Asus Xonar DG */
 	{ OXYGEN_PCI_SUBID(0x1043, 0x8467), .driver_data = MODEL_XONAR_DG },
+	/* Asus Xonar DG SI */
+	{ OXYGEN_PCI_SUBID(0x1043, 0x855e), .driver_data = MODEL_XONAR_DG_SI },
 	/* Asus Xonar DGX */
 	{ OXYGEN_PCI_SUBID(0x1043, 0x8521), .driver_data = MODEL_XONAR_DGX },
 	/* PCI 2.0 HD Audio */
@@ -767,6 +770,7 @@ static int get_oxygen_model(struct oxygen *chip,
 		[MODEL_FANTASIA]	= "TempoTec HiFier Fantasia",
 		[MODEL_SERENADE]	= "TempoTec HiFier Serenade",
 		[MODEL_HG2PCI]		= "CMI8787-HG2PCI",
+		[MODEL_XONAR_DG_SI]	= "Asus Xonar DG SI",
 	};
 
 	chip->model = model_generic;
@@ -832,6 +836,9 @@ static int get_oxygen_model(struct oxygen *chip,
 		chip->model = model_xonar_dg;
 		chip->model.shortname = "Xonar DG";
 		break;
+	case MODEL_XONAR_DG_SI:
+		chip->model = model_xonar_dg;
+		break;
 	case MODEL_XONAR_DGX:
 		chip->model = model_xonar_dg;
 		chip->model.shortname = "Xonar DGX";
