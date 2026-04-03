Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289D5E85381
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 16:54:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 618AF601EC;
	Fri,  3 Apr 2026 18:53:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 618AF601EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775235245;
	bh=gdgdM3fB4wzItjFyG55Tzp7c1I9NRlNk9iyF2DU2vs4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FuTROJIItx0m/Bq7Tvy+9CmgHJTRLxRVV1j0xBdz2u4Ikzlv0o7YUaW311tWmOuXF
	 lXzxAE4m8frZNY49yK9MI8eLvcDv0OFAcAP+YRZtVm7XQfvuzCqCHEhYc6ahSAjRkq
	 i21DklnrLyjZZdMm4OesQVNI6viay/CizUYbsWZM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2082F805EE; Fri,  3 Apr 2026 18:53:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AC6BF805F0;
	Fri,  3 Apr 2026 18:53:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 788A5F8055B; Fri,  3 Apr 2026 18:53:23 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 58771F8003C
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 18:53:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58771F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=aIR+fRDj
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 742D740BB1;
	Fri,  3 Apr 2026 16:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75112C19421;
	Fri,  3 Apr 2026 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775235198;
	bh=gdgdM3fB4wzItjFyG55Tzp7c1I9NRlNk9iyF2DU2vs4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aIR+fRDjb+43amjIqGzovWhz1pElZznj9y5auhRImrqOAdwQHwamh9zuyio4OXmgp
	 sKoE8SrWkj26/KZ9v0RRdHTbY9ulZ3VzxMF2fI9N63yYu9CuVoGb9+MqRLHnbyvq3U
	 p71kxhY17zXQO+Gv4EdrWIVP67H4DFQXIjGKwkVHwlB5sFZZMGsJFV75tCADOu75G4
	 Ob6A9xrRF+lBOKXqVI11QyX3+IduLHaQ1negvND+mm10s8mzxjnTc2cTjGkul94CRE
	 cUP5hO5AJObbuFeBvf9wf+pQtUsZRA2rGT+y4okmu2Nw/EhrqlUBlivgPi9iz/VeQH
	 9Ps0llUM0B+7Q==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 superm1@kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260403063452.159800-1-Vijendar.Mukunda@amd.com>
References: <20260403063452.159800-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp-sdw-legacy: remove unnecessary
 condition check
Message-Id: <177521978957.52946.6156656301842370789.b4-ty@b4>
Date: Fri, 03 Apr 2026 13:36:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-67696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gdgdM3fB4wzItjFyG55Tzp7c1I9NRlNk9iyF2DU2vs4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpz/B7FJbf94IhmapyyNnMkezArRcsEdJqN6X6l
 fEKaRi0a62JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCac/wewAKCRAk1otyXVSH
 0Dl0B/wMkLXnl5+Qew0RjL9kFbrfEkt/GJfbE0xPfNlN7CvgPPflT2A0rii2LCuif4UqU9AfyFw
 uIUMHHP3CLs1z/UpXia9nopyrhXv5KGr28ZtbEvRBammeqiZPpJmRDYrecDLm9t7bkiJ8WiXDxX
 3H8jLo9qUFfCR1/L/59PZmHarhWRJZJD6fcolA/rQ15dg6vIjJK7I7xLydxkHJ39ombQ3pUbCPw
 a57lfZ8CNCVbemxtAz1qbrXMFh7KGKf9plKBFIN6zmf5MGMB9gzu/sfvtQoq3Et6lgT1Tq6nGae
 qrEBw77wLHR07Q7LlbJIf7oN83ltADym4l8OjWIneGfPfR6g
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: BOSS6D2YYXFSGNA6LULQUHNOL7V4XHLK
X-Message-ID-Hash: BOSS6D2YYXFSGNA6LULQUHNOL7V4XHLK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BOSS6D2YYXFSGNA6LULQUHNOL7V4XHLK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 03 Apr 2026 12:04:25 +0530, Vijendar Mukunda wrote:
> ASoC: amd: acp-sdw-legacy: remove unnecessary condition check

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: amd: acp-sdw-legacy: remove unnecessary condition check
      https://git.kernel.org/broonie/sound/c/0178e6412312

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

