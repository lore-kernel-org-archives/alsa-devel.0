Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F8EECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 12:55:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB40E697E;
	Mon, 24 Oct 2022 14:54:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB40E697E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666616128;
	bh=eeZYPvtwVp+JRNB1Md+vcFGippA6sW+UcxlVr7+SUcg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nDoAGl/SfBTVf+hgYo7a86DyyHx5Q3jBw/J/s0typ2WYN2fJTMEsN+xtVK5cf0ngN
	 pBCHW1d3HVCg1AQcERMqkkNHnYmOZBFczcn4u1kdlR5a6/q9qJUFyah7i/0cxaEi21
	 SGJpaK5W/W23fuROThoRWqfKwB1PRTrmArA2nq9Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F82AF80506;
	Mon, 24 Oct 2022 14:54:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3439F8053D; Mon, 24 Oct 2022 14:54:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99B08F80431
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 14:54:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99B08F80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UsGupU67"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F3950612D5;
 Mon, 24 Oct 2022 12:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6396CC43470;
 Mon, 24 Oct 2022 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666616071;
 bh=eeZYPvtwVp+JRNB1Md+vcFGippA6sW+UcxlVr7+SUcg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=UsGupU67EwMHVV33LZE0Cb9ylxlWiUq+US0bTzDouaG8frWvO20c04zCV0kSSS+U/
 Dr+HAuy7ZHVb/FGusmioz/O916c7sOD5HHg/4zKq4Z4rg4Zls298Vyy5HRG/LZFrEd
 5/sCgtMAzAM1Ptj7oGpQ6i+jX2LDU23aeZK/DdRGHrvMAdsE2tU8weJgm35da93pEL
 U509qPro7h5ranOlTxt5j7RbEC6zi9nTUxFyjPiU2ZtrzFhgnZfUI9zXXjzTI9MqeN
 ogvZ2Ft5AppnUCscNG/tGECXKnVNvCGJ4kZxGcTzAHxelwKV5BM6D77S0YSwVywjxJ
 IOEQIwKAs37mQ==
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>
In-Reply-To: <20221011184119.3754096-1-robh@kernel.org>
References: <20221011184119.3754096-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Convert dmic-codec to DT schema
Message-Id: <166661607011.206380.11913993879232819414.b4-ty@kernel.org>
Date: Mon, 24 Oct 2022 13:54:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
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

On Tue, 11 Oct 2022 13:41:19 -0500, Rob Herring wrote:
> Convert the dmic-codec binding to DT schema format.
> 
> The '#sound-dai-cells' and 'sound-name-prefix' properties were not
> documented, but are in use, so add them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Convert dmic-codec to DT schema
      commit: 8da313ad1bd020859e2ee8a3e8e97e52425e539c

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
