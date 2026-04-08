Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92FDEA3C5D
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:20:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50C3060201;
	Thu,  9 Apr 2026 15:20:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50C3060201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775740825;
	bh=OP+VxMosOw+23cNGj1kWtov0R3eIIt63PQByiRtkhMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uv9jqklF0e+azGsq8MFNwkuiMsKtxwhFgVDxx1v6KwCmNGjQLlU+xb1rHrd8ed33E
	 UbYBHJJqcxRqXEsJO4rvZK5m+quanICgkmxln+Yt2dhTjF1eilUu/h2TaCDFip/PE0
	 fWUXszFQcFIMznjNTZoiKydrWxYT/dhXrA88vymY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 404FDF805EF; Thu,  9 Apr 2026 15:19:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C4F41F805F2;
	Thu,  9 Apr 2026 15:19:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D492F8052D; Thu,  9 Apr 2026 15:19:39 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0BC14F8012B
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 15:19:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BC14F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rCj7TYT3
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 07DEF42D79;
	Thu,  9 Apr 2026 13:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7D0C19424;
	Thu,  9 Apr 2026 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775740772;
	bh=OP+VxMosOw+23cNGj1kWtov0R3eIIt63PQByiRtkhMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rCj7TYT3GYQdLEiVKkZTleArjC6/96sa5si4swuoAOMQN/ijjOa1riE9A2/seQkp+
	 6X6Jt80YaZSO5p1zJOPH8nG3YAVQj22O7nZxtBO132d+o86ipNZP0CacpC7Z/8fQtQ
	 8u4EnJdvrqWDxt2XgOLm31FhML7N2vt2/Lp0IeeLekWD6yUQsg2wFVLs+zVKZup9eX
	 SBFwRX+jk7k8R5CAdaDgZRLeLUaQ5k+8hizn8yIVTadzxAcS7aBD0LQhpvWEum5Wv4
	 5biyqGFt8V7fyeDorGtBGP0zQja85itILwjrTRDvJbiRgigjRUAR04XPxSnKYcM0+R
	 5Ont+6stafFXQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, tiwai@suse.de, 13916275206@139.com,
 krzk@kernel.org, alsa-devel@alsa-project.org, baojun.xu@ti.com
In-Reply-To: <20260406103131.1883-1-shenghao-ding@ti.com>
References: <20260406103131.1883-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v2] ASoC: tas2781: Explicit association of Device,
 Device Name, and Device ID
Message-Id: <177567156758.101848.10773804957695802090.b4-ty@b4>
Date: Wed, 08 Apr 2026 19:06:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OP+VxMosOw+23cNGj1kWtov0R3eIIt63PQByiRtkhMc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp16diy36/a11azdKwXVZ08oecZJoQD3zD0aD1Y
 CWMW1KN5j6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadenYgAKCRAk1otyXVSH
 0AJNB/44Ufi1HziKBD4OIladyQaj3lXyWm0VAXZNwyaxTjD7SQsIcndai/P7zMuXlmylN6qDNzV
 nsL8Ui+f1qepn+xxm/8PFsiAdJpgfSF8d1/hKYXzNQltmaQ1m1mU7BtijqSAb1D9PIM3cRCoAf8
 UOquDqWAns5sFFhd36ksGCCc0c8lKc1WHR+C+o3JIEeMiWBiNgj/7nhQVII5t4WRFItwl8CoRDi
 gGyR8hCtHvendNaafMhISQwpgQbdkDtTtkbmR0vxRn/6VzH5hspvMSMJ/gE7sZ72kHxsn6We6IR
 NuQG3mSJ2t/nHIE1oCKzvBA4kN3w7S4DJpWJ1/Nb4iJzYyD7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: USQXBNQ5QVUNRXUU3QQR7STQKSG5HKEV
X-Message-ID-Hash: USQXBNQ5QVUNRXUU3QQR7STQKSG5HKEV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/USQXBNQ5QVUNRXUU3QQR7STQKSG5HKEV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 06 Apr 2026 18:31:31 +0800, Shenghao Ding wrote:
> ASoC: tas2781: Explicit association of Device, Device Name, and Device ID

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: tas2781: Explicit association of Device, Device Name, and Device ID
      https://git.kernel.org/broonie/sound/c/9a52d1b7cb4a

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

