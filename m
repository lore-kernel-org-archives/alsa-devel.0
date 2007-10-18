From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: STAC9228 DMIC Support
Date: Thu, 18 Oct 2007 11:22:56 -0400
Message-ID: <47177A50.5040502@embeddedalley.com>
References: <4716580B.3080907@embeddedalley.com> <s5habqhc62p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060304090307010502040000"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by alsa0.perex.cz (Postfix) with SMTP id 3A2A4247BE
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 17:22:55 +0200 (CEST)
In-Reply-To: <s5habqhc62p.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------060304090307010502040000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Wed, 17 Oct 2007 14:44:27 -0400,
> Matthew Ranostay wrote:
>   
>> Added DMIC support for STAC9228 cards, as well as adding terminators to 
>> other hda_nid DMIC arrays, and added a new Vendor ID tag.
>> ---
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
>>     
>
> Thanks.  But, the similar fix was already committed to HG tree (and
> merged to Linus kernel tree, too).  Could you regenerate the patch for
> adding the missing things in your patch?
>
>   
Ok recreated the patch below, by the way your hg-mirror.alsa-project.org 
HG tree seems to be out of sync with hg.alsa-project.org.
> Takashi
>   
Added DMIC support for STAC9228 cards, and a new vendor id tag.
--
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------060304090307010502040000
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9228_dmic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9228_dmic.patch"

diff -r fb9512ce24e0 pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Thu Oct 18 10:48:43 2007 +0200
+++ b/pci/hda/hda_codec.c	Thu Oct 18 11:03:07 2007 -0400
@@ -55,6 +55,7 @@ static struct hda_vendor_id hda_vendor_i
 	{ 0x10ec, "Realtek" },
 	{ 0x1057, "Motorola" },
 	{ 0x1106, "VIA" },
+	{ 0x111d, "IDT" },
 	{ 0x11d4, "Analog Devices" },
 	{ 0x13f6, "C-Media" },
 	{ 0x14f1, "Conexant" },
diff -r fb9512ce24e0 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Oct 18 10:48:43 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Thu Oct 18 11:14:40 2007 -0400
@@ -202,6 +202,11 @@ static hda_nid_t stac927x_adc_nids[3] = 
 
 static hda_nid_t stac927x_mux_nids[3] = {
         0x15, 0x16, 0x17
+};
+
+#define STAC927X_NUM_DMICS 2
+static hda_nid_t stac927x_dmic_nids[STAC927X_NUM_DMICS + 1] = {
+        0x13, 0x14, 0
 };
 
 static hda_nid_t stac9205_adc_nids[2] = {
@@ -2739,7 +2744,6 @@ static int patch_stac927x(struct hda_cod
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
 		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
-		spec->num_dmics = 0;
 		spec->init = d965_core_init;
 		spec->mixer = stac927x_mixer;
 		break;
@@ -2748,7 +2752,6 @@ static int patch_stac927x(struct hda_cod
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
 		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
-		spec->num_dmics = 0;
 		spec->init = d965_core_init;
 		spec->mixer = stac927x_mixer;
 		break;
@@ -2757,9 +2760,18 @@ static int patch_stac927x(struct hda_cod
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
 		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
-		spec->num_dmics = 0;
 		spec->init = stac927x_core_init;
 		spec->mixer = stac927x_mixer;
+	}
+
+	switch (codec->subsystem_id) {
+	case 0x1028020A: /* STAC 9228 */
+	case 0x10280209: /* STAC 9228 */
+		spec->dmic_nids = stac927x_dmic_nids;
+		spec->num_dmics = STAC927X_NUM_DMICS;
+		break;
+	default:
+		spec->num_dmics = 0;	
 	}
 
 	spec->multiout.dac_nids = spec->dac_nids;

--------------060304090307010502040000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060304090307010502040000--
