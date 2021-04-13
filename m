Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1123C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 15:12:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4404E613B6
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 15:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4404E613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4A971682;
	Tue, 13 Apr 2021 17:11:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4A971682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618326745;
	bh=1iFJYKNyeqx6ShAwGOiPPxizLgZGKhvZAD7RAenIRUw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I1gbp+AOzDCa0YwtwM8yjOcwxme+XjR6Bc5k3CXUHu5NXeIT0PUphKLsbcd/MTuvS
	 2smFQ0zRPrn/ZX/lFJwThL/BY4EIlz1lYwI7lE8Aj+QAkbbJR+A49nB5ueTB8W61wE
	 3W1MYWTzRwFOg5V9J11usu1GqwGDK2imCy+7Qn/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3EC5F80423;
	Tue, 13 Apr 2021 17:10:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C295F8022D; Tue, 13 Apr 2021 17:09:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92A8BF8021D
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 17:09:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92A8BF8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IoDmNqTp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30587613CE;
 Tue, 13 Apr 2021 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618326570;
 bh=1iFJYKNyeqx6ShAwGOiPPxizLgZGKhvZAD7RAenIRUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IoDmNqTpXKgDzykgnUIW+Mbfh6v0UftrJr0NpSLCAdRfNafq5r60ti/V2ftoRMQGI
 ToFSpL0LPOk8vBHWoNWYY3Lo1x/jUNtjyOYkGHhpUS5xzsozhr0d/Cch6JvbzJvrZ2
 9KhZiqaqHJZ6unb2ebHoLKgH7IxnJg8zd2rrE6mF+QiTlcpzVUQQX8MDc2saPtw6Bc
 kVD/FlPDGDnwWSHYrkgG1j0DDyNEIZ1rAvLyE8wzr99mVzOe4Ts1Xbd9myVVwJxYh1
 epJH4vZBakmXoihfAPyuxEwG+3AxbPmyze7n/FGLRpIqpdlPooj/7z7TIxN6cLdDeY
 jle90l2gFDHlA==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 00/12] ASoC: simple-card-utils: prepare for multi
 support
Date: Tue, 13 Apr 2021 16:08:56 +0100
Message-Id: <161832446009.49152.9935717209687523370.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87v98swfar.wl-kuninori.morimoto.gx@renesas.com>
References: <87v98swfar.wl-kuninori.morimoto.gx@renesas.com>
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

On 12 Apr 2021 08:51:40 +0900, Kuninori Morimoto wrote:
> This patch-set is for v2 of Multi-CPU/Codec support,
> and some cleanups.
> v1 had patch-conflict on simple-card / audio-graph with below.
> v2 was solved it.
> 
> 	fa74c223b6fd78a5314b4c61b9abdbed3c2185b4
> 	("ASoC: simple-card: fix possible uninitialized single_cpu local variable")
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: simple-card-utils: setup dai_props cpu_dai/codec_dai at initial timing
        commit: 59f5cd96e9b9e1025ab0a9dc4ce9dd8633190794
[02/12] ASoC: simple-card-utils: remove li->dais/li->conf
        commit: f899006d558546a8ee39c93f816eb3847c5bc6c0
[03/12] ASoC: simple-card-utils: use for_each_prop_xxx()
        commit: fafc05aadd4b6ce5c161135de9d3a653fc054543
[04/12] ASoC: simple-card-utils: remove asoc_simple_parse_xxx()
        commit: e25704f84ca2b586e8e65d1b2ab686205b3076fe
[05/12] ASoC: simple-card-utils: care multi DAI at asoc_simple_clean_reference()
        commit: 1cf6805700ecf25942468a01eff902ab8c32ce3c
[06/12] ASoC: simple-card-utils: indicate dai_fmt if exist
        commit: ac813c625ad5c3ee98a99e1b37659a0d85178978
[07/12] ASoC: simple-card-utils: indicate missing CPU/Codec numbers for debug
        commit: 40d8cbe70e71be170e0a4fe6ab112d9aaa9cfb18
[08/12] ASoC: simple-card-utils: add simple_props_to_xxx() macro
        commit: 9830d3e99f51fc1c1c6ab8be7778fd205af198ad
[09/12] ASoC: simple-card-utils: multi support at asoc_simple_canonicalize_cpu/platform()
        commit: c826ec0391c83f06354a4ebb25c7b2480c18f33a
[10/12] ASoC: simple-card-utils: tidyup debug info for clock
        commit: 33cd6b191f1cdb5f332717a80ce26f661f53e924
[11/12] ASoC: simple-card-utils: tidyup dev_dbg() to use 1 line
        commit: 3919249e80995ed5f125f94d05fcb6171f79e732
[12/12] ASoC: simple-card-utils: tidyup asoc_simple_parse_convert()
        commit: fcfd763bef4ff7f6371790979a6ceac9c4ac425a

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
