Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34F9C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 13:25:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579A36508F
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 13:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579A36508F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 541911763;
	Wed, 10 Mar 2021 14:24:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 541911763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615382710;
	bh=KMb8ucIffYgDmN6VvsdOQ/Oc9zpMgaPIG1XdHkqz0+4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C0bRIwb/BxkL0KTFDtSHV/RF0G02GgXQWeluGg5/v7GMzFjrz4dgpxHnmd8jlTWh1
	 M6pVi7wZ5hfCP8BZCHasm/QRbNgTXm3Kt9YU7QY258QzAOM9izUKbKYBn3pzEVgk9D
	 hvHbHkCwCkYwATVS1rHYXM6Q7bBeLqKib+++7ugs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C536CF8016C;
	Wed, 10 Mar 2021 14:24:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97E54F801D8; Wed, 10 Mar 2021 14:24:18 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6150CF8012F
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 14:24:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6150CF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.b="YuU5aHpE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D56364FD7;
 Wed, 10 Mar 2021 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1615382650;
 bh=KMb8ucIffYgDmN6VvsdOQ/Oc9zpMgaPIG1XdHkqz0+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YuU5aHpEpOEnGe1rm8TgWNAaVK1qv6l6ziW4rrpUtCs7A+ym/sjDganpATKR3GiwF
 2m4XLYYKkAehauLvF+RrGJl1iOncpagCVQm3YWR97R90cWA4+NU7bmar8xnPylLH2b
 cXIa6Htqp91pRplTZxqaeZTnT5yba7YADJJY2s1M=
From: gregkh@linuxfoundation.org
To: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 5.10 02/49] [PATCH v2] ASoC: SOF: Intel: broadwell: fix mutual
 exclusion with catpt driver
Date: Wed, 10 Mar 2021 14:23:13 +0100
Message-Id: <20210310132322.027740959@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210310132321.948258062@linuxfoundation.org>
References: <20210310132321.948258062@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ward <david.ward@ll.mit.edu>, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In v5.10, the "haswell" driver was replaced by the "catpt" driver, but
the mutual exclusion with the SOF driver was not updated. This leads
to errors with card names and UCM profiles not being loaded by
PulseAudio.

This fix should only be applied on v5.10-stable, the mutual exclusion
was removed in 5.11.

Reported-by: David Ward <david.ward@ll.mit.edu>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211985
Fixes: 6cbfa11d2694 ("ASoC: Intel: Select catpt and deprecate haswell")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/intel/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -84,7 +84,7 @@ config SND_SOC_SOF_BAYTRAIL
 
 config SND_SOC_SOF_BROADWELL_SUPPORT
 	bool "SOF support for Broadwell"
-	depends on SND_SOC_INTEL_HASWELL=n
+	depends on SND_SOC_INTEL_CATPT=n
 	help
 	  This adds support for Sound Open Firmware for Intel(R) platforms
 	  using the Broadwell processors.


