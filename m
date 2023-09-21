Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3AEE71094
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Sep 2023 16:32:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9532586F;
	Thu, 21 Sep 2023 18:31:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9532586F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695313960;
	bh=x01Kxm/9gYMEc3tRd6K+OX6u8aPjjVNrTUQsLyR+bh4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UfCoG1kaoCx/1oKkZ+tgkg/wV1AkSGagrs4C+ylc5ZV+2nGnjyaM66rmB/FZ3M0y3
	 1Oc05UEC4B/K+qGLKPS0xmpHyBBkYpUo1pixo4halXTNCV/R6Hc2dVYUG2iAt+F3tM
	 XEM9+wZrUnVSQAAGToNxbzLnaa4Or9HnhMhTeOFI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2665F805CA; Thu, 21 Sep 2023 18:30:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AA50CF805C5;
	Thu, 21 Sep 2023 18:30:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8E2CF8059F; Thu, 21 Sep 2023 18:30:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A6C4FF8055A
	for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2023 18:30:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6C4FF8055A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=FNedpMNV
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC4361F31;
	Thu, 21 Sep 2023 16:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559EBC611A7;
	Thu, 21 Sep 2023 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695313820;
	bh=x01Kxm/9gYMEc3tRd6K+OX6u8aPjjVNrTUQsLyR+bh4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FNedpMNVBuLXklKrexRLNACz6FR9IbuPvG0QlMqhjK7AhKPtyc4bNI5e+cdzcv/SN
	 GK+8VztBWBTDT3cKs6HlLbcXxWVAjDwuGmf/fZm0Cn8T+pClNfYPN2VUym8huoAkOj
	 BO+dn6JENh/8F8W+JqE9FLzWqtky5dPzP29RsLai9/EOFaBU1Vq0qT/6u7H6nwV1dF
	 P6obK7VhKjXzoKqz+7jGNmAHWjKmDDP/d7tntSv0EZ5rGpg3bojsXPyq4B2JG/vy8n
	 o1bqH+VhXSMN9Ro+LIDib9qDDaHs+TA/RcZQd6TWdswCC8HMMyVkSIT/fJmnOsaMpq
	 Je9nX2cAhjrbw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com, peter.ujfalusi@linux.intel.com
In-Reply-To: <20230919092125.1922468-1-yung-chuan.liao@linux.intel.com>
References: <20230919092125.1922468-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: add support for SKU 0B14
Message-Id: <169531381906.61074.12846477501137066646.b4-ty@kernel.org>
Date: Thu, 21 Sep 2023 17:30:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: EEC77DGHAKDABQ4K2KQNLXXD4FEPJOMR
X-Message-ID-Hash: EEC77DGHAKDABQ4K2KQNLXXD4FEPJOMR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EEC77DGHAKDABQ4K2KQNLXXD4FEPJOMR/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 19 Sep 2023 17:21:25 +0800, Bard Liao wrote:
> One more missing SKU in the list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_sdw: add support for SKU 0B14
      commit: fb0b8d299781be8d46b3612aa96cef28da0d93f4

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

