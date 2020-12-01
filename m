Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA6C64E7B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:44:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D0021D46
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 08:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PcOkRKX4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcFLHLlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D0021D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10E7417B2;
	Tue,  1 Dec 2020 09:43:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10E7417B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606812270;
	bh=9RERy25JX9EVkTNHA827hHDiWj1hCts0LUZlzdVc0ow=;
	h=Subject:To:From:Date:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=PcOkRKX4nG9bvC8FNmQZc8xFSqc6J7OIkZQVeqnqc+PCKPdDf2jSxgZiyyy9INHJm
	 NwGn6cmpO30mURnr4Z59/T0eGgb7vQ+QyhrPVjCUv8w6IJkpmo6iTtlBt7vv8bYhXY
	 0vthowEDK8rMRiG40YN1wpVDhEbjbYW9CQ++j514=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11D35F804D2;
	Tue,  1 Dec 2020 09:42:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 611A5F804D6; Tue,  1 Dec 2020 09:42:03 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 458D4F804BD
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 09:42:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 458D4F804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="hcFLHLlk"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E773E21D46;
 Tue,  1 Dec 2020 08:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1606812118;
 bh=9RERy25JX9EVkTNHA827hHDiWj1hCts0LUZlzdVc0ow=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=hcFLHLlkEvv46jy1w9C3hDiujjLk/J2teO9IwrzMSiFeto28KZ1fLRfn09i0tQKCO
 w60JM8egtHRribcRf0BJnCHcr+/IUsUMV04JAq8IP7/76yI/7e6X0E6SWB9C6PKw1w
 2NEqynwxbHAmIVmJrOjxnXa+JXX+ELuzmkyZz7KM=
Subject: Patch "ASoC: Intel: Skylake: Enable codec wakeup during chip init"
 has been added to the 5.4-stable tree
To: alsa-devel@alsa-project.org, broonie@kernel.org, cezary.rojewski@intel.com,
 gregkh@linuxfoundation.org, mateusz.gorski@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Dec 2020 09:42:54 +0100
In-Reply-To: <20201129114148.13772-4-cezary.rojewski@intel.com>
Message-ID: <160681217415014@kroah.com>
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

    ASoC: Intel: Skylake: Enable codec wakeup during chip init

to the 5.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     asoc-intel-skylake-enable-codec-wakeup-during-chip-init.patch
and it can be found in the queue-5.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Tue Dec  1 09:41:56 AM CET 2020
From: Cezary Rojewski <cezary.rojewski@intel.com>
Date: Sun, 29 Nov 2020 12:41:43 +0100
Subject: ASoC: Intel: Skylake: Enable codec wakeup during chip init
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com, mateusz.gorski@linux.intel.com, Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <20201129114148.13772-4-cezary.rojewski@intel.com>

From: Cezary Rojewski <cezary.rojewski@intel.com>

commit e603f11d5df8997d104ab405ff27640b90baffaa upstream.

Follow the recommendation set by hda_intel.c and enable HDMI/DP codec
wakeup during bus initialization procedure. Disable wakeup once init
completes.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200305145314.32579-4-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/skylake/skl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -129,6 +129,7 @@ static int skl_init_chip(struct hdac_bus
 	struct hdac_ext_link *hlink;
 	int ret;
 
+	snd_hdac_set_codec_wakeup(bus, true);
 	skl_enable_miscbdcge(bus->dev, false);
 	ret = snd_hdac_bus_init_chip(bus, full_reset);
 
@@ -137,6 +138,7 @@ static int skl_init_chip(struct hdac_bus
 		writel(0, hlink->ml_addr + AZX_REG_ML_LOSIDV);
 
 	skl_enable_miscbdcge(bus->dev, true);
+	snd_hdac_set_codec_wakeup(bus, false);
 
 	return ret;
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
