Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A235AC43219
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Nov 2022 12:30:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FB00167E;
	Wed,  2 Nov 2022 13:29:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FB00167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667392223;
	bh=39USPLmjDpLu20RqjJPyf1Fk2Z5MBi/tRofKeytUVMI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CMFqZyB0vhGmj2jffrmSi+2vTHWKU4f3qFOmTX/OqaF8u8GQrTRMKA5QTgun8P17X
	 RyIHBoqcD2qUo/n+ugJThtPfjbhrkATCVWGbWZrn0lA90BSVC+WZ/wC3X9i4UvFsEF
	 +1apP2HYDSwf+Z6vW+gJV//bL/idvy6vZKKur+aA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADFE4F80254;
	Wed,  2 Nov 2022 13:29:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5607F8026D; Wed,  2 Nov 2022 13:29:30 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4114BF80155
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2022 13:29:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4114BF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QcH9kuFm"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3802EB82213;
 Wed,  2 Nov 2022 12:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567EBC433C1;
 Wed,  2 Nov 2022 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667392161;
 bh=39USPLmjDpLu20RqjJPyf1Fk2Z5MBi/tRofKeytUVMI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=QcH9kuFmnycu9+EO08i7i0adsWAwijfvMea0LKmSZUjkl7aGC62OhcMsL24pE1nqf
 tfmmLJ6szLwDCaYTZil90GdgaetAXY4mSA3wTA8jmLREcDjXd/vAql2H5/+6JWK4Y4
 Jp+ouWhkr0C4lrgeHbEem9j09wdyvujug0h4LK3/R5Klge7Y+n5fVqY0shPxQZ/FHk
 YJC7aqpdhqSOng4qoFfJ8wE5QYF57frdna96dS6abe/AtRzNoARVtQQurGuJ/dJc3m
 7Cju2+1BMI+IUrhhy9TkfNPYDSWIL2FMKJwgnnZb8doYuWYyfGc/RGVzlQ4UK9FdBd
 ePlUpUWgTNIrQ==
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20221101114913.1292671-1-kai.vehmanen@linux.intel.com>
References: <20221101114913.1292671-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc3-topology: use old pipeline teardown flow
 with SOF2.1 and older
Message-Id: <166739216005.30517.5746349846859177726.b4-ty@kernel.org>
Date: Wed, 02 Nov 2022 12:29:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
 peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, daniel.baluta@nxp.com
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

On Tue, 1 Nov 2022 13:49:13 +0200, Kai Vehmanen wrote:
> Originally in commit b2ebcf42a48f ("ASoC: SOF: free widgets in
> sof_tear_down_pipelines() for static pipelines"), freeing of pipeline
> components at suspend was only done with recent FW as there were known
> limitations in older firmware versions.
> 
> Tests show that if static pipelines are used, i.e. all pipelines are
> setup whenever firmware is powered up, the reverse action of freeing all
> components at power down, leads to firmware failures with also SOF2.0
> and SOF2.1 based firmware.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3-topology: use old pipeline teardown flow with SOF2.1 and older
      commit: 003b786b678919e072c2b12ffa73901ef840963e

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
