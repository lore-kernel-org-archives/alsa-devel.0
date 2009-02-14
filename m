From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through
	speakers...]
Date: Sat, 14 Feb 2009 17:13:55 -0200
Message-ID: <200902141713.55843.herton@mandriva.com.br>
References: <4983FE7A.1040201@wanadoo.fr>
	<b71cdde20902131122q16eb7e44u92daf2a4c9500bd0@mail.gmail.com>
	<s5hskmhfh9s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zfxlJKjTe+weYNd"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id D2774243AA
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 20:14:02 +0100 (CET)
In-Reply-To: <s5hskmhfh9s.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Tim Barnette <tim.barnette@gmail.com>, Jean-Pierre =?iso-8859-1?q?Andr=E9?= <jean-pierre.andre@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_zfxlJKjTe+weYNd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 14 February 2009 08:24:15 Takashi Iwai wrote:
> At Fri, 13 Feb 2009 14:22:00 -0500,
> Tim Barnette wrote:
> > 
> > ..And it worked!  I now have sound!  Can you tell me what I actually did here?
> 
> The problem was that your BIOS didn't set the correct default pin
> configuration.  The driver doesn't know which pin should be used for
> the speaker output, as a consequence, it's set as INPUT.
> Now you set it OUTPUT manually by hda-verb, and (fortunately) the
> route to that pin was alive even though it wasn't declared, you get
> the speaker output now.
> 
> The next step is to implement a proper pin-config to override by
> the driver.  This won't be much work, but hey, wait for a while.
> 
> (Or, did Herton already work on that?)

I had added before pin configs for which source came from *.ini files of IDT
windows drivers provided by HP. But I don't know if they are at all necessary,
may be just setting config of 0x0d pin should suffice for all hp-dv5 models,
as all of them have speaker on 0x0d from all reports and also looking at the
*.ini files.

I have three patches, you can choose one of them :), see attached. The first
one is my previous pin configs work "let's set for all cases the pin configs
based on *.ini files", the others are same smaller change/less intrusive that
instead just deals with this hp dv4 case.

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > On Fri, Feb 13, 2009 at 2:16 PM, Tim Barnette <tim.barnette@gmail.com> wrote:
> > 
> >     Takashi, I was able to build hda-verb and when I executed the command
> >     below, it responded with:
> >     nid=0xd, verb=0x707, param=0x40
> >     value=0x0
> > 
> >     On Mon, Feb 2, 2009 at 10:25 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >    
> >         At Mon, 2 Feb 2009 10:17:03 -0500,
> >         Tim Barnette wrote:
> >         >
> >         > Thanks, Takashi. I made this change and rebooted.
> >         >
> >         > I noticed right away the mute light is no longer on... but still no
> >         sound
> >         > through speakers, only headphones..
> >         >
> >         > /sys/module/snd_hda_intel/parameters/model
> >         > contains
> >         > hp-dv5,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
> >         >
> >         > attached is the alsa-info.txt you requested..
> >        
> >         Did you try the latest alsa-driver snapshot?
> >        
> >         If it still doesn't work, I guess this is a BIOS problem.
> >         The other HP dv laptops show the widget 0x0d as the speaker while
> >         yours is unused.
> >        
> >         Try to run:
> >                hda-verb /dev/snd/hwC0D0 0x0d SET_PIN_WID 0x40
> > 
> >         Takashi

--
[]'s
Herton

--Boundary-00=_zfxlJKjTe+weYNd
Content-Type: text/x-patch;
  charset="UTF-8";
  name="patch1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch1.patch"

ALSA: hda - Add STAC92HD71B* models for several HP laptops

Add hp-m4-{1,2,3,4,5} models for STAC92HD71B* codecs. Removed
model=hp-dv5, replaced by them.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    5 +
 sound/pci/hda/patch_sigmatel.c               |   91 ++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 0e52d27..0783dc1 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -339,6 +339,11 @@ STAC92HD71B*
   dell-m4-2	Dell desktops
   dell-m4-3	Dell desktops
   hp-m4		HP dv laptops
+  hp-m4-1	HP dv laptops
+  hp-m4-2	HP dv laptops
+  hp-m4-3	HP dv laptops
+  hp-m4-4	HP dv laptops
+  hp-m4-5	HP dv laptops
 
 STAC92HD73*
 ===========
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index aeb5d21..29f3fb7 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -93,7 +93,11 @@ enum {
 	STAC_DELL_M4_2,
 	STAC_DELL_M4_3,
 	STAC_HP_M4,
-	STAC_HP_DV5,
+	STAC_HP_M4_1,
+	STAC_HP_M4_2,
+	STAC_HP_M4_3,
+	STAC_HP_M4_4,
+	STAC_HP_M4_5,
 	STAC_92HD71BXX_MODELS
 };
 
@@ -1793,13 +1797,52 @@ static unsigned int dell_m4_3_pin_configs[STAC92HD71BXX_NUM_PINS] = {
 	0x00000000
 };
 
+static unsigned int hp_m4_1_pin_configs[STAC92HD71BXX_NUM_PINS] = {
+	0x0221201f, 0x02a12050, 0x40f000f0, 0x90170010,
+	0x40f000f1, 0x0221201f, 0x40f000f2, 0x90a60040,
+	0x50f000f3, 0x28466060, 0x50f000f4, 0x00000000,
+	0x90300041,
+};
+
+static unsigned int hp_m4_2_pin_configs[STAC92HD71BXX_NUM_PINS] = {
+	0x0221201f, 0x02a1205e, 0x40f000f1, 0x90170010,
+	0x4080005f, 0x40f000f5, 0x40f000f2, 0x90a60070,
+	0x50f000f3, 0x50f000f4, 0x50f000f5, 0x28466060,
+	0x9030005a,
+};
+
+static unsigned int hp_m4_3_pin_configs[STAC92HD71BXX_NUM_PINS] = {
+	0x0221201f, 0x02a1205e, 0x40f000f1, 0x90170010,
+	0x4080005f, 0x40f000f5, 0x40f000f2, 0x90a60070,
+	0x50f000f3, 0x28466060, 0x50f000f4, 0x40f000f0,
+	0x9030005a,
+};
+
+static unsigned int hp_m4_4_pin_configs[STAC92HD71BXX_NUM_PINS] = {
+	0x0221201f, 0x02a12050, 0x90a70040, 0x90170010,
+	0x40f000f1, 0x40f000f5, 0x40f000f2, 0x50f000f6,
+	0x50f000f3, 0x50f000f7, 0x50f000f4, 0x28466060,
+	0x9030005a,
+};
+
+static unsigned int hp_m4_5_pin_configs[STAC92HD71BXX_NUM_PINS] = {
+	0x0221201f, 0x02a1205e, 0x90a70070, 0x90170010,
+	0x4080005f, 0x40f000f5, 0x40f000f2, 0x50f000f1,
+	0x50f000f3, 0x50f000f6, 0x50f000f4, 0x28466060,
+	0x9030005a,
+};
+
 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
 	[STAC_92HD71BXX_REF] = ref92hd71bxx_pin_configs,
 	[STAC_DELL_M4_1]	= dell_m4_1_pin_configs,
 	[STAC_DELL_M4_2]	= dell_m4_2_pin_configs,
 	[STAC_DELL_M4_3]	= dell_m4_3_pin_configs,
 	[STAC_HP_M4]		= NULL,
-	[STAC_HP_DV5]		= NULL,
+	[STAC_HP_M4_1]		= hp_m4_1_pin_configs,
+	[STAC_HP_M4_2]		= hp_m4_2_pin_configs,
+	[STAC_HP_M4_3]		= hp_m4_3_pin_configs,
+	[STAC_HP_M4_4]		= hp_m4_4_pin_configs,
+	[STAC_HP_M4_5]		= hp_m4_5_pin_configs,
 };
 
 static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
@@ -1808,7 +1851,11 @@ static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
 	[STAC_DELL_M4_2] = "dell-m4-2",
 	[STAC_DELL_M4_3] = "dell-m4-3",
 	[STAC_HP_M4] = "hp-m4",
-	[STAC_HP_DV5] = "hp-dv5",
+	[STAC_HP_M4_1] = "hp-m4-1",
+	[STAC_HP_M4_2] = "hp-m4-2",
+	[STAC_HP_M4_3] = "hp-m4-3",
+	[STAC_HP_M4_4] = "hp-m4-4",
+	[STAC_HP_M4_5] = "hp-m4-5",
 };
 
 static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
@@ -1817,18 +1864,44 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 		      "DFI LanParty", STAC_92HD71BXX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
 		      "DFI LanParty", STAC_92HD71BXX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1505,
+		      "unknown HP", STAC_HP_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30de,
+		      "unknown HP", STAC_HP_M4_1),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f2,
-		      "HP dv5", STAC_HP_M4),
+		      "HP dv5", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f3,
+		      "unknown HP", STAC_HP_M4_2),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f4,
-		      "HP dv7", STAC_HP_DV5),
+		      "HP dv7", STAC_HP_M4_2),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f7,
-		      "HP dv4", STAC_HP_DV5),
+		      "unknown HP", STAC_HP_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f8,
+		      "unknown HP", STAC_HP_M4_5),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fb,
+		      "unknown HP", STAC_HP_M4_2),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fc,
-		      "HP dv7", STAC_HP_M4),
+		      "unknown HP", STAC_HP_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fd,
+		      "unknown HP", STAC_HP_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fe,
+		      "unknown HP", STAC_HP_M4_5),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30ff,
+		      "unknown HP", STAC_HP_M4_4),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3600,
-		      "HP dv5", STAC_HP_DV5),
+		      "unknown HP", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3601,
+		      "unknown HP", STAC_HP_M4_4),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3602,
+		      "unknown HP", STAC_HP_M4_3),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3603,
-		      "HP dv5", STAC_HP_DV5),
+		      "unknown HP", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3607,
+		      "unknown HP", STAC_HP_M4_4),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x360f,
+		      "unknown HP", STAC_HP_M4_3),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3610,
+		      "unknown HP", STAC_HP_M4_3),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x361a,
 				"unknown HP", STAC_HP_M4),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,

--Boundary-00=_zfxlJKjTe+weYNd
Content-Type: text/x-patch;
  charset="UTF-8";
  name="patch2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch2.patch"

ALSA: hda - Fix speaker output on HP DV4 1155-SE

Add new model=hp-dv4 with custom pin configs which fix speaker output
in HP DV4 1155-SE laptop.

Reference: alsa-devel mailing list thread on
    http://mailman.alsa-project.org/pipermail/alsa-devel/2009-February/014390.html

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    2 ++
 sound/pci/hda/patch_sigmatel.c               |   12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 0e52d27..df063ad 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -339,6 +339,8 @@ STAC92HD71B*
   dell-m4-2	Dell desktops
   dell-m4-3	Dell desktops
   hp-m4		HP dv laptops
+  hp-dv4	HP dv laptops
+  hp-dv5	HP dv laptops
 
 STAC92HD73*
 ===========
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index aeb5d21..e8be9f8 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -93,6 +93,7 @@ enum {
 	STAC_DELL_M4_2,
 	STAC_DELL_M4_3,
 	STAC_HP_M4,
+	STAC_HP_DV4,
 	STAC_HP_DV5,
 	STAC_92HD71BXX_MODELS
 };
@@ -1793,12 +1794,20 @@ static unsigned int dell_m4_3_pin_configs[STAC92HD71BXX_NUM_PINS] = {
 	0x00000000
 };
 
+static unsigned int stac_hp_dv4_pin_configs[STAC92HD71BXX_NUM_PINS] = {
+	0x0221201f, 0x02a1205e, 0x40f000f1, 0x90170010,
+	0x4080005f, 0x40f000f5, 0x40f000f2, 0x90a60070,
+	0x50f000f3, 0x50f000f4, 0x50f000f5, 0x28466060,
+	0x9030005a,
+};
+
 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
 	[STAC_92HD71BXX_REF] = ref92hd71bxx_pin_configs,
 	[STAC_DELL_M4_1]	= dell_m4_1_pin_configs,
 	[STAC_DELL_M4_2]	= dell_m4_2_pin_configs,
 	[STAC_DELL_M4_3]	= dell_m4_3_pin_configs,
 	[STAC_HP_M4]		= NULL,
+	[STAC_HP_DV4]		= stac_hp_dv4_pin_configs,
 	[STAC_HP_DV5]		= NULL,
 };
 
@@ -1808,6 +1817,7 @@ static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
 	[STAC_DELL_M4_2] = "dell-m4-2",
 	[STAC_DELL_M4_3] = "dell-m4-3",
 	[STAC_HP_M4] = "hp-m4",
+	[STAC_HP_DV4] = "hp-dv4",
 	[STAC_HP_DV5] = "hp-dv5",
 };
 
@@ -1823,6 +1833,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 		      "HP dv7", STAC_HP_DV5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f7,
 		      "HP dv4", STAC_HP_DV5),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fb,
+		      "HP dv4", STAC_HP_DV4),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fc,
 		      "HP dv7", STAC_HP_M4),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3600,

--Boundary-00=_zfxlJKjTe+weYNd
Content-Type: text/x-patch;
  charset="UTF-8";
  name="patch3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch3.patch"

ALSA: hda - Fix speaker output on HP DV4 1155-SE

Force speaker pin config with model=hp-dv5 model for cases when bios
doesn't set it up properly. All reported hp laptops using model=hp-dv5
model have speaker at pin 0x0d with same config, so it's safe to add
this within hp-dv5 model.

Reference: alsa-devel mailing list thread on
    http://mailman.alsa-project.org/pipermail/alsa-devel/2009-February/014390.html

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_sigmatel.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index aeb5d21..7320059 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1823,6 +1823,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 		      "HP dv7", STAC_HP_DV5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f7,
 		      "HP dv4", STAC_HP_DV5),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fb,
+		      "HP dv7", STAC_HP_DV5),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fc,
 		      "HP dv7", STAC_HP_M4),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x3600,
@@ -5170,6 +5172,10 @@ again:
 		spec->num_smuxes = 0;
 		spec->num_dmuxes = 0;
 		break;
+	case STAC_HP_DV5:
+		stac_change_pin_config(codec, 0x0d, 0x90170010);
+		stac92xx_auto_set_pinctl(codec, 0x0d, AC_PINCTL_OUT_EN);
+		break;
 	};
 
 	spec->multiout.dac_nids = spec->dac_nids;

--Boundary-00=_zfxlJKjTe+weYNd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_zfxlJKjTe+weYNd--
