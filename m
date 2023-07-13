Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53838C001DE
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jul 2023 20:26:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8558786F;
	Thu, 13 Jul 2023 22:25:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8558786F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689279994;
	bh=kkxEVsFpxLFmkOIaEjOsbvsOMuhsZT6M+GMCb45RIWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hd2Qw7hfMj9cxFl5iTVr8AHj2x902iA/y/VWZPtdfOtHTSi0CIDydSR5k4GBYdFpt
	 +7IJaMdWkJ58xJg608lmC5284dILIEwyc4mJcgTs+pSsxGi6JWL1/5UpiQIP+yuBko
	 EUJlX0oBTUSmZGjL3fMprf0I+ar4908Raie/0ZTk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 838B2F80578; Thu, 13 Jul 2023 22:24:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F1188F8055A;
	Thu, 13 Jul 2023 22:24:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE4E5F80236; Thu, 13 Jul 2023 22:24:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3FD1EF80249
	for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2023 22:24:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FD1EF80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Kneg8zHx
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 68B9A61B36;
	Thu, 13 Jul 2023 20:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E24C433C7;
	Thu, 13 Jul 2023 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689279870;
	bh=kkxEVsFpxLFmkOIaEjOsbvsOMuhsZT6M+GMCb45RIWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kneg8zHx+hczlkdbDOAlLG0jYulwZU1z+mURlVFWmx7JyAb4ld/rKScR3tUXjsqgT
	 vlgXkyDllZZH3Ey5KqxAP6Eb8lxIjHsNab1aqXL24ykRHzibYALxafv/p9IpEMRNX6
	 pCNIO4CrlQcfjMI7SIFOhWg5NgLsgOdgcORbvKyt+a6UQIGI7n37QAgbWZaUxnbn2V
	 jX9ScytDLiWd+/Vgzmt+PFV+HlKYPuTMhssfbsODRBvmdbfQCsvb12QFubnsggYL7x
	 g/wS9Q5VbTiTJus5jCRfmpgB5tRyJlvVufM5kVJ9hDh8MR/XoaELqoSbzlJXeFk0GW
	 f6Fzj+Xe2YIVw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Min-Hua Chen <minhuadotchen@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230713151744.86072-1-minhuadotchen@gmail.com>
References: <20230713151744.86072-1-minhuadotchen@gmail.com>
Subject: Re: [PATCH] ASoC: q6dsp: q6apm: make g_apm static
Message-Id: <168927986901.272917.8038940288958107240.b4-ty@kernel.org>
Date: Thu, 13 Jul 2023 21:24:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: RMKFM5VHQQVTH3GY7QM46YIM6HTKGSJO
X-Message-ID-Hash: RMKFM5VHQQVTH3GY7QM46YIM6HTKGSJO
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RMKFM5VHQQVTH3GY7QM46YIM6HTKGSJO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 13 Jul 2023 23:17:43 +0800, Min-Hua Chen wrote:
> This patch fixes the following sprse warning:
> 
> sound/soc/qcom/qdsp6/q6apm.c:30:14: sparse: warning: symbol 'g_apm' was not declared. Should it be static?
> 
> No functional change intended
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: q6dsp: q6apm: make g_apm static
      commit: df43fba7c75545094639be42a85502634f075a19

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

