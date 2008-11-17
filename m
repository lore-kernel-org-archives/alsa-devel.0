From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH] hda: alc883 model for ASUS P5Q-EM boards
Date: Mon, 17 Nov 2008 08:50:38 +0800
Message-ID: <20081117005038.GA5683@localhost>
References: <6d799ca1be9af898f664f82ade06d669@localhost>
	<20081115002724.GA5073@mail.ustc.edu.cn>
	<002f01c94770$adeba2a0$09c2e7e0$@ca>
	<20081116021525.GA7795@localhost>
	<003801c947b4$b857ffb0$2907ff10$@ca>
	<20081116082733.GA20129@localhost>
	<006001c94813$134a8880$39df9980$@ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id DE7351037EE
	for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2008 01:50:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <006001c94813$134a8880$39df9980$@ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrei Tanas <andrei@tanas.ca>
Cc: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 16, 2008 at 12:45:12PM -0500, Andrei Tanas wrote:
> > > How did you find out that it's 0x10 instead of 0x06? Has
> > documentation on
> > > ALC1200 become available?
> > 
> > It's easy:
> > grep -i -C6 spdif /proc/asound/card0/codec\#0
> > grep -i -C6 'stereo digital' /proc/asound/card0/codec\#0
> > 
> > And check the connectivity between pin complex and audio output nodes.
> That's the kind of stuff that would be great to know for somebody who wants
> to troubleshoot something for the first time. Thanks.

You are welcome.

> > Now you can do a 'cat /proc/asound/card0/codec\#1' and read about the
> > HDMI codec. For it to work, you may need the bleeding edge Xorg
> > drivers.
> That will be for somebody else to test I guess, I don't have the hardware -
> it turns out my TV does not take digital audio through its HDMI port.

That's fine.

The G45 HDMI has worked on our boards, so chances are good for others.

> > So let's create a new model?
> I should have gave it a shot myself I guess.
> 
> > +#define ALC883_DIGOUT_NID_ASUS_P5Q	0x10
> Why not ALC1200_DIGOUT_NID? Or is it really specific to Asus P5Q?

I'm not really sure, but ALC1200_DIGOUT_NID does look like a better name :-)

> The patch worked perfectly.

Thank you.

Fengguang
---

hda: alc883 model for ASUS P5Q-EM boards

Add a new alc883 model ALC1200_ASUS_P5Q for ASUS P5Q-EM boards.
It is the same as ALC883_6ST_DIG except that the SPDIF digital
output nid is 0x10.

Tested-by: Andrei Tanas <andrei@tanas.ca>
Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_realtek.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- sound-2.6.orig/sound/pci/hda/patch_realtek.c
+++ sound-2.6/sound/pci/hda/patch_realtek.c
@@ -232,6 +232,7 @@ enum {
 	ALC883_3ST_6ch_INTEL,
 	ALC888_ASUS_M90V,
 	ALC888_ASUS_EEE1601,
+	ALC1200_ASUS_P5Q,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -6868,6 +6869,8 @@ static int patch_alc882(struct hda_codec
 #define ALC883_DIGOUT_NID	0x06
 #define ALC883_DIGIN_NID	0x0a
 
+#define ALC1200_DIGOUT_NID	0x10
+
 static hda_nid_t alc883_dac_nids[4] = {
 	/* front, rear, clfe, rear_surr */
 	0x02, 0x03, 0x04, 0x05
@@ -8190,6 +8193,7 @@ static const char *alc883_models[ALC883_
 	[ALC883_CLEVO_M720]	= "clevo-m720",
 	[ALC883_FUJITSU_PI2515] = "fujitsu-pi2515",
 	[ALC883_3ST_6ch_INTEL]	= "3stack-6ch-intel",
+	[ALC1200_ASUS_P5Q]	= "asus-p5q",
 	[ALC883_AUTO]		= "auto",
 };
 
@@ -8208,6 +8212,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x103c, 0x2a61, "HP Nettle", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x1873, "Asus M90V", ALC888_ASUS_M90V),
 	SND_PCI_QUIRK(0x1043, 0x8249, "Asus M2A-VM HDMI", ALC883_3ST_6ch_DIG),
+	SND_PCI_QUIRK(0x1043, 0x82fe, "Asus P5Q-EM HDMI", ALC1200_ASUS_P5Q),
 	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_ASUS_EEE1601),
 	SND_PCI_QUIRK(0x105b, 0x0ce8, "Foxconn P35AX-S", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x105b, 0x6668, "Foxconn", ALC883_6ST_DIG),
@@ -8555,6 +8560,17 @@ static struct alc_config_preset alc883_p
 		.unsol_event = alc883_eee1601_unsol_event,
 		.init_hook = alc883_eee1601_inithook,
 	},
+	[ALC1200_ASUS_P5Q] = {
+		.mixers = { alc883_base_mixer, alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC1200_DIGOUT_NID,
+		.dig_in_nid = ALC883_DIGIN_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
+		.channel_mode = alc883_sixstack_modes,
+		.input_mux = &alc883_capture_source,
+	},
 };
