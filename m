Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E356DC4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 17:31:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CC581898;
	Mon,  5 Dec 2022 18:30:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CC581898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670261506;
	bh=WtogiyI9yS+8qdzbaPH6wEOhtLw5jgAaFfE/irD6Kog=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z0ekGIQV4C9lizk1ZRZprkDPf67/teU3uuHWZPxFS8aft/Phsg5CpVJTAQ8cvkLIY
	 yYmha/wxakR/S1j2HfUgob3Gi4VQUuTKi6/sfjDw6q+IYT3qYWHTvO3Q+h81jiJt1j
	 /pT7MXXwS863mGxlgF4nRUOHIJW5DddQZ3b4Xqxk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE177F80588;
	Mon,  5 Dec 2022 18:29:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9E84F80589; Mon,  5 Dec 2022 18:29:37 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67163F8057E
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 18:29:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67163F8057E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uGo/vioF"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 120F76126B;
 Mon,  5 Dec 2022 17:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E317C43146;
 Mon,  5 Dec 2022 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670261371;
 bh=WtogiyI9yS+8qdzbaPH6wEOhtLw5jgAaFfE/irD6Kog=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=uGo/vioF256l6K2fJcPUZWKUFVL51ehy1XdZGkw8thCdNbRtN5qgW10cqSwuIZpuc
 pfTupO8eKgacG6Yz6Dfyy9OtmvEc1mG7+9DhvmNSelsLZY+30s3y4OEfl05clN15Hc
 0bpjX5FAYIwJ4kctljKW27MGJGSBCyF9bC7sQWqRZGM6S/q6xAsYsAjNMwgA0XjT0q
 1bT7tmcsmNWdSjHAepOvKtv4WZxbJNDeP2Zsp9j/XKEVa5E3NpKvaHuWOtfyYwNDP+
 Cb2QI9H5PAFYc+NNqhumB4Qn16aes5KTa0vDurpDie6kBhdE5p7NmE5MSNxuACwtQJ
 X5CsSUsSRwBfg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
In-Reply-To: <20221205120649.1950576-1-Vsujithkumar.Reddy@amd.com>
References: <20221205120649.1950576-1-Vsujithkumar.Reddy@amd.com>
Subject: Re: [PATCH 0/2] Add SOF panic dump support for AMD platform.
Message-Id: <167026136984.536379.15476603342497228865.b4-ty@kernel.org>
Date: Mon, 05 Dec 2022 17:29:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: venkataprasad.potturu@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, ssabakar@amd.com, Vijendar.Mukunda@amd.com
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

On Mon, 5 Dec 2022 17:36:47 +0530, V sujith kumar Reddy wrote:
> This patch series consists of
> 	>> Use poll function instead of simple read ACP_SHA_DSP_FW_QUALIFIER
> 	>> Add support for IPC and DSP dumps
> 
> Ajye Huang (1):
>   ASoC: SOF: amd: Use poll function instead to read
>     ACP_SHA_DSP_FW_QUALIFIER
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: amd: Use poll function instead to read ACP_SHA_DSP_FW_QUALIFIER
      commit: 2a2f5f2384b9791a028901aac3f49c488839d073
[2/2] ASoC : SOF: amd: Add support for IPC and DSP dumps
      commit: 41cfad23b5ebef2dbddecff2ddeb27ca973f98a8

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
