Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1C3F459F5
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:29:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2F4A6020A;
	Fri, 10 Apr 2026 18:29:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2F4A6020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775838588;
	bh=/+YZ1Sp45lo5nkZ6tGYiSc6awNAtCrSibl+Vl+PRmUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dWcKgQewvngaJLzrjSn7Zxzwm2W3jkAgCZcV7Pm8SaQ/wwUPe+L8zm9Ww6/2t8kbR
	 YG3SFRg5qe8vSkI4hC2UT/dbfJlqkWOFtvzvgTm5WT+fgtMeCK//8qlqGdqhtdi6q6
	 HsK6QZIC7EzIRwzy8GhNfOOzBW36dYuezNiUYvcs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22EEBF805F2; Fri, 10 Apr 2026 18:29:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 926D0F805EC;
	Fri, 10 Apr 2026 18:29:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3447F8052D; Fri, 10 Apr 2026 18:29:03 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 87945F8021D
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2026 18:29:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87945F8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UarNXJUS
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A51543A66;
	Fri, 10 Apr 2026 16:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAE3C19421;
	Fri, 10 Apr 2026 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838537;
	bh=/+YZ1Sp45lo5nkZ6tGYiSc6awNAtCrSibl+Vl+PRmUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UarNXJUSQcQsAOB0ob/lxarf+7nUEcxg/bT89jtlf1R7W5n3nNNKjlKGeTOBlvbXa
	 5ufTv1uSI35JOs773pBaqtLiXGr86dO9c6qaaMhnhKyxblafl00FwlwdIsDFeEbGhp
	 kMVm7TQNaD+38hgvZxmK/KPpyXL9WOeTh/Q2tqgKMvZ70SetFtpUWULU4zbwnNd10O
	 QJWv1Rrm0zhI01f+aNqKushhvNRCHy7OI8QkaVHP569mU3KzZv7NAu3mBrapGdCdV9
	 ZBMHtQ42h3pQh1GxpIqVX4QrgHgITZmfl4j8ptfhAy4MxePJiYWjRWEzVJhjgJnCd9
	 zukZY2Rb/Hgfg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20260410064225.662656-1-jack.yu@realtek.com>
References: <20260410064225.662656-1-jack.yu@realtek.com>
Subject: Re: [PATCH v5] ASoC: rt1320-sdw: Add an approach to get new
 hardware advance gain
Message-Id: <177582126721.1165659.10335640489522439077.b4-ty@b4>
Date: Fri, 10 Apr 2026 12:41:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/+YZ1Sp45lo5nkZ6tGYiSc6awNAtCrSibl+Vl+PRmUk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2SVGPqRz1ZzDJeTGSTCiJOBkRYTyrE7YxSWxs
 /PY7PofkD+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadklRgAKCRAk1otyXVSH
 0OvOCACDJhXNF9q3neiA+ELPOqtY8p6dGIS7CaTCEgmi0WCGZwYt6mRAYBdi4AoeGJR2yoMVXu+
 im3nNhFLosJB27TSrkY9LdAF0YGSXWSJbd9fUeTxs28L4Rgvznns2U9L8/wS1FawyZPZ59KN/on
 pmsgO8scA8b5TbqQBIo5zRizo1eP9ah2Axjor4dBvIrIMGtTF5GOOjeP27AL1EPIdhMAH5YM9+E
 emTHzHlv50X5uubkn73HqgRGMSesT2d/GA1sh2if2bhgFUpgsPaIWkO0mI5LcI+npQYp5168SgV
 5Y71iAlHL3V33w9CCOStouc7yR9sU6iNbQym45mq4NjcCCnx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: MEOK4VKBET7HDVPG46N4SL2WLNXVL23Z
X-Message-ID-Hash: MEOK4VKBET7HDVPG46N4SL2WLNXVL23Z
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MEOK4VKBET7HDVPG46N4SL2WLNXVL23Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 10 Apr 2026 14:42:25 +0800, jack.yu@realtek.com wrote:
> ASoC: rt1320-sdw: Add an approach to get new hardware advance gain

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: rt1320-sdw: Add an approach to get new hardware advance gain
      https://git.kernel.org/broonie/sound/c/2603ea46ce5c

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

