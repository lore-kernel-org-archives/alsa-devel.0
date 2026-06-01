Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E8BCD6E60
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:08:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFA6A601C7;
	Tue,  2 Jun 2026 14:08:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFA6A601C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780402122;
	bh=NqhPjva4plXrBGv1+P3BU1wj4ibyGN5tmsGjjoYnrZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qjV29h0lsyRKL74QO+ZWKZ6tfV987/6iK9SlUFwRU6r1lK6zYNvHxhPdCYTN92uyL
	 p2zlvfZfaPYHYo5GI+CDcgaxWnVze74LzkqmXu4ToOIspKdt+/VgFBFtsT0J65KFkx
	 gufK810CU+Dp9JYjWho7k2MSsjwIL/m03aXLyTZc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D1DAF805F7; Tue,  2 Jun 2026 14:08:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42FF3F8026D;
	Tue,  2 Jun 2026 14:08:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8979DF804F2; Tue,  2 Jun 2026 14:08:04 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D3A1DF8024C
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 14:08:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3A1DF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O+ThXPpw
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D61324015D;
	Tue,  2 Jun 2026 12:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB1F1F00893;
	Tue,  2 Jun 2026 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780402078;
	bh=P0lFbFU0XWdzpU4GbFxl6xiHqPxwRpsjqXICjIpUkwM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=O+ThXPpwfekc7vXd6ULUMTll/x/DeanBofLBBPNZltrzXdJZALjbAbfXvMZvfbzV2
	 D2hhRIW1OCgHdyrADW0OpyxLUwwFU4X4UVatqp28dbwRAo8SiafX9NNtbdySxLdvP4
	 juKPRhB0V2NnpwI4YwGbP8IYOuVrVe9M3luSdDrf0qkcF7pYlAHID1B2Z7Zz1z/ir3
	 qiE5oX1M3AgkOHjqfNCLyB+eIHjHDuaaJ4R3BFz9IOnFtBJe9LZ+0GQYc1UVY62GFB
	 GvdZhSbMI7136v1A1rMbXMwD0fl9yHZDBnTevumsPOyvwH+0Gd0+Rnpar8B8c0PZTY
	 LXs8a3WQGpmFA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar.Mukunda@amd.com,
 =?utf-8?q?Jo=C3=A3o_Miguel?= <jmiguel.ghp@gmail.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20260523213548.5219-1-jmiguel.ghp@gmail.com>
References: <20260523213548.5219-1-jmiguel.ghp@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Enable internal mic on MSI Bravo 17
 C7VF
Message-Id: <178033080073.44654.3969618499083899102.b4-ty@b4>
Date: Mon, 01 Jun 2026 17:20:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NqhPjva4plXrBGv1+P3BU1wj4ibyGN5tmsGjjoYnrZE=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBqHsec//r0EDhDdW64XuWwUZvWeaF6OYM7O2UOh
 Nzl1XpzhICJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCah7HnAAKCRAk1otyXVSH
 0NjoB/i9G60w3RyedNYzhegFAEy/BanEEaVrWY+HuVMF8uPrOZZGgdfDK4LkOXu6lDhaFcaWyjj
 w8zVwYkqV7ICTLj70MJ7iPF2VgzX8CA2xqXsNvsBH/1j0yrIkRFa+Ll3LiW9ncNCxpxjFtoxZBf
 DlcsQZ1Kr1EkPbLAAChCsSsMgMHsafPAShHjBMhi/MFgxm5wmoel1G61gIFMgyaDOSE5JQCGXY0
 X2enOLZmNRBG9N2a330HYU77rt78D1i1jkfZvFDbLO4IeTNWvnelJY5GiBMKC9bBRe8pB+mW7ug
 u0oOq0BOC3h451tgrKPYMywXPD1jb7NKIFua9g7iue3FVjY=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: MPXALISKEE6YLVTW2Y5VSOKLIWWHSSZR
X-Message-ID-Hash: MPXALISKEE6YLVTW2Y5VSOKLIWWHSSZR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MPXALISKEE6YLVTW2Y5VSOKLIWWHSSZR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 23 May 2026 22:35:48 +0100, João Miguel wrote:
> ASoC: amd: yc: Enable internal mic on MSI Bravo 17 C7VF

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: amd: yc: Enable internal mic on MSI Bravo 17 C7VF
      https://git.kernel.org/broonie/sound/c/c9c64820a48d

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

