Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2422C43458
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:25:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD89F601E7;
	Tue, 14 Jul 2026 23:25:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD89F601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784064334;
	bh=LIJ80AtCHeLwEzZqib/R0hJtmzcMAuexFfgA5l+yvdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fegEuDCtb3hpafkaDPrcJLrbUEgncFsdzPXKeKRichaOIsr4nvlee376p1VoA/Vex
	 nN93HQ3ZM1HIQjAnkGwAIHJTKrN3u4KiwoZ0CRvDgyk6Jji3IeL9NiVofXvnnVZ8Bs
	 Mg1l/3dbhgcXRKNv/vkG+q1LvIoQTjcE7iYQLIes=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19303F805FE; Tue, 14 Jul 2026 23:24:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A1929F805F8;
	Tue, 14 Jul 2026 23:24:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF328F805A8; Tue, 14 Jul 2026 23:24:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784064286;
	b=PfP0i5Y9EwzcR26gd9C/+NxUSGt3huEDZL457peylb/3oVU/yox1X4OwB20CCgN0+1m0
	 jEUjcT87t4FIucEQKj0R/CZDCzZfNJLvL39Z3Kq1xTjU7FJakrwe0a6wv6VydEbtVYOha
	 RICFR1AQec7NU9bX5tcniHkMv7Ns1Ld77C9oc3RRSv7EBRQYFv1kcjCQ/lfc+XXzq/NDj
	 GETuor7+8U8YSh8fbnJOuwrA8QEX3s0E/QqiXHKLpNUpvMmwXGFYtScxqv0H9xnUarNqv
	 +fg6RnQImiUvSKIPpIq/vSIUzybQU+b0cVhe75IP+oraE7/G7HgCncKetvyntAMO47Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784064286;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=LIJ80AtCHeLwEzZqib/R0hJtmzcMAuexFfgA5l+yvdk=;
	b=cdAl9tM4s+XeH1a/aKd3bcgMHoq/Lu14ztkIqPR1lFtUXyRHLhyiAhA1Yv6UvlzdRDXS
	 pK0ow/hLfT35seMOEiXx48b5SG+qLxIt420fajU7FQcUrDQab/7YWRU2Ei+DNrHo6S8Mb
	 BVCy/8pK0UG+Klyv1ca355koaNueqKBuHuxbgpjzLhEClLpHRexJI0NYkupQZhPdyHrCD
	 74/xgyZBOc6d1bbbm6FdMc9Exb1WtICJeaydyEqTYj7iRbsQ9oH6J8ogGyd8h1vjxJ0B4
	 jPb45VELpw3Km29v+Hn/uX8TcTNPJL8MqdC0sVWiToe+x1AY2IBv6qPS70CUXxeFCAw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XJbIXL7p;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 46E80F8027B
	for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2026 23:24:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46E80F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XJbIXL7p
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CEB041B43;
	Tue, 14 Jul 2026 21:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99EA1F000E9;
	Tue, 14 Jul 2026 21:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064282;
	bh=eq+7dInl4Hghd1VPQ1DAfZ+ZdaOLBvsOzzjklz4MSlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XJbIXL7pclW4KUykxyA/43qAbSueDdVSmiAviBX/vD4u8zbC7czPMIBq1lfoPGwZI
	 InPnvw6PmXn0tZH+2qPG6qvnwi4X2N9+13AtAIgqAHvNAoh2GJw8N7n2y17Ct9163C
	 THC/8dC1T5PBeraBnuakZ67tfCYmaCKZXIes/5qMh4gqvvgxcengVXWUV/YfQI1Ytx
	 wxmVRXb1yopE4Ak+QZs71gfoiNJ4VDZrqit/PjjA2o7vSyyLquqBsziz/EQDW81vru
	 ULJQrxRlpZ2quFPkohXjYUaJrAaG2+/S24ZIPxTBp8JRJQYFc0mGPYFTPYiZFS9Mdi
	 ECrIMPq4Q7pIw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 "open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20260710102926.1633385-1-syed.sabakareem@amd.com>
References: <20260710102926.1633385-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH] ASoC: amd: acp: add ACP70 DMI override for new ASUS
 TUF platforms
Message-Id: <178397058426.7914.10290763523746838086.b4-ty@b4>
Date: Mon, 13 Jul 2026 20:23:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LIJ80AtCHeLwEzZqib/R0hJtmzcMAuexFfgA5l+yvdk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqVqkWQ0JVDZPR80AgCsZooE9r2RbXddt+L7OpM
 u7PJVIvgSmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalapFgAKCRAk1otyXVSH
 0NYKB/9+LKn7SdQZ695ihXK/1QXzkreRJl6wXQoEwme8SHGvv/NOwYtUe8A3y1VVFWWCz/oS2MF
 Lfoq6sBGqbPNFD3VLUVrxRrifFwq6S0eEQsJjHi6PtmJs9pP8Uj2AAg/h5x+YN0gDXxqh9KvtKO
 FcGnPDE7DMHu271Mu6fLE4CLgOoNqB/tjzrbR14cVuIED2WzU5Fz6VBCpu432fxeplpO32h7dJA
 RK3l8qRzpWv/noYcLA4oJiyyR2AwN5T2hTpRy/8ly6uZVvxVDJSdbVGSZxovr+SC9K6UkZyjoZZ
 jTfzVsQWLgw0uXvN+x+x41V4ZwuC/HUI0y4yGqGlEH9GyiZ8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: UA2L7V2W4BE4MHITNGI25OBYCYLC2D4N
X-Message-ID-Hash: UA2L7V2W4BE4MHITNGI25OBYCYLC2D4N
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UA2L7V2W4BE4MHITNGI25OBYCYLC2D4N/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 10 Jul 2026 15:59:19 +0530, Syed Saba Kareem wrote:
> ASoC: amd: acp: add ACP70 DMI override for new ASUS TUF platforms

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: amd: acp: add ACP70 DMI override for new ASUS TUF platforms
      https://git.kernel.org/broonie/sound/c/27d090f3ccd4

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

