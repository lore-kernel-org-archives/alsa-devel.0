Return-Path: <SRS0=ZcFB=XS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D36C4CEC4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:58:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC24820882
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ALoRlmHe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="M9bO37xH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC24820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E3821689;
	Mon, 23 Sep 2019 18:57:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E3821689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569257922;
	bh=yDyuhJTc4GCQNP1N3Us0UoYu65kVXYcmjJQ8AR4NaC0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ALoRlmHesnms6h0sRb5GjZJwTjNmQOSGyi5f93++aLc+FT+kBks90fhNah4y8bbhJ
	 fLvhpPgP13JH3Rx2OLciGdpyfWCwEZdloShb8H2ibcMvON7bOWfd+be0Op/R+hefou
	 dVuH02eZmAn+y+bzvmsR029Py024MJLZKkrvHj8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27F8FF8031A;
	Mon, 23 Sep 2019 18:57:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A0BDF8044C; Mon, 23 Sep 2019 18:57:51 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0633BF802BD
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2019 18:57:48 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id D3481A003F;
 Mon, 23 Sep 2019 18:57:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz D3481A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1569257867; bh=EezwiRZi7GU4O0pWBNareXFE/pbNNoPDt3UxFgDBaYk=;
 h=From:To:Cc:Subject:Date:From;
 b=M9bO37xH1zyp2Wj1qT6hPE44EUtsPyeg4v36+VZJKyfjiZ5ynWO3oiUUNbPk0RUeA
 VQIekak0Zcxg+1KURInTRsuf8XdWpbkrL2HD5dWtYJO65kuzNLnbfwPNUgJaIzd8Ne
 0hKdMNE6u/HvgFxMfWawMfi1wlBZMsp4vcPhH9fA=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 23 Sep 2019 18:57:43 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
Date: Mon, 23 Sep 2019 18:57:39 +0200
Message-Id: <20190923165739.3975-1-perex@perex.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH] ASoC: Skylake SST driver - blacklist the PCI
	device IDs for the auto probe
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

There are basically three drivers for the PCI devices for
the recent Intel hardware with the build-in DSPs. The legacy HDA
driver has dmic_detect module option for the auto detection
of the platforms with the digital microphone. Because the SOF
driver is preferred, just skip PCI probe in the Skylake SST
driver when the PCI device ID clashes by default. The user
can override the auto behaviour with the pci_binding
module parameter.

Boot log from Lenovo Carbon X1 (7th gen) with the default settings:

  snd_hda_intel 0000:00:1f.3: Digital mics found on Skylake+ platform, aborting probe
  snd_soc_skl 0000:00:1f.3: SOF driver is preferred on this platform, aborting probe
  sof-audio-pci 0000:00:1f.3: warning: No matching ASoC machine driver found
  sof-audio-pci 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040380
  ....

Perhaps, it may be more wise to create one shared module and all
three drivers should call the driver detection routine(s) from one
place.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 141dbbf975ac..cace55ca8d55 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -38,6 +38,39 @@ static int skl_pci_binding;
 module_param_named(pci_binding, skl_pci_binding, int, 0444);
 MODULE_PARM_DESC(pci_binding, "PCI binding (0=auto, 1=only legacy, 2=only asoc");
 
+/*
+ *
+ */
+static int skl_sof_support(struct pci_dev *pci)
+{
+	/* the SOF driver has same PCI IDs */
+	if (pci->vendor == 0x8086) {
+		switch (pci->device) {
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP)
+		case 0x02c8: /* CML-LP */
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
+		case 0x06c8: /* CML-H */
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
+		case 0x3198: /* GLK */
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
+		case 0x5a98: /* BXT-P */
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_CANNONLAKE)
+		case 0x9dc8: /* CNL */
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COFFEELAKE)
+		case 0xa348: /* CFL */
+#endif
+		case 0x0000: /* a dummy value when no SOF driver enabled */
+			return 1;
+		}
+	}
+	return 0;
+}
+
 /*
  * initialize the PCI registers
  */
@@ -1002,6 +1035,10 @@ static int skl_probe(struct pci_dev *pci,
 			dev_err(&pci->dev, "Unknown PCI class/subclass/prog-if information (0x%06x) found, aborting probe\n", pci->class);
 			return -ENODEV;
 		}
+		if (skl_sof_support(pci)) {
+			dev_info(&pci->dev, "SOF driver is preferred on this platform, aborting probe\n");
+			return -ENODEV;
+		}
 		dev_info(&pci->dev, "DSP detected with PCI class/subclass/prog-if info 0x%06x\n", pci->class);
 		break;
 	case SND_SKL_PCI_BIND_LEGACY:
-- 
2.20.1
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
