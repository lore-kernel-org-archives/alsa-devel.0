Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA79C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:36:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89F564DA3
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 17:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89F564DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (unknown [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EA4D17C0;
	Wed, 27 Jan 2021 18:19:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EA4D17C0
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E835CF804FB;
	Wed, 27 Jan 2021 18:15:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 907AFF804FC; Wed, 27 Jan 2021 18:15:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FB42F804F1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 18:15:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FB42F804F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VmdYE3Ec"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D54B64DAA;
 Wed, 27 Jan 2021 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611767708;
 bh=7Bwdds1A7Ya9EavPRY3Dg0/JfA4W6X/EzcuglwAkaXE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VmdYE3EcEkZ2HBWlGAnqCNP5ZivmoL1Wl1nwbiRXu0JR8M5q2IW/pd7k2WEeQ15rk
 12I8Z1X0ZgJePuwUkb7pj5Sh5zigVAxEBG64jlYVyY7evqB6bmXl5Znazrmo4VEZdc
 kOoDIeP0I9FE8B9iOLCAKI8uDaYUdqw4SVD/FTNok/1GsEq1xQe1UU6bglHJ9VD8r4
 i4jAE/TTLeEPqRm99fNINHPz32vKEp404+zxoGbxFE3U7CPM0qm4lXZQdGUDLiTXI8
 TulnOwH/tSEH91JCJWFtN3JELL0h9NdFVxpHTgKDfi7hOlmnHmAOwlN0RGMyl7QkRL
 mGZ5bo6RH1VqA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <20210125070500.807474-1-kai.vehmanen@linux.intel.com>
References: <20210125070500.807474-1-kai.vehmanen@linux.intel.com>
Subject: Re: (subset) [PATCH 1/3] ASoC: SOF: allow soundwire use
 desc->default_fw_filename
Message-Id: <161176762855.34530.7838015493249241498.b4-ty@kernel.org>
Date: Wed, 27 Jan 2021 17:13:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
 Bard Liao <bard.liao@intel.com>
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

On Mon, 25 Jan 2021 09:04:58 +0200, Kai Vehmanen wrote:
> The old code always uses sof_fw_filename in struct snd_soc_acpi_mach
> as the firmware name. However, firmware name should depend on the platform
> instead of the machine. For example, different machines may use the same
> soundwire link topology, but they are using the different firmware. In this
> case, it's hard to determine in struct snd_soc_acpi_mach which firmware it
> should use.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: allow soundwire use desc->default_fw_filename
      commit: 7da99ef9757a3dd6e66a9b4854c5e58cd65a0b9a
[2/3] ASoC: Intel: tgl: remove sof_fw_filename set for tgl_3_in_1_default
      commit: 3d14932527ff09517f052e54e7c25d676120b33a

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
