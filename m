Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3275C54EE9
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 13:01:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4176A850;
	Tue, 27 Sep 2022 15:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4176A850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664283673;
	bh=WhKfpdHarWpwK0DfgClRr+Pyx0XKbe4sxd8WDUF78wc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6q5O720Ctl+uyi6UrNOCtdRyHH0WDNtHNlptMzKoWsrZa+45irFg9IMpvy0/MPbK
	 wYjqtataMKVrh6XtFfoqduLcq/Yy5DdK6HF/P84rVW/oaAc3PXU4cqqqugUaTZxWpD
	 LyCaQ6E7tkO3XD53IC4Q0ZmxFp5b7FnAlYgfSYxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40D31F804D0;
	Tue, 27 Sep 2022 15:00:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76EFBF804D9; Tue, 27 Sep 2022 14:59:59 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31F52F80166
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 14:59:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31F52F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YkC10HCY"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B21BB61964;
 Tue, 27 Sep 2022 12:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26C6C433D6;
 Tue, 27 Sep 2022 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664283594;
 bh=WhKfpdHarWpwK0DfgClRr+Pyx0XKbe4sxd8WDUF78wc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=YkC10HCYIO6+PWu6UnzjKTF9WY+SrZKXkndab8qU8tMrrS2e7WfgJy8XA0j9SDETC
 vx/qsDwpvuKHlNZSJBjk1VigqE24qHvApNwpEFlzyFfntVgVFFRmnVVSSXZx9GyXZd
 YtfF645di+Wr6eif71wbFLJWFhhBKxTZ/GcibWzH1B62JKr39uY72sVJh7qQBzA/4y
 WWnm4l/QNOJwwsCmCSDQh64LbCwEbdoCwBGob5LCcJGaxOWyHDPUgitlq5yaONzso+
 31AkDq5oqSee9GGOygXTY0grT4SPdzhgdszmWlDDoaeirqOCnq+HJoDIcAhMZ3wN2i
 2ae2YZZ11zn/Q==
From: Mark Brown <broonie@kernel.org>
To: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220927002004.685108-1-marex@denx.de>
References: <20220927002004.685108-1-marex@denx.de>
Subject: Re: [PATCH] dt-bindings: sound: st,
 stm32-sai: Document audio OF graph port
Message-Id: <166428359170.365276.17161501749228510942.b4-ty@kernel.org>
Date: Tue, 27 Sep 2022 13:59:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com
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

On Tue, 27 Sep 2022 02:20:04 +0200, Marek Vasut wrote:
> It is expected that the SAI subnodes would contain audio OF graph port
> with endpoint to link it with the other side of audio link. Document
> the port: property.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: st,stm32-sai: Document audio OF graph port
      commit: b3eec3e6670d4da653e742bae16e5a6ff3f03825

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
