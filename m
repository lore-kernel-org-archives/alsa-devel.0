Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105FCC47082
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 18:43:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B581C613F1
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 18:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B581C613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 735AA1715;
	Thu,  3 Jun 2021 20:43:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 735AA1715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622745831;
	bh=dK344AYhL5UdIXsXyGR81o2iDDv2rRrDw4+wQpxmiIk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPlU866VzUk28739rD3C2Na3i5w+eR7ZMLikg1Dq1KmDXJYklw4sPhe8DBDfrNzFT
	 EuijghG1qPnOQkuMsVdpe3eHnQKTcVnxJFnCql27w6ElFGqJtGVxQobjcwYNG6qLhe
	 JbU/qZErcVcjbgSpyC0EfP1W4NBgDgFZuCAhMPAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EAEA8F8025B;
	Thu,  3 Jun 2021 20:43:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A92AF80254; Thu,  3 Jun 2021 20:42:59 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B43AF80254
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 20:42:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B43AF80254
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PL77kvMf"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCDDA613BA;
 Thu,  3 Jun 2021 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622745768;
 bh=dK344AYhL5UdIXsXyGR81o2iDDv2rRrDw4+wQpxmiIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PL77kvMfw2heJBRnYmEaMAxoYAHzBeIjcGX+7kItGMatQDu166HfGF6MQg2Uq4oKv
 PpVT5HwMtIapfS8YuBPGBc4J+hcDy468InGFKosFzpbV3pfkqMv9NbFE2A5O5HR7J2
 OXIVDTwpcctYh169WMeMd+ic/OYjiCXBFcCkdAdzc/XW7TqkDJtWTLOYgX1rKapLbu
 o4/FuWRjmszz6Gw9Fq9/URvYtHsVNLisvf17UI391CrfQlMkH8eg7oZd5KOBvm365l
 e+ktyTZ6h9nVWx+FZQEmu4RwtwqMWgG104nF8ULiL6HPsF4vkEqjJnlZnyQDIdPmdv
 /g7oNwI3cDzww==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/5] ASoC: rsnd: tidyup adg and header
Date: Thu,  3 Jun 2021 19:41:56 +0100
Message-Id: <162274557551.14795.5426891535492687670.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87v96xi22i.wl-kuninori.morimoto.gx@renesas.com>
References: <87v96xi22i.wl-kuninori.morimoto.gx@renesas.com>
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

On 02 Jun 2021 08:43:01 +0900, Kuninori Morimoto wrote:
> I noticed that adg can be more clean code.
> And rsnd.h header comment was not so good
> because patch has been randomly added.
> 
> This patch tidyup these.
> 
> Kuninori Morimoto (5):
>   ASoC: rsnd: adg: supply __printf(x, y) formatting for dbg_msg()
>   ASoC: rsnd: adg: tidyup rsnd_adg_get_clkin/out() parameter
>   ASoC: rsnd: adg: use more simple method for null_clk
>   ASoC: rsnd: adg: check return value for rsnd_adg_get_clkin/out()
>   ASoC: rsnd: tidyup __rsnd_mod_xxx macro comments
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: rsnd: adg: supply __printf(x, y) formatting for dbg_msg()
      commit: 2cdfe6520c939aff60bf78be2fc682e7635d0618
[2/5] ASoC: rsnd: adg: tidyup rsnd_adg_get_clkin/out() parameter
      commit: b48e4aa48931030382d26c624cf4ae1c68d15666
[3/5] ASoC: rsnd: adg: use more simple method for null_clk
      commit: cb2f97d89f383dafa822bce66f0c3514dfb135b8
[4/5] ASoC: rsnd: adg: check return value for rsnd_adg_get_clkin/out()
      commit: d668a5e2409b2ff9291493b70c961ecbe883bfb2
[5/5] ASoC: rsnd: tidyup __rsnd_mod_xxx macro comments
      commit: 3f4593fb4a9ddb53edefcbf7d4c5fd1f04717422

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
