From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Add STAC_DELL_M4_3 quirk
Date: Thu, 20 Nov 2008 20:31:16 -0500
Message-ID: <49260F64.5040303@embeddedalley.com>
References: <4924D013.2020107@embeddedalley.com> <s5h8wreooic.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 7A518243A0
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 02:31:29 +0100 (CET)
In-Reply-To: <s5h8wreooic.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 19 Nov 2008 21:48:51 -0500,
> Matthew Ranostay wrote:
>> Add PCI quirk STAC_DELL_M4_3 for 92hd71bxx based laptops.
> 
> Which laptops, more exactly?  Recently I received bug reports about
> Dell Studio laptops, and wondering whether it's for such models.
> 
> 
>> @@ -4650,14 +4661,20 @@ again:
>>
>>  	switch (spec->board_config) {
>>  	case STAC_HP_M4:
>> -		spec->num_dmics = 0;
>> -		spec->num_smuxes = 0;
>> -		spec->num_dmuxes = 0;
>> -
>>  		/* enable internal microphone */
>>  		stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
>>  		stac92xx_auto_set_pinctl(codec, 0x0e,
>>  			AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
> 
> Please add a comment about fall-through here.
> 
> Also, update Documentation/*/ALSA-Configuration.txt as well.
> 
> 
> thanks,
> 
> Takashi
> 

Add PCI quirk STAC_DELL_M4_3 for 92hd71bxx based laptops and desktops.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/Documentation/ALSA-Configuration.txt
b/Documentation/ALSA-Configuration.txt
index 3ab5fb1..8b99a22 100644
--- a/Documentation/ALSA-Configuration.txt
+++ b/Documentation/ALSA-Configuration.txt
@@ -1076,6 +1076,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix.
This was removed.
 	  ref		Reference board
 	  dell-m4-1	Dell desktops
 	  dell-m4-2	Dell desktops
+	  dell-m4-3	Dell desktops

 	STAC92HD73*
 	  ref		Reference board
diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index e0298df..f1a0f13 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -83,6 +83,7 @@ enum {
 	STAC_92HD71BXX_REF,
 	STAC_DELL_M4_1,
 	STAC_DELL_M4_2,
+	STAC_DELL_M4_3,
 	STAC_HP_M4,
 	STAC_92HD71BXX_MODELS
 };
@@ -1689,10 +1690,17 @@ static unsigned int dell_m4_2_pin_configs[11] = {
 	0x40f000f0, 0x044413b0, 0x044413b0,
 };

+static unsigned int dell_m4_3_pin_configs[11] = {
+	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
+	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x90a000f0,
+	0x40f000f0, 0x044413b0, 0x044413b0,
+};
+
 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
 	[STAC_92HD71BXX_REF] = ref92hd71bxx_pin_configs,
 	[STAC_DELL_M4_1]	= dell_m4_1_pin_configs,
 	[STAC_DELL_M4_2]	= dell_m4_2_pin_configs,
+	[STAC_DELL_M4_3]	= dell_m4_3_pin_configs,
 	[STAC_HP_M4]		= NULL,
 };

@@ -1700,6 +1708,7 @@ static const char
*stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
 	[STAC_92HD71BXX_REF] = "ref",
 	[STAC_DELL_M4_1] = "dell-m4-1",
 	[STAC_DELL_M4_2] = "dell-m4-2",
+	[STAC_DELL_M4_3] = "dell-m4-3",
 	[STAC_HP_M4] = "hp-m4",
 };

@@ -1731,6 +1740,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 				"unknown Dell", STAC_DELL_M4_2),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0264,
 				"unknown Dell", STAC_DELL_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x02aa,
+				"unknown Dell", STAC_DELL_M4_3),
 	{} /* terminator */
 };

@@ -4650,14 +4661,21 @@ again:

 	switch (spec->board_config) {
 	case STAC_HP_M4:
-		spec->num_dmics = 0;
-		spec->num_smuxes = 0;
-		spec->num_dmuxes = 0;
-
 		/* enable internal microphone */
 		stac92xx_set_config_reg(codec, 0x0e, 0x01813040);
 		stac92xx_auto_set_pinctl(codec, 0x0e,
 			AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
+		/* fallthru */
+	case STAC_DELL_M4_2:
+		spec->num_dmics = 0;
+		spec->num_smuxes = 0;
+		spec->num_dmuxes = 0;
+		break;
+	case STAC_DELL_M4_1:
+	case STAC_DELL_M4_3:
+		spec->num_dmics = 1;
+		spec->num_smuxes = 0;
+		spec->num_dmuxes = 0;
 		break;
 	default:
 		spec->num_dmics = STAC92HD71BXX_NUM_DMICS;
