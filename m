Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34138C624D6
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:25:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C28260206;
	Fri,  4 Sep 2026 00:25:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C28260206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788474321;
	bh=bh32NNFh4V0KPZun6DdScXGwhV3jhVB4Jo9xPuKAsnQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nQlDAyhBrbHDoeOrDrQKOMmkh+LkDr4FSl7pQlbBE9h0TXE1XCpfPNsZ6EQU2NjwZ
	 EktQPc+/5AhfeQd5dZ/+tjc8b06fHIgko/E5xnM8Ewws+uWr8ggNNwgXPX26MzqeXr
	 9/0bkExINcMONjY2yKbpawMjatFwrUZbCFtugAbI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EBA5F805FE; Fri,  4 Sep 2026 00:24:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CCE53F805FD;
	Fri,  4 Sep 2026 00:24:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05DB7F8049C; Fri,  4 Sep 2026 00:24:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788474270;
	b=D0cHUzN0qmnHaurmbgY3R02X+XGCdqDbn034F/BmgQk26ka6Hip38iTIGPUU7T6SEkEc
	 1pRUL3ziiY1Ola9ipDpJGe78LlAse6znToGM5o1W0tYdVtEwLQhBbdyniUPjrcQILOsR4
	 7i9O+JsAQr5O3JFduOv+obiJFWV9GW61EWyA7Qao/Gy45XrN4xcZS9F5pkMbn2BSHrpt/
	 Ds/lML8CUzfaAfErjW4cWwdk+sKEOwgLL0i4PXDTU3Rm+K1ts4vQVitThqMnJ3gdQ1nTA
	 hEXlrXv+EzrtZEg4xC3LUcjUkgj9MDiq6F249e4ceI7VE4+NmhXCLfvIVJYs4s23uiQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788474270;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=bh32NNFh4V0KPZun6DdScXGwhV3jhVB4Jo9xPuKAsnQ=;
	b=qDmFyOO55gSmNf6wLNwC8VBk/GecIKUpQ70Mfz3GVOvN3PYz7RHWrVxAR1SLTLNYUdte
	 fw/VwVOYiDsAptEidUZxoYf0PeagpRFmLGJSyRzq4CuyEk0hFk7uTfLtsc57Qb4OeUHfP
	 77gxPV/yIE60vRzW+Te3H167ryyqVw0W7P5fVE7LbtLf+xtpCFr/medA65ZEKX55pQWui
	 vUb37Z6XaHHxHYSky/gfFyGKhfJ+Dx0lhC2FrzGswo2tBdR36U+Eae7ZL49yX9QiMNz/s
	 FxxhHqu5M0xQnxEvmS1GxJ06sKT0rgKBGNSVs/76sObW/aozyaHM8VKHikF9VkuJbbg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j9oP+00N;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 64BD5F8027B
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 00:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64BD5F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j9oP+00N
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BF7743F1B;
	Thu,  3 Sep 2026 22:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DCE1F000E9;
	Thu,  3 Sep 2026 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474266;
	bh=CXkj+ciVSQnKuFHLfxJ+AH1g0GENl6snN/jCCKdwu6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=j9oP+00NbsRyaBLU1yGkfowCMtwsKQH32GGXLg9UvSOwBSa/W3KbjVvnPD5jvRBhl
	 u7QzwfanLiwNHlMg92677npgqj3Am83Gun17iOYSN/Lgq2GIDYKeiwcevDKFT8CvVY
	 Nto0yzWKJpKd8ftatKMiiE4h5npLSQmtRzn2/AqCUklkG5ePnsFOVDCZCwaqNuqGdL
	 EEH+tgomugg/1nHb06W69jO6glUAYUMNLyilqdyoObV3X/4Jwcm3i90THOikjIsqIc
	 /LFKynThZzdi+jRbLJjO+rM6LD6ghGH2ObyV124fnGPaPWFeu36stgmXqs2v8iQM4y
	 PVHBgrBGFqxsw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 Neo Chang <YLCHANG2@nuvoton.com>
Cc: perex@perex.cz, krzysztof.kozlowski@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lkp@intel.com,
 neo.chang70@gmail.com, kchsu0@nuvoton.com
In-Reply-To: <20260903033845.76540-1-YLCHANG2@nuvoton.com>
References: <20260903033845.76540-1-YLCHANG2@nuvoton.com>
Subject: Re: [PATCH 1/2] ASoC: codecs: nau8360: Fix static declarations and
 endianness
Message-Id: <178846838050.628640.8837907394544028178.b4-ty@b4>
Date: Thu, 03 Sep 2026 21:46:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bh32NNFh4V0KPZun6DdScXGwhV3jhVB4Jo9xPuKAsnQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqmfOVvBi9WjqcvUkLpXpOufeInV+6QCe0lh5cj
 bliiZ+loL+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapnzlQAKCRAk1otyXVSH
 0MPLB/941VX7Zr2UAC8yR5jKAoNlVKaCGhznjjgkXEQCoQdwdkYtCo/iZogRH4BC+ekXSUQk4Yb
 IupyX5N+Yv9ay2YKqUcH3cHAYLWTAb9E6bdl0ID1tNVG1ZfVdhC6N04m115yJhcLpdJ7vrnsOuB
 HOXAhbQLqaOFy8Xj13iY+SHVQSU/oOIMcYMtkqSXtyn4PYe9XthPUCvWh1/0gGc6INS/GHW9mg9
 XjbOo22SbSEL/R888oItetrwCpO84JNiqp3vmoNAdOJcTNBUnufoK2NW9deCRsyru+LosaCVo+V
 TpP+V9q8eqx056psutLha2cjVdQ13/c5f17sP7e8jj8wuQxH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: NQCPHY2M24YHJZAGJXEUT3L56VS3GZSO
X-Message-ID-Hash: NQCPHY2M24YHJZAGJXEUT3L56VS3GZSO
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NQCPHY2M24YHJZAGJXEUT3L56VS3GZSO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 03 Sep 2026 11:38:44 +0800, Neo Chang wrote:
> ASoC: codecs: nau8360: Fix static declarations and endianness

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/2] ASoC: codecs: nau8360: Fix static declarations and endianness
      https://git.kernel.org/broonie/sound/c/3b05666859ba
[2/2] ASoC: codecs: nau8360: Fix kernel-doc issues
      https://git.kernel.org/broonie/sound/c/aa19a6de4a08

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

