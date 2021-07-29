Return-Path: <SRS0=Qkbk=MV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC3C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 16:41:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188F560F22
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 16:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 188F560F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DEF71AD5;
	Thu, 29 Jul 2021 18:41:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DEF71AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627576912;
	bh=qfO0Q6LjOx6aoLqPCVbAEPm1cClSlkvPugckvWbEWIc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pInAvgZNmowEtTtsLB7BMlvEv8Uz2yYgbhdg8tJEGECOPv/3pwUkDbhbD0n0wZdNJ
	 L/eIgQTIPVx3Gu7WTSmpo/8yCxd8WunSyJ+i/0DTTfDVRSUQAt/FePm9pEG3xBabpx
	 VxhvRmpsoAtkQJ3CtQ8l/YRYjBE+4qPXZ3eL5iSM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F284DF804AF;
	Thu, 29 Jul 2021 18:40:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BD2DF804AF; Thu, 29 Jul 2021 18:40:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1277AF800EB
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 18:40:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1277AF800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SqspFiV3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2512960EFD;
 Thu, 29 Jul 2021 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627576797;
 bh=qfO0Q6LjOx6aoLqPCVbAEPm1cClSlkvPugckvWbEWIc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SqspFiV3mqhm1frewwif4FTwVMwlZbUE3lTHfq9yBuM2jZ/ih88pm1LOk5lN1JEdU
 lbYNL+Rsbmvr3NmeugnkRQFp9pY7mYukHYxFBffoCy1aDOYIcJJergOw2wgDSI0DHe
 CjKNeyIM6GgLWw7+BpNl9pOYgg1zKZRf2uXWmn5R1xT5fDydcUqB+7URQwrX2h2CbX
 g++yd1UoNpCeGNFNQ7ApnQmwh4hkYs4aj13tJBdO0uCyyVOyOEO2UG/MEtQrsC3OTg
 FMqNjlPgHP7Fmj4MCDT22mFkEagtzpgDEXUAVPw/6WWDnOXsAAC8VaL+rDx36oYn0X
 lMQdmnmlej/qQ==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/7] ASoC: soc-core: cleanup cppcheck warning
Date: Thu, 29 Jul 2021 17:39:44 +0100
Message-Id: <162757633788.53168.6388280974529781837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y29pyl7i.wl-kuninori.morimoto.gx@renesas.com>
References: <87y29pyl7i.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On 29 Jul 2021 10:15:13 +0900, Kuninori Morimoto wrote:
> Now I'm posting audio-graph-card2 patch-set, but it seems it needs longer
> discussion. Thus I want to post more easy patch first, and reduce my
> local patches.
> 
> These are cppcheck warning cleanup patches for soc-core.
> 
> Kuninori Morimoto (7):
>   ASoC: soc-core: cleanup cppcheck warning at snd_soc_set_dmi_name()
>   ASoC: soc-core: cleanup cppcheck warning at snd_soc_get_dai_name()
>   ASoC: soc-core: cleanup cppcheck warning at snd_soc_daifmt_parse_format()
>   ASoC: soc-core: cleanup cppcheck warning at snd_soc_unregister_component()
>   ASoC: soc-core: cleanup cppcheck warning at snd_soc_add_controls()
>   ASoC: soc-core: cleanup cppcheck warning at snd_soc_of_parse_audio_simple_widgets()
>   ASoC: soc-core: cleanup cppcheck warning at snd_soc_of_parse_audio_routing()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: soc-core: cleanup cppcheck warning at snd_soc_set_dmi_name()
      commit: cdb76568b09db0ba1aa47f4e55501024342c9dfc
[2/7] ASoC: soc-core: cleanup cppcheck warning at snd_soc_get_dai_name()
      commit: bce00560a28e0f62b0250652b611365f363c712b
[3/7] ASoC: soc-core: cleanup cppcheck warning at snd_soc_daifmt_parse_format()
      commit: 5ad76775a522f728d89687523accb061f3ffb1f6
[4/7] ASoC: soc-core: cleanup cppcheck warning at snd_soc_unregister_component()
      commit: 5600f3d5ac53304b5068f55c69afa2b8b2380b2b
[5/7] ASoC: soc-core: cleanup cppcheck warning at snd_soc_add_controls()
      commit: eaf2469c340b854f5c19339d613234ce2c774a38
[6/7] ASoC: soc-core: cleanup cppcheck warning at snd_soc_of_parse_audio_simple_widgets()
      commit: 99c68653a56528ce66edf3d87bc050eee2ce0aee
[7/7] ASoC: soc-core: cleanup cppcheck warning at snd_soc_of_parse_audio_routing()
      commit: 51a3dd58424e7312e70445fcb4bca5924640af2c

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
