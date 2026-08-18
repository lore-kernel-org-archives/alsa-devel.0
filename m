Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1DCC5DF7D
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:47:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8215060258;
	Tue, 18 Aug 2026 22:47:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8215060258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787086058;
	bh=Ij6Dq2Ksta6R0zqoUhN8/P2hFkWqrnF9FJCsn4i9JaQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jdt4AwAy12DUlWcZ1KM0nIWFjCxT0QWaddREo0nqWdYqoQ/CPswTQhrVxsqozGE/a
	 8m1Rvo6eZQ/P8cHnxvuqAnM0KQ0n04hDGbbSmf3iwkccpILrd1td0xLk1YnrsWZIwy
	 QS/bgZf+S4f3WyG2l1rQ8/ZGD2VSs9uxvv2Z2ZmE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3B84F805F1; Tue, 18 Aug 2026 22:47:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68B42F805F5;
	Tue, 18 Aug 2026 22:47:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C043F8055C; Tue, 18 Aug 2026 22:46:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787086016;
	b=DzfgB5NQVCbxrr7zkQNHArrlOnJPIdqQ1gyXynxGYOG+bVKsEv0KIOR29YLyB2TuMa4k
	 RYv4+00jjS6Hs9dLpIm2uP5PqRlE5m0KFyldW/og/+ITkbUivqjX92lXxDOTzKqmi/ejz
	 6Ym8JKJVrqITPfqpx0NbNQ2X31ntCXA8v4fLXnvoaTH0zDjJZvqFPOKYXP9Eftsjpr+ul
	 C2D2Wrab3gk6kllSNhB1hTTeLMhNRkuWae5FHT2f4o0PEkfh9VLMA+Pjwa8dgrWO2iwRE
	 Gloz0hVYNzJ1niRXlM8RMRi2ujRQ8nnic/vYqvjx5IO24lIMVKfhFb/DjDLFDYF9KPA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787086016;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=Ij6Dq2Ksta6R0zqoUhN8/P2hFkWqrnF9FJCsn4i9JaQ=;
	b=Ua7MTgHQPqMlykNubjk17xZKR8nOF+OT9aaibOW1gCc97yjddMYf98AEwXyPNztcLSha
	 JqAFDEq7NTZF2CkctPUAsqyYT1jAhDEfYIeODG3zTs5SUCG8Yn8cNtPG4nNEXXSqDVF6s
	 U3F5o+S9S2Ka9vbeTT514iuULV1zPtQOdEf91xcSovBiZItw0TWqoWjyAZ22nzz5n1rNJ
	 e4hMV+OmdK+6qXSarr01WJTZHDT5qme3cyQvi+JzOf67kEF3QaSl64d0XnA7hAf3f3Eb4
	 uWYeJDh5lt8nMagT93DxAp+dCNl3/v3m3XurbtqT8AxV1irVL1ZZKNHeG0o5+HMqiPA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="FB18/DnT";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DF88BF80272
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2026 22:46:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF88BF80272
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FB18/DnT
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AB84601FB;
	Tue, 18 Aug 2026 20:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133B11F000E9;
	Tue, 18 Aug 2026 20:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787086012;
	bh=JcW95Jw/Dg4v1/4IydvD3F+DJ8Cl6ZEYjhgAIHMQahg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FB18/DnT5XxeH6xfHpRVHmBM6qQfIsG1su/u6h3ZlrBzoSVv/i0MgNWAVrBRR+MGj
	 CryvieWtBlLWia4e8Xn3vjfWXYaty2XbBX7NpJw38B/gfwQYUUyVBcFihsTPk2qx0y
	 lp/n7Kheyi7tTQVMVjIFfhYg9rV5iZeNhDw+smB83igk1dq3PqTJpveNhJr9uydVge
	 lwTHFBm9X48wvrCpoIY6XFw5JaK8wiQar0hetNFMKm1AvnrSREEebl6httny+TsRMA
	 Dyv6kv9ennNHYK7YBeRsdV9YnwzlvEZA1cayKhRwnI4WsDkyq3ZITzYfJQcm+7C3zX
	 1z8Twr2iIqgvA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com,
 Trevor.Wu@mediatek.com
In-Reply-To: <20260818023018.2564212-1-jack.yu@realtek.com>
References: <20260818023018.2564212-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: sdw_utils: fix double put_device() on aggregated
 amps
Message-Id: <178707426194.154835.13664225607459822912.b4-ty@b4>
Date: Tue, 18 Aug 2026 18:31:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ij6Dq2Ksta6R0zqoUhN8/P2hFkWqrnF9FJCsn4i9JaQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqhMS3+qgG/F+RqSIuW0H/mZQAN0qNUteB2Klj3
 /tvJ/bDxIqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaoTEtwAKCRAk1otyXVSH
 0PgIB/46KSK6pBUAljZfupOxHOzGMd0Bh2c2Be15SB8/TwPZcVByUuvUp2s/OdjmakGVSzgGDkJ
 S1EHaJCEAvkTAidnmz58UJAFH5YC6W2igbmNOgWg5cD10sxTBCy2Qjkx7inkVVx7D2C6NFOkMve
 SMBDo9IE47RuyYk721dDlFF/FX4snf3uq7ngkd/DttYzC5E8vfhQ4PHhLjeUE/FXZxH0Fb/PIZ0
 NoeB6E02kirKS69pcOjRiJavlLWooVi/UrNkqBWO6msPDAkGIzuX6WplU2L7iHoQRqEK3Qgq45F
 6Hys42TeJmA5xSHqFBjXALLkClGdfoEzXwcNSR0KAqe3xrRh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: HYJGQSOOSNBNWBXS3I2IZ4VM3QWS4C6A
X-Message-ID-Hash: HYJGQSOOSNBNWBXS3I2IZ4VM3QWS4C6A
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HYJGQSOOSNBNWBXS3I2IZ4VM3QWS4C6A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 18 Aug 2026 10:30:18 +0800, jack.yu@realtek.com wrote:
> ASoC: sdw_utils: fix double put_device() on aggregated amps

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: sdw_utils: fix double put_device() on aggregated amps
      https://git.kernel.org/broonie/sound/c/046173b98de3

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

