Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE85C88E6A
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:24:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3EA6601E6;
	Mon, 14 Sep 2026 11:24:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3EA6601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789377857;
	bh=GKBHGnikF9VpTNKsBk+eTzDvO9SLnmGHi6rQR1PszOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tdWtfbpDd7uCv7/T6Ts8GGZH5BKP9fOywfhqDGculwZf9besGsLRadEt+OkI7Z8YB
	 gdnYAWDmdXKEVFeI6xCSO4eBaO7yv5qbICBnLcv66gYfjA/vRaBo5it9jcKu6PQmOH
	 hXnQxGlqd2G1Jn/JBNtMapLlg7Akqr3SEqlkgIQM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2AFEBF805F8; Mon, 14 Sep 2026 11:23:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B679F80601;
	Mon, 14 Sep 2026 11:23:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D7F9F8049C; Mon, 14 Sep 2026 11:23:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789377815;
	b=Yp9HUA9jjoSaGi67wCggFMMA8HfoYkNkFYQSjG0WCZz66mIxDxuNGBhg1ZRf+hjHIcFZ
	 lfVsf7sDOdoVwUPCFTP10AWrm0ODrg8vBa4s9YyQXJhMxDkwTcQKSIJN1yqNqwqRNxrbm
	 Ok53CZcko+LYkGuVpanlgtoG3WIW+15zoqD7UWQzt0ZSFiYT51CgveSmPYGGTf6ma1Udf
	 2SUrvuoyqXKTAmqvP8ly7/QsjWtHTyUPxoLOCnn2TGa4z/HYsbTVK7Y3aDGOXQerB1r93
	 dALbXdi+IpwXELeVfG/VWpeSqjdwuU/H1l6LJx9B8t5JEW+LZjqf2SHtQ96MQMdh7Wg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789377815;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=GKBHGnikF9VpTNKsBk+eTzDvO9SLnmGHi6rQR1PszOQ=;
	b=kPluj2KUd3Nb6a1CXJ5eu+zh2EEB6mfyRvK9nLoF3RReJ8N6PgpIwRVVXtXDgVU99rTP
	 rlHz9iuHTT8GEfT1tDY3iY1ZQA7Rfo0j8TMU8E266ZOpy+UhibDffKu3W1twGlP0D+cgB
	 fMePdKAYZi3Hfyd6PdgUxgC5UIu1Y8qYQUu8Itvdh0lTE9xJBlCP604ghdneJVr4zTI9o
	 igJaPD5ehA7EQhVEmpTFSf+8Y9gaC1rQr+1GgaH2+3FST1tRgUiG2AvDCpCCuFb9DwruQ
	 t98UZ43N7Fok2X2fgrl9WBei8P+4dcngEvegtHjQXMfpSzDm1C94po7ee3VlQDgww0g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IO4x2I+s;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E127F8014B
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2026 11:23:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E127F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IO4x2I+s
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D874B4043D;
	Mon, 14 Sep 2026 09:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DA51F000FF;
	Mon, 14 Sep 2026 09:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377809;
	bh=pPdIMKENbNZM5H73FWb7ilORiS5+25WbfBCwubTa4rY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IO4x2I+s2y6/KpeDgmi5BIX960vLwS1+eE5N9u6DmtU0FUmxBVitlQmmUjUpTFveG
	 fUQnNpkZSot2+Fx7EgqPz5hRaclUzlYmSRyVHKLdtKZsqNeYrR3GCeeCz9q5k3kDBa
	 lKRuVklIn2AoHxQHNdt2yStaSvu7CEZyN1xxan0wwc7Kq7L1TNZcnXYvPTX6TD2Xw6
	 7nSElPLFCe5NAGxArFl90ETlw/7tQxDCa+JVp4/BPQ5j5y1Snh4ahZUw6UJFHWNn7J
	 SRQQzbMoepXcJBbMQMjWMvB3ilHdNNHu7mttHpuv7s2mkPja1L8C1nhVeWd6NMr2au
	 LkYYqed4kQUdg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com,
 Trevor.Wu@mediatek.com
In-Reply-To: <20260909085449.862350-1-jack.yu@realtek.com>
References: <20260909085449.862350-1-jack.yu@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt712-sdca: reconfigure PLL2 to fix
 calibration time-out
Message-Id: <178934247726.1239410.10421672036013760773.b4-ty@b4>
Date: Mon, 14 Sep 2026 00:34:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GKBHGnikF9VpTNKsBk+eTzDvO9SLnmGHi6rQR1PszOQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqp70MALszw74TZSrZiGQG6zS5BIP9F96j80vxf
 Zwdb1LUFRqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqe9DAAKCRAk1otyXVSH
 0NcHB/9fP9rwHr5Jd6XH2+JUKEwku9GXs4ZUbRTg8vMYFguvTtAUnxfj3am0oZxDd9A82kQihME
 G7BIHu/8h1nIwxIAvxeR6UfeoLpVk//HChJ5CM1x6L/4Gne0v2ifqk1F9MlETVUBpuI9AfmZyw7
 cb3s4AhnYikR87kwWyeiuSTC9H4kXVxSoKLOOdNM44hpdpiz+NoSBhpYC0psv3astRtuEr6+HrH
 fFb8CO8fnqD1oSK/+Bq7M1kfFCqPqMNKXxJvPQxP5CiXMOxXh9PXiRqkZ2paAzHYdnPkzs4oWlD
 3xLcPlNxxAyCRAmycQk3F2kQWUVVB6eeNfooImMnTV7jiRFQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: VMHSFV3NDJZJA4XSTBEUNC7ISXXS5NSN
X-Message-ID-Hash: VMHSFV3NDJZJA4XSTBEUNC7ISXXS5NSN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VMHSFV3NDJZJA4XSTBEUNC7ISXXS5NSN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 09 Sep 2026 16:54:49 +0800, jack.yu@realtek.com wrote:
> ASoC: rt712-sdca: reconfigure PLL2 to fix calibration time-out

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: rt712-sdca: reconfigure PLL2 to fix calibration time-out
      https://git.kernel.org/broonie/sound/c/d56fe35c1bce

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

