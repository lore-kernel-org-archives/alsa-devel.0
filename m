Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC97C64E7A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 13:59:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C705F21D7A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 13:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pcSphEnd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6dIZxMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C705F21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD09317AC;
	Tue,  1 Dec 2020 14:58:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD09317AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606831172;
	bh=ZciRQ0clP47O2viwbKF2X3XIXX0D+EsIIPHiUJWV+yQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pcSphEndWJ58Ee1ZNKIcpSifjHmGY16c8o/GmHKEDz71KXpbLYETmYB51IUyJAyYC
	 xc2UIEeMkW++Vz9dSfPeQoLcLxTaZXfZq0PAquKJEhGbzd84ml5BFTi7mFLIA+TtgV
	 7KxxPjbwkP1tt0xEwO+a4u32Kg4WKsXWJmgHf2a4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6146EF8016D;
	Tue,  1 Dec 2020 14:58:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81883F80254; Tue,  1 Dec 2020 14:58:40 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DF1FF80158
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 14:58:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DF1FF80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="I6dIZxMU"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4AB47206A5;
 Tue,  1 Dec 2020 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606831105;
 bh=ZciRQ0clP47O2viwbKF2X3XIXX0D+EsIIPHiUJWV+yQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=I6dIZxMUSZw5LJ3shd89RuTmtg360kVOOA2fGx4s5axpSNRlbHmBC5a3eKkZHYxmI
 MPFffHppvt8NQevpinVzBgb+PspgvKNYeYwlacpuXQ7QjEfjUq2tdx12drh+qIzCJ7
 QL6emIYViGizSLXptkGIqN/S81VItMlCGYboYyKU=
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, lgirdwood@gmail.com, grandmaster@al2klimov.de,
 perex@perex.cz, dmurphy@ti.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, tiwai@suse.com
In-Reply-To: <20201002192801.639743-1-christophe.jaillet@wanadoo.fr>
References: <20201002192801.639743-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix a typo in a comment
Message-Id: <160683107674.35139.8370464905366539450.b4-ty@kernel.org>
Date: Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On Fri, 2 Oct 2020 21:28:01 +0200, Christophe JAILLET wrote:
> It is likely that this header file is about the TLV320ADCX140. (0 and 4
> swapped)
> While at it fix a missing "H" in a comment related to the include guard.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix a typo in a comment
      (no commit info)

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
