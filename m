Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D194CC47409
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6012D24656
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uUfaSnTf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VFSxg4WU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6012D24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB10A17A3;
	Wed, 15 Jan 2020 15:12:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB10A17A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579097609;
	bh=8CJ3huACP2wP6tvt0V3Kofb5W75235+WoNf8Fwsbjdc=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=uUfaSnTfRvjfKy2rqAAnDTRIye4SJUdJ83OZxnSfuhQTgq8IPQKzbNX8Sd8T2jyrs
	 i96DnXxBcIBCJ4fj/Eejjk+/OLhi/zbkrDjA0ZnxVx0kRjkGJmdMhkKjSVQ/qW48LI
	 SgzA4THxv0OcDll/stkWviG1Ddmt7XqPVW3scsKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C043F8014B;
	Wed, 15 Jan 2020 15:12:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4FF1F801EB; Wed, 15 Jan 2020 15:12:36 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA76CF800CC
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 15:12:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA76CF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="VFSxg4WU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=2cNWU4emOqhh1uZoiTJT3cXK1uSPeOByKAINlbkGams=; b=VFSxg4WUic7z
 8fcCKj8LJGGCPih0mS+d/1FchAsDUqCpwj/IbXgXoalbsrAie2rDGlvAnmOBgUpGcv776Dq2qYuOi
 CpBeIK7/eddLRrAYLaD00JbhadGOrlRhW0VbTglbJV8/4VtqABUR0KsjvuPYHB/eg1bdQl7zvPhY2
 cNifg=;
Received: from fw-tnat-cam5.arm.com ([217.140.106.53]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1irjPI-0005uu-V1; Wed, 15 Jan 2020 14:12:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id AA987D01965; Wed, 15 Jan 2020 14:12:28 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Date: Wed, 15 Jan 2020 14:12:28 +0000 (GMT)
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "regulator fix for "regulator: core: Add
	regulator_is_equal() helper"" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20200115141228.DsI-x6YikELF_ws1vslYQk8eEkWSZPF5ILDHEoLY8aQ@z>

The patch

   regulator fix for "regulator: core: Add regulator_is_equal() helper"

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

From 0468e667a5bead9c1b7ded92861b5a98d8d78745 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 15 Jan 2020 12:02:58 +1100
Subject: [PATCH] regulator fix for "regulator: core: Add regulator_is_equal()
 helper"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/20200115120258.0e535fcb@canb.auug.org.au
Acked-by: Marek Vasut <marex@denx.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regulator/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 2c89d886595c..6a92fd3105a3 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -596,7 +596,7 @@ regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
 }
 
 static inline bool
-regulator_is_equal(struct regulator *reg1, struct regulator *reg2);
+regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
 {
 	return false;
 }
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
