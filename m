Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87625C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:09:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE4264D74
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE4264D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BE651841;
	Tue,  9 Mar 2021 20:08:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BE651841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615316969;
	bh=hwkOb9GSNa4+vO3k/+jgdbf0VkBnReZAqNBE9CLOGRM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e3swA9pShuv7WY6xm8drcN9fwXHGLmQeKDlfU0EQSuHKnkw2/ET0kbBtoZ9tX/qLz
	 9JbQdb3HffCoy4cBa/800hAwfCU8H+k5nxXI+WOFqc7U2TO3IqzS+3KVtaCGwcXYrs
	 fTUgMhrQxMwXdlpxfsDF4LTS+Ec/OunyRRPEmcjU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 815C7F80275;
	Tue,  9 Mar 2021 20:07:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FDF1F80227; Tue,  9 Mar 2021 20:07:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75E91F8019B
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 20:07:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75E91F8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U5LFJGLX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 548BE6523B;
 Tue,  9 Mar 2021 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615316860;
 bh=hwkOb9GSNa4+vO3k/+jgdbf0VkBnReZAqNBE9CLOGRM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=U5LFJGLXFzlSiypYuDxkGO83uvFm3APTKwrbvISYEuhQUKgIBK0tOAlMHFQd34d62
 g7vy5pq4uW2hMEcxidcmOOwbVSmjszJPx18i1RiiJvmqdzgROr2ACj/iaWZmMuSnCX
 XvM8td4KuJhS2zyCY5q6QyISvwbfARKTgpuUq1iOxWpDwoobMjUKtLusr7pcDTBoR5
 e7lnIASzNfE8IgxUGEbPbxTTkfzB24dOxdVL3af1NCTAFHI55NxiSXMt4YWzHWVECH
 NdyXLPs81JM8nqmirXxKlWYKAactevs0+Nsqq5mcIGIoWCUHgiLF/mb1Kn95DaULDi
 E07biXA1s1+MQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
References: <20210309142129.14182-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 0/3] ASoC: sdm845: array out of bound issues
Message-Id: <161531678411.49117.14765657958455012863.b4-ty@kernel.org>
Date: Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: amit.pundir@linaro.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, john.stultz@linaro.org,
 bjorn.andersson@linaro.org
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

On Tue, 9 Mar 2021 14:21:26 +0000, Srinivas Kandagatla wrote:
> During testing John Stultz and Amit reported few array our bound issues
> after enabling bound sanitizer
> 
> This patch series attempts to fix those!
> 
> changes since v1:
> 	- make sure the wcd is not de-referenced without intialization
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: qcom: sdm845: Fix array out of bounds access
      commit: a5fd5e475655d3830f376e29ca6a7222dc7074cf
[2/3] ASoC: qcom: sdm845: Fix array out of range on rx slim channels
      commit: 3ed85d1e1aa53db6fa4398846fbd213a7d87ceac
[3/3] ASoC: codecs: wcd934x: add a sanity check in set channel map
      commit: 480c25e7003d0222f64824d4c7afcd274bc66ebd

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
