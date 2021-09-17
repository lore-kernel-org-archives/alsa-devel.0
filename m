Return-Path: <SRS0=EuHN=OH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F7DC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 14:06:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E921A60E08
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E921A60E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 938D917AD;
	Fri, 17 Sep 2021 16:05:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 938D917AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631887592;
	bh=Yix9jceNDyfEMb1PcjV6VtH9zcTD/1xIKGkgd3AcrGc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XqC3dIPtrlqa2nJ9u3jhPeuuR1yy27Dr2kvZAKMsiGKCV/tzZizONvV93Ox5uxqNS
	 kV7PX7So3TAoaIZxHRBhUC6MwR0qh8rxCBerblYU+EtUCISuof0ktefXD1rrMF5Fad
	 1GR8X5Au8R4bRYvcVkeo6+cZsQ21UPswJPTO2IKQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBF33F804E1;
	Fri, 17 Sep 2021 16:04:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9C93F8027C; Fri, 17 Sep 2021 16:04:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6694AF80152
 for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2021 16:04:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6694AF80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RTc8bsMK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D3AB61212;
 Fri, 17 Sep 2021 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631887476;
 bh=Yix9jceNDyfEMb1PcjV6VtH9zcTD/1xIKGkgd3AcrGc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RTc8bsMKykLDP14I1P61MU2XWjrhsX2xBthm62Kn7WeyLcYP59fh4O0HzxAztFwYX
 iPSIFGv1qI7w0JNaIDuTSKB4Wj5DN8KdoRBd/iEr16hVu4oSxcbHCEDGYgGlzwa+Q0
 Do6+RRo9TwYrp5BfmFQEYsvodWOBRvZ/TQfpAkBb9gSn2TsxJgzRVj+W8mfIqeFkcb
 R4Ft82mclMsPDF95ycQg7x86ko4sxezpxqAHbkNfHnuuYpRtj041xg76BAjALo9+lN
 rEJJCtKdu36jXKEGIh3/9VGu2ITb64SVoNVDQE77z5DeInf41El1KveKY7sQCApv7t
 +QHyYFVKZHSsQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Rename sof_arch_ops to dsp_arch_ops
Date: Fri, 17 Sep 2021 15:03:43 +0100
Message-Id: <163188719814.50326.7112332224591931711.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916130308.7969-1-peter.ujfalusi@linux.intel.com>
References: <20210916130308.7969-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 daniel.baluta@nxp.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

On Thu, 16 Sep 2021 16:03:08 +0300, Peter Ujfalusi wrote:
> From the name sof_arch_ops one can not decipher that these ops are DSP
> architecture ops.
> Rename it to dsp_arch_ops and change also the macro to retrieve the DSP
> architecture specific ops as well.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Rename sof_arch_ops to dsp_arch_ops
      commit: 0ed66cb7b6d38f0bab061466c1aa0e9f3db45e93

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
