Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146A3C61DA4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Mar 2023 13:36:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66DD91111;
	Mon,  6 Mar 2023 14:35:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66DD91111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678109795;
	bh=xk2sxBEfsiN8aKVYWYbUYCkQgq5QDPcbaOkOnFjwYec=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UBPb39otm67THPaq2xJgW9qQe98GEzBuJl6kI1Lpy9yAMyf7UCUMhl7iwc3BX4xMJ
	 EDxpX3YEMKh34wPmbquIdNwZqu6Fn4tkBcyrW/h7lZBtyF6rTNAZse9d+zpluO8pvq
	 bPbZcNQTnqeJu9TpiU+kKB4T1KVATEPcI/4EVn1w=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 160EEF80587;
	Mon,  6 Mar 2023 14:33:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D052CF8053D; Mon,  6 Mar 2023 14:32:21 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C2D22F800C9
	for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2023 14:31:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2D22F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sddlj8en
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 19063B80E3F;
	Mon,  6 Mar 2023 13:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FF6C433D2;
	Mon,  6 Mar 2023 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678109515;
	bh=xk2sxBEfsiN8aKVYWYbUYCkQgq5QDPcbaOkOnFjwYec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sddlj8enGoNsBB53XnM6yLjlWH6qW0MM4/OXj2+Rd0hDjZKdOA8lStIgrDIroyhqS
	 z3y7rgMjk3K0fqY2Wvs1ndD1L26gzBtFoNFxT6Sl+vOD+o+tVGnW0lHEWqTRn6YOwM
	 ptESxC8P7B5UMiwsRl1dHQEEgUl4gW4Gl1yv2I+8eQnA9Khh6P/Atisof+/iZLsjCw
	 YbZzdtgqrkrjTIULwrFsypWiN3RmoBcRrKua8GqJJYMWtehYD6ls1ftWD9T1mKO70W
	 mmXI8ERzpLqaQ3fedpWkCKXxWlKZm7H2U8NCLy8reO8GCxL3qDrQ4wiuO9D2S42qGk
	 8a8K8eDvN6yvA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Maxim Schwalm <maxim.schwalm@gmail.com>, Dmitry Osipenko <digetx@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20230221183211.21964-1-clamor95@gmail.com>
References: <20230221183211.21964-1-clamor95@gmail.com>
Subject: Re: (subset) [PATCH v1 00/10] Fix sound on ASUS Transformers
Message-Id: <167810951258.75807.6694477245258374695.b4-ty@kernel.org>
Date: Mon, 06 Mar 2023 13:31:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: GSBT3SXEMGK4EDMMRCFXQTMDY5ZXSEKC
X-Message-ID-Hash: GSBT3SXEMGK4EDMMRCFXQTMDY5ZXSEKC
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
 linux-staging@lists.linux.dev
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GSBT3SXEMGK4EDMMRCFXQTMDY5ZXSEKC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 21 Feb 2023 20:32:01 +0200, Svyatoslav Ryhel wrote:
> - add quirk for headset detection used by some T30 devices
>   (ASUS Transformers, LG Optimus 4X HD and Vu);
> - add RT5631 and MAX9808x machine drivers
> - add Fortemedia FM34NE DSP driver used by ASUS Transformers
>   and mandatory for correct sound work
> - bind everything into working configuration
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[02/10] sound: soc: jack: allow multiple interrupt per gpio
        commit: a2d4051b0bd6dffcd736888ae89a550d6f60b060

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

