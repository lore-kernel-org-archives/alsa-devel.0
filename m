Return-Path: <SRS0=Xjxi=JJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A2C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 19:03:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E176105A
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Apr 2021 19:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E176105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12F8715E5;
	Mon, 12 Apr 2021 21:02:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12F8715E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618254221;
	bh=Sj6BA8lvSD3uTFaV2lCuqBinzPwytmoxvu77pZuoQZM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SOJJVcr2EQxvo3ecKabNcpKiJNhmxbwHj4I8vs/l1A+9st23pR7DAfcnkSD0DeH6g
	 x4HKlZrUME3/GI5qa3AxbehGStcvjRJN/8ddXCrBJbaAXRpSKZm+pY6xn4L3pEdMjL
	 TH3qCcP3nSJ52471wUMu7jWnL0w1lHGa2DjnIK/k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C652AF80424;
	Mon, 12 Apr 2021 21:01:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C584BF80271; Mon, 12 Apr 2021 21:01:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9437BF8013D
 for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2021 21:01:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9437BF8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Jg0y54qO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D86561357;
 Mon, 12 Apr 2021 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618254094;
 bh=Sj6BA8lvSD3uTFaV2lCuqBinzPwytmoxvu77pZuoQZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jg0y54qOKFyNzn1w4xE7dZCGJ4X3gA0TdRCzM+jiizwG9ibk35rrMO/OPowclgm3B
 vP8RnTKFYzP1/VI+82C5egq6g+SLyWyJEoNftbQNMNecMV8IrUlhUodNE7quiBVamC
 WGxDd9JfVIHDzE40RwGBWsQO6E28iPjdiMgTTv+D/5BguXr2PjezNbbu7f33fZXIdl
 YT7mgDin/u52phvUcg0Qfq6XtZgfLFD9nCq4OwdG+349bvg4+DvhVm3+hmT8GO9n9S
 m+Qdlfl4APt2TNCwRmhaQfnm4bPWSRVD3R8KLsps+QrtOSWlSE3vbFRiOZ03nR6XSA
 r60NVrHvUpk7A==
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: SOF: Kconfig: fix typo of SND_SOC_SOF_PCI
Date: Mon, 12 Apr 2021 20:01:01 +0100
Message-Id: <161825392630.52100.2436796914501459905.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210409221308.1544000-1-ranjani.sridharan@linux.intel.com>
References: <20210409221308.1544000-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On Fri, 9 Apr 2021 15:13:08 -0700, Ranjani Sridharan wrote:
> It should be 'endif ## SND_SOC_SOF_PCI' instead of
> 'endif ## SND_SOC_SOF_INTEL_PCI'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Kconfig: fix typo of SND_SOC_SOF_PCI
      commit: b2fe85790d8d67ae25af58ff94673afc6cb081d9

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
