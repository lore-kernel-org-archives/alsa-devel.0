Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD570C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 15:11:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0A46117A
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 15:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0A46117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 878CF165E;
	Tue, 13 Apr 2021 17:11:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 878CF165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618326710;
	bh=+W96IuXgYD2p65bDFfeqaBI9QaBpzQ0dmecX2pIWOzo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OTQwGJWSk9XS0DVnNfyAhX3hVAAWcfvRyiNRJ0ikgnyTqhRvqgD3olEpaFOxZTK0E
	 3W6B1AMJ1+zwj7s7gbx6vPqic5GGrlZdVYh7vyKYH/PPuyKBYaOtjhlg0aDZXsHfQv
	 KwjLCfy+5eHQrhcmFn3yInHqWwdogPOHmTa/xHg4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDDDDF8032C;
	Tue, 13 Apr 2021 17:10:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DFAFF8022D; Tue, 13 Apr 2021 17:09:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 888D7F800EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 17:09:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 888D7F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uwZWnBUv"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0D85613B8;
 Tue, 13 Apr 2021 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618326567;
 bh=+W96IuXgYD2p65bDFfeqaBI9QaBpzQ0dmecX2pIWOzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uwZWnBUvOfGce4nQHB2OtXu6CpzMmm6jw0Z79r+7L25sERwcJOSkrvZMZZNPSVMQK
 ca11Ocu4TMOsyGjulR0+FOqecBu81KG20znaVBK5phIMN1ajzZV2De0zcqeC+ttJnK
 83UN8i0EOfCQ7TPi625b5NWP/3IwGYR28bhQH3OWOi3YfWCXnCda9ira4qzjuS8TkL
 o/J3mGwRthtn2W5k+KT2g9Wc3flc2m2ygbJzXUVRnGA+rw8LaxmjJmNoSnr+3f0muj
 lumTJ6MV1s52bYRRNpsUOW1tgA1QU8mqimM2M5eLc7wXDTVg1s/ir1vRg6LK2O7QDQ
 ag8HuLURRgfIw==
From: Mark Brown <broonie@kernel.org>
To: david.rhodes@cirrus.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, tiwai@suse.com,
 perex@perex.cz, lgirdwood@gmail.com, james.schulman@cirrus.com
Subject: Re: [PATCH] ASoC: cs35l35: Fix an error handling path in
 'cs35l35_i2c_probe()'
Date: Tue, 13 Apr 2021 16:08:55 +0100
Message-Id: <161832446010.49152.17792070153979808894.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
References: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
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

On Sun, 11 Apr 2021 14:51:06 +0200, Christophe JAILLET wrote:
> If 'devm_regmap_init_i2c()' fails, there is no need to goto err. We should
> return directly as already done by the surrounding error handling paths.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l35: Fix an error handling path in 'cs35l35_i2c_probe()'
      commit: 38c694e98f6a6c8dfa48f2ba6f442363ed836efb

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
