Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE83C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Mar 2022 20:40:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC51E1775;
	Mon,  7 Mar 2022 21:39:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC51E1775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646685643;
	bh=BDeFsvcrsUvGSZSP+vgrF27pThopub8QkzdkFh0jUhg=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qE9UCxbqr2Ms51TsUoCkBd/dRn5/2gR9M+qmUxRzFe149jUg7jDTPYLCkuKYJuroz
	 lv18LmxxwdYj9ekEgmmQCTWLU4mX4QksSt9h5ubaBKlouLcXVdfe7DaR3RAZAM51bz
	 ssUu5BF77KvBX+htn+MIoBYfaxjRJeiZzN1apywQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8F71F80516;
	Mon,  7 Mar 2022 21:39:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F75DF80271; Mon,  7 Mar 2022 21:39:09 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CF44F80271
 for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2022 21:39:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CF44F80271
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qNs8O5cW"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EB526614C1;
 Mon,  7 Mar 2022 20:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EEBC340E9;
 Mon,  7 Mar 2022 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646685541;
 bh=BDeFsvcrsUvGSZSP+vgrF27pThopub8QkzdkFh0jUhg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=qNs8O5cW8RfvVvY7tFOtq/CFrh/cMM824brHspZI4E5qzGumYSORASNRGUY/sCPqG
 ioUfmG9/QzxLStIb5fty/uMOEJw3T6cOctSPuqZvQ0exsjdRmW+2watzuR6OmqutPK
 ARiTnCeaHu8KgyF4HFK8XF8ihmFUczpepMy1K/dCsR6SRnm7Ey4M/YwYZRvKXaiLwC
 icp9Ajlquxyyk7kpetV4c0HchsJJvE2hZfhqO8OEDWW0ErBsdMpHd5qG+ehepfnd+v
 GLCjvt7rfNEskzjVhM7cUUBwuD/LWHlS1oTEVIHK9dF2UCe1cK/4v++SaVsbvVpafR
 BjuY1JwCgMNvw==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 kuninori.morimoto.gx@renesas.com, robh+dt@kernel.org
In-Reply-To: <20220217134835.282389-1-rf@opensource.cirrus.com>
References: <20220217134835.282389-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH V2 0/2] ASoC: audio_graph_card2: Support variable slot
 widths
Message-Id: <164668553966.3137316.10989560003492076893.b4-ty@kernel.org>
Date: Mon, 07 Mar 2022 20:38:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Thu, 17 Feb 2022 13:48:33 +0000, Richard Fitzgerald wrote:
> This adds support for I2S/TDM links where the slot width varies
> depending on the sample width, in a way that cannot be guessed by
> component hw_params().
> 
> A typical example is:
> 
> - 16-bit samples use 16-bit slots
> - 24-bit samples use 32-bit slots
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: audio-graph-port: Add dai-tdm-slot-width-map
      commit: 26e5366dd30569a469e1a87998b866b814deccf8
[2/2] ASoC: audio_graph_card2: Add support for variable slot widths
      commit: 1e974e5b82b3d75069b50445cd248cee0199654e

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
