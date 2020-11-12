Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BEDC63777
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 19:41:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7332224D
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 19:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TEhMxZ+v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJiUIyXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7332224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BA781869;
	Thu, 12 Nov 2020 20:40:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BA781869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605210083;
	bh=6wKnvEJUsF1QWJ4uiDCGRPVIg9x0BQcWveuXXL799cw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TEhMxZ+vWMq5nAGqbtFP+nMD3JiW9x/jwcFdUP43yRbaGzb/FE/ykOMFl5c3tg3Ie
	 0xcZPRcb2QUix753wLE0dxNymf6dw/6j0K6QSGoXOvSRmLnQqYSF7Gpqg5+QfHCB43
	 LH5mbIwk3CT6dlPHFhvtJtX558/kjhh+LKtvqo3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E66B6F804C2;
	Thu, 12 Nov 2020 20:39:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D85ACF804CC; Thu, 12 Nov 2020 20:39:06 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66E6FF804C2
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 20:39:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66E6FF804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JJiUIyXC"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6F4F22223F;
 Thu, 12 Nov 2020 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605209942;
 bh=6wKnvEJUsF1QWJ4uiDCGRPVIg9x0BQcWveuXXL799cw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=JJiUIyXC3eQxp55ucL3+ChUqrLAwcKGEaOAlPQ0AKLvdgrETjMDzZG5QEGrZJmKOg
 whCcDpkK2xvcd9w6FWM8GEiz8iVeHXEdG6vRUX+DBCU6fcF/DwWzdTqx2SbGFLg6i9
 tp/EsWTw5Mg2EkiXqYdFvGSTCzDmxt1HbL3iQC0Y=
Date: Thu, 12 Nov 2020 19:38:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20201109210958.84198-1-ranjani.sridharan@linux.intel.com>
References: <20201109210958.84198-1-ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Boards: tgl_max98373: add dpcm_capture flag
 for speaker_smart_amp
Message-Id: <160520990388.38586.15744116691114420179.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Dharageswari R <dharageswari.r@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.com
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

On Mon, 9 Nov 2020 13:09:58 -0800, Ranjani Sridharan wrote:
> Smart_amp_speaker device has the playback stream and capture stream
> associated to it. Hence add the dpcm_capture = 1 flag while dailink
> creation.
> This patches fixes:
> ERR kernel [timestamp] SSP1-Codec: ASoC: no backend capture stream

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Boards: tgl_max98373: add dpcm_capture flag for speaker_smart_amp
      commit: e7ee770a3f9004a5b4ddaa28ff9efe3ff3382268

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
