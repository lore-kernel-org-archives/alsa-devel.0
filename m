Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD43C1975A
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:14:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B12320663
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DcsztkLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B12320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2802B16EB;
	Thu, 12 Mar 2020 14:13:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2802B16EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584018880;
	bh=9yH0Al04oXTfJ3SBXQl1a8CFW2EDOOtaec6cVwOWdaQ=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=DcsztkLm6Zbc+TBcdGsUtQtkI2B1BidxJflaJX049GBl9LA/6GV2BoCU996L0zK5L
	 bw2mcEnZ1sy5Ib0L84HtC0c4N2805o7YzNfMXNI81BBvmLxU1U+ifEFAYv9N1LYimV
	 RXAt+5VLYNIIpcxPRlnTH8VxtAwr8dpGn4RYps3c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01098F8021C;
	Thu, 12 Mar 2020 14:13:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D48F4F80246; Thu, 12 Mar 2020 14:12:59 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5B0C1F8023F
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 14:12:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B0C1F8023F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 666A630E;
 Thu, 12 Mar 2020 06:12:54 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E02673F534;
 Thu, 12 Mar 2020 06:12:53 -0700 (PDT)
Date: Thu, 12 Mar 2020 13:12:52 +0000
From: Mark Brown <broonie@kernel.org>
To: James Schulman <james.schulman@cirrus.com>
Subject: Applied "MAINTAINERS: Update Cirrus Logic codec driver maintainers"
 to the asoc tree
In-Reply-To: <20200310192751.24487-1-james.schulman@cirrus.com>
Message-Id: <applied-20200310192751.24487-1-james.schulman@cirrus.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 brian.austin@cirrus.com, paul.handrigan@cirrus.com, david.rhodes@cirrus.com,
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

The patch

   MAINTAINERS: Update Cirrus Logic codec driver maintainers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a5107b1a0993ff035dc8a1cf331da7bf961e4cbb Mon Sep 17 00:00:00 2001
From: James Schulman <james.schulman@cirrus.com>
Date: Tue, 10 Mar 2020 14:27:51 -0500
Subject: [PATCH] MAINTAINERS: Update Cirrus Logic codec driver maintainers

Brian & Paul are no longer active audio codec driver
maintainers. Update list to reflect myself and David
Rhodes as the active maintainers.

Signed-off-by: James Schulman <james.schulman@cirrus.com>
Link: https://lore.kernel.org/r/20200310192751.24487-1-james.schulman@cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb6895ba5b9..c6fc68b66434 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3964,8 +3964,8 @@ F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
 F:	sound/soc/codecs/cros_ec_codec.*
 
 CIRRUS LOGIC AUDIO CODEC DRIVERS
-M:	Brian Austin <brian.austin@cirrus.com>
-M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
+M:	James Schulman <james.schulman@cirrus.com>
+M:	David Rhodes <david.rhodes@cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	sound/soc/codecs/cs*
-- 
2.20.1

