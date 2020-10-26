Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474DEC2D0A3
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB2521D41
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m4TpAsv3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0dsSoum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB2521D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8BB316BC;
	Tue, 27 Oct 2020 00:51:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8BB316BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603756324;
	bh=LKn6oqIl5RpMUcNIMotdIsHsUfcUCV5vWMfGhdPikTQ=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m4TpAsv3SlwHoOn4WlyORxMrILQlN7EFOmuCZPLLzhE8qkRK90fX63pr9E74ag3x7
	 vguVgBDaQPU+WyXAArW85f7DRBlB6gRtT0veNPy0wFlXCJVlPWAlWbeSw67rOCRpbe
	 JGblHTDOqtYu8JoY8wpUXsAbYKtrESL7s6i/16GM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 343B2F80526;
	Tue, 27 Oct 2020 00:46:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49312F80527; Tue, 27 Oct 2020 00:46:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED23BF80525
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 00:46:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED23BF80525
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="p0dsSoum"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EC8D320882;
 Mon, 26 Oct 2020 23:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603756001;
 bh=LKn6oqIl5RpMUcNIMotdIsHsUfcUCV5vWMfGhdPikTQ=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=p0dsSoumzWgHa6VY5Ue7pGk9dQ0AM6FOJnMD/FCAZJbBCoRGq/b9E55hCJUvWTQKB
 kNPbOdC9Wj114QRer4SiuUaMgBan9G6DHdLteAAb7RGLLJK9sxeIZl8FGGoYsa91Jh
 N59fzGLSnT0H9ScwBeH2hwEce7Y/hS0iAoC6sAD8=
Date: Mon, 26 Oct 2020 23:46:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, alsa-devel@alsa-project.org
In-Reply-To: <1603476441-3506-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1603476441-3506-1-git-send-email-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: support other audio modes for raven
Message-Id: <160375592348.31132.12853019912954709165.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Prike.Liang@amd.com, Alexander.Deucher@amd.com, Virendra-Pratap.Arya@amd.com,
 Akshu Agrawal <akshu.agrawal@amd.com>, Murali-krishna.Vemuri@amd.com,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Fri, 23 Oct 2020 23:37:17 +0530, Vijendar Mukunda wrote:
> ACP supports different audio configurations other than I2S.
> This patch will fix acp driver probe failure for other audio
> configurations.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: support other audio modes for raven
      commit: efb38304c550cd7abf1a855074a73dc4a8874aa0

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
