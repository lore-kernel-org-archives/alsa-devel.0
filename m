Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B0BC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 16:31:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0CC208D5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 16:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0CC208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB849167D;
	Mon, 11 Jan 2021 17:31:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB849167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610382710;
	bh=aSEP22RVIp/nVYRhctvQJEglPOgklG5HtjTl5BfbCkE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vFrOnU1a9wN2/oYBgVNOVBkETlg0JdezI2W3lF4bsS9vWxGQGt/1ZxsHW3ucCplTA
	 M1vGfgrtHMP1S1SV1YmcurpqbxC1yynf/gbf7PtJ23cjA7HBQ/5LyUrOESDFtuwzeQ
	 cVVterPryJlXiPiVMuFX7EMoYn0QTeDO/5QDctvQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48032F804EB;
	Mon, 11 Jan 2021 17:28:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CDDDF804E3; Mon, 11 Jan 2021 17:28:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24A3BF804E0
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 17:28:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24A3BF804E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Xbv/W/pq"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C00D22B30;
 Mon, 11 Jan 2021 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610382518;
 bh=aSEP22RVIp/nVYRhctvQJEglPOgklG5HtjTl5BfbCkE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Xbv/W/pqgqqIExXYNi2EDYMrMUgRROcOifZUtDfEysa3+N5ju3TaTdmW73Au70hZJ
 q4daF5k1TwEttx1mH3mPBKutryk8lioK2KIra3FmQwqEvxQf0eZITTqjpYQlM5RTq+
 QP6MC1EUhQiUsYHfEbDyMkBp1nDWzPl94i9ctoi3EOR0IdFc0ryPHETOn6fPSwCU9e
 6dOf/strL06jT87qY84nL8HFo2xY75cNoYCs6eK7PjOFTcQ2HiaumXc3iekSgaEvum
 +8a7NQgMA+Hzb036WoXnLNqt/92VZnk2px1MTDVIbj10uJfXFSW46gjYDpMnGBC06+
 9k0fakQCS86KQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20210111133825.8758-1-rf@opensource.cirrus.com>
References: <20210111133825.8758-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix uninitialized variable warnings
Message-Id: <161038245912.32701.15008025253298695654.b4-ty@kernel.org>
Date: Mon, 11 Jan 2021 16:27:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
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

On Mon, 11 Jan 2021 13:38:25 +0000, Richard Fitzgerald wrote:
> wm_adsp_read_data_word() used if (ret) to check for an error from
> wm_adsp_read_raw_data_block(). While this is perfectly valid,
> wm_adsp_read_raw_data_block() itself uses if (ret < 0) and three
> calls to wm_adsp_read_data_word() also use if (ret < 0).
> 
> This creates an error check chain like this:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Fix uninitialized variable warnings
      commit: fe9989fb25b0cea6414e72e0514c70ed8b158c28

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
