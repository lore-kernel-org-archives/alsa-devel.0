Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB1AC32793
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Jan 2023 15:48:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D749798D;
	Wed, 18 Jan 2023 16:47:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D749798D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674056885;
	bh=lYFKVvc7tvviq3RgBfe8rDLSTPHhOHUruMa3+8hdj6U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=iyVOYvKOMI8E4vYg1UIW643hVRw/qhOliI5iSmpour59yUwm0IQSpwPnYAgle+hUS
	 QKwhrvuBdS5OfZCW/cV1lu0V13s6dwZ05beMaHzs0OlB+OlSMsfPKclaFUmBDsTkcv
	 wwdXUjWjMr0i7sLfn1w7613J+q5DAju7wbUaD8+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59FF7F8053C;
	Wed, 18 Jan 2023 16:46:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A55E5F804A9; Wed, 18 Jan 2023 16:46:25 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1EB9F8024D
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2023 16:46:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1EB9F8024D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=utPpXgq9
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4F5CDB81D8E;
 Wed, 18 Jan 2023 15:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449F9C433EF;
 Wed, 18 Jan 2023 15:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674056780;
 bh=lYFKVvc7tvviq3RgBfe8rDLSTPHhOHUruMa3+8hdj6U=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=utPpXgq9BbrisKelrYCw8xfIK0oG88bZ9HCpeH6Nrj4Fk3GvtfXN3FpodWHciXSnP
 OAYbyIHsfUn7lXgFCzY01el7BGJgPlgdvARu7XqEWUzK3kAeGJjZYpsG+74q4ZAlvW
 OKinYBTezmsNS/gj0/uLtKS3y9qa+XxJYIEasBALHN05a/CHK1LEE1sGi5VEPwJdyj
 osycdD/mtq/NxV0whWwgU2o/QgjuAlOOyykFvVG2tGMJwPkI7C49TW8XXqkEsxB8yj
 eE2Bv4VjODhdx3MFz0ApW9NhbQOi7E6D6zmQ9LDeF0R3dZl+gicXx9CvtdWhhbx2TF
 fcWRUbEO+IW+Q==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230118101255.29139-1-peter.ujfalusi@linux.intel.com>
References: <20230118101255.29139-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH v3 0/3] ASoC: SOF: sof-audio: Fixes for widget prepare
 and unprepare (for 6.2)
Message-Id: <167405677569.930478.13759548736696801543.b4-ty@kernel.org>
Date: Wed, 18 Jan 2023 15:46:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-77e06
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 rander.wang@intel.com, yung-chuan.liao@linux.intel.com,
 angelogioacchino.delregno@collabora.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 18 Jan 2023 12:12:52 +0200, Peter Ujfalusi wrote:
> Changes since v2:
> - re-based on v6.2-rc4 (and tested)
> - tags added from AngeloGioacchino Del Regno for patch 2
> 
> Changes since v1:
> - patches got re-ordered to make them (hopefully) apply on stable when picked
> - Added stable tag for 6.1 for the patches
> - Added Fixes tag for the swidget NULL check on unprepare
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: sof-audio: unprepare when swidget->use_count > 0
      commit: 7d2a67e02549c4b1feaac4d8b4151bf46424a047
[2/3] ASoC: SOF: sof-audio: skip prepare/unprepare if swidget is NULL
      commit: 0ad84b11f2f8dd19d62d0b2ffd95ece897e6c3dc
[3/3] ASoC: SOF: keep prepare/unprepare widgets in sink path
      commit: cc755b4377b0520d594ae573497cf0824baea648

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

