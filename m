Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C02C64E7B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:45:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB775216C4
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nIXOmiyD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nrzrq/m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB775216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 584B917C2;
	Tue,  1 Dec 2020 09:44:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 584B917C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606812323;
	bh=RQS70zulLhQF5e3TSTIppNgPua70WNZc2op4BuyKKEs=;
	h=Subject:To:From:Date:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=nIXOmiyDPNJxNgJWIFRn3czP2ZCMzCpS09HAhGKBNBIbMAE4uDkWHAnCET4vMYpZj
	 zWXnOEVLNqcmUh/HXrxkkjhXbryJJhMsQM4ay8LMEKKcE1M+In818lgmpid7rMY7PO
	 zVJzVX2ZwHTtHUJKXZ4A7nafd00r0e48P5Ktjmdo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 341A8F804F1;
	Tue,  1 Dec 2020 09:42:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBD74F804F1; Tue,  1 Dec 2020 09:42:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17964F804E6
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 09:42:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17964F804E6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="Nrzrq/m+"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF80A21D7F;
 Tue,  1 Dec 2020 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1606812124;
 bh=RQS70zulLhQF5e3TSTIppNgPua70WNZc2op4BuyKKEs=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=Nrzrq/m+kfD9RdW47V0NU0o1SzY+hCGXKcyAQs5y39mvTrMmRjMiVFaXezprryN23
 ZuK3i2s5MEgSnqqcIkcuY8k6xz17M/IxLqB+n7Vc/Mw1PxTGv6KQHjHMxt8LNS6ldr
 erV6PDxwMQer8kN4apMDhz2umW1+cE41ubGdCePQ=
Subject: Patch "ASoC: Intel: Skylake: Shield against no-NHLT configurations"
 has been added to the 5.4-stable tree
To: alsa-devel@alsa-project.org, broonie@kernel.org, cezary.rojewski@intel.com,
 gregkh@linuxfoundation.org, mateusz.gorski@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Dec 2020 09:42:55 +0100
In-Reply-To: <20201129114148.13772-5-cezary.rojewski@intel.com>
Message-ID: <160681217517195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


This is a note to let you know that I've just added the patch titled

    ASoC: Intel: Skylake: Shield against no-NHLT configurations

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     asoc-intel-skylake-shield-against-no-nhlt-configurations.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Tue Dec  1 09:41:56 AM CET 2020
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Sun, 29 Nov 2020 12:41:44 +0100
Subject: ASoC: Intel: Skylake: Shield against no-NHLT configurations
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com, mateusz.gorski@linux.intel.com, Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <20201129114148.13772-5-cezary.rojewski@intel.com>

From: Cezary Rojewski <cezary.rojewski@intel.com>

commit 9e6c382f5a6161eb55115fb56614b9827f2e7da3 upstream.

Some configurations expose no NHLT table at all within their
/sys/firmware/acpi/tables. To prevent NULL-dereference errors from
occurring, adjust probe flow and append additional safety checks in
functions involved in NHLT lifecycle.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-5-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/skylake/skl-nhlt.c |    3 ++-
 sound/soc/intel/skylake/skl.c      |    9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -182,7 +182,8 @@ void skl_nhlt_remove_sysfs(struct skl_de
 {
 	struct device *dev = &skl->pci->dev;
 
-	sysfs_remove_file(&dev->kobj, &dev_attr_platform_id.attr);
+	if (skl->nhlt)
+		sysfs_remove_file(&dev->kobj, &dev_attr_platform_id.attr);
 }
 
 /*
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -632,6 +632,9 @@ static int skl_clock_device_register(str
 	struct platform_device_info pdevinfo = {NULL};
 	struct skl_clk_pdata *clk_pdata;
 
+	if (!skl->nhlt)
+		return 0;
+
 	clk_pdata = devm_kzalloc(&skl->pci->dev, sizeof(*clk_pdata),
 							GFP_KERNEL);
 	if (!clk_pdata)
@@ -1090,7 +1093,8 @@ out_dsp_free:
 out_clk_free:
 	skl_clock_device_unregister(skl);
 out_nhlt_free:
-	intel_nhlt_free(skl->nhlt);
+	if (skl->nhlt)
+		intel_nhlt_free(skl->nhlt);
 out_free:
 	skl_free(bus);
 
@@ -1139,7 +1143,8 @@ static void skl_remove(struct pci_dev *p
 	skl_dmic_device_unregister(skl);
 	skl_clock_device_unregister(skl);
 	skl_nhlt_remove_sysfs(skl);
-	intel_nhlt_free(skl->nhlt);
+	if (skl->nhlt)
+		intel_nhlt_free(skl->nhlt);
 	skl_free(bus);
 	dev_set_drvdata(&pci->dev, NULL);
 }


Patches currently in stable-queue which might be from cezary.rojewski@intel.com are

queue-5.4/asoc-intel-skylake-select-hda-configuration-permissively.patch
queue-5.4/asoc-intel-skylake-enable-codec-wakeup-during-chip-init.patch
queue-5.4/asoc-intel-allow-for-rom-init-retry-on-cnl-platforms.patch
queue-5.4/asoc-intel-skylake-await-purge-request-ack-on-cnl.patch
queue-5.4/asoc-intel-skylake-remove-superfluous-chip-initialization.patch
queue-5.4/asoc-intel-skylake-shield-against-no-nhlt-configurations.patch
queue-5.4/asoc-intel-multiple-i-o-pcm-format-support-for-pipe.patch
queue-5.4/asoc-intel-skylake-automatic-dmic-format-configuration-according-to-information-from-nhlt.patch
