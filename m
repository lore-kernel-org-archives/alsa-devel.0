Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C562C47DAF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jan 2024 16:34:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEDD984A;
	Mon, 22 Jan 2024 17:34:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEDD984A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705941281;
	bh=qx0slvzEJDNEhcWL6ARnxl5FKczNxXGG4ZvuQmczmUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=neE5bjN4PJFQjxfz45aK+Uaon0eyAPId5/DmWUeYqNMXAPkarprnq9N6whfy+id2S
	 CSUznvUJy5BeVhW+L7OGQ6dl3MKe5ZK71KxHf7o45EMVYhHjsb9OnimMDQT+i36rOg
	 K3b1OYRq+N4O2HERyh/bzPK6fqTh2Exav3KarGy8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49418F8057F; Mon, 22 Jan 2024 17:34:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98C92F80564;
	Mon, 22 Jan 2024 17:34:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B349BF802BE; Mon, 22 Jan 2024 17:34:00 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7BE3F80149
	for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2024 17:33:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7BE3F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Y3ghcF4U
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 16913CE12A3;
	Mon, 22 Jan 2024 16:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F67BC433C7;
	Mon, 22 Jan 2024 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705941225;
	bh=qx0slvzEJDNEhcWL6ARnxl5FKczNxXGG4ZvuQmczmUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y3ghcF4UrCUd9YkeyOT4JqiVFg+oSn3mn4svk02eISuC1tjXDUbOBo2hrbHRw1vSk
	 rFYgXdt8kD/h5lFkjkYFCh2CQimZ2uJVrhf5EBj+w8m+gESgKn9ow7kxxDpz8nHMqa
	 Mpk1XOJzQabJ3hmLC81iYEEVJRX2DFOPyQLK/AY8nH1zjDFU2zzbrNaZmFcTi62NMU
	 MLWjyaTwxK7dThpCrMPwZGq1xsupEdsPiJKzFCdJelPIYEYVv+hEljN2F461m3121U
	 DYKMilYhGFt9R4e4YBvT15goJhMO4etaEIcCXbBr+nq8qziqjCLZk0gUY8xSGTvcUm
	 HERAy44RSFeog==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20240106171635.19881-1-erick.archer@gmx.com>
References: <20240106171635.19881-1-erick.archer@gmx.com>
Subject: Re: [PATCH] ASoC: qcom: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-Id: <170594122282.63484.7192392650857534262.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:33:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
Message-ID-Hash: 5BIWYLVM6JIWXKKFUCYJSQTGJSER4M2T
X-Message-ID-Hash: 5BIWYLVM6JIWXKKFUCYJSQTGJSER4M2T
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5BIWYLVM6JIWXKKFUCYJSQTGJSER4M2T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 06 Jan 2024 18:16:35 +0100, Erick Archer wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Use devm_kcalloc() instead of devm_kzalloc()
      commit: 322ed3a10bf2dc85568aa9ed285aba448347080c

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

