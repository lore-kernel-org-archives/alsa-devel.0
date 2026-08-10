Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33B0C5AD7B
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:49:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AD0060209;
	Mon, 10 Aug 2026 18:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AD0060209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786380550;
	bh=bWCqiYDzg+UCsgY+rUcpj+sy1fpvfgzvU5kGvelbjPs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WQPE+b6RR5zVh9bSFqK1UcvjI4kpj++lrW+cwepgpViP42tgsM1YUe4cLS7yxAD7T
	 4/UqblquXV8a8uBez7hXoh1Ql6FQ9fDFxxeUVqK0rjQ9d0GzgWrfKlO49SQngkvX5J
	 0SqNHIn/Gvuq22psTfF41gvcKmJvca7YY4Ho1DZI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37835F80601; Mon, 10 Aug 2026 18:48:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE710F805F6;
	Mon, 10 Aug 2026 18:48:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 521CEF8051F; Mon, 10 Aug 2026 18:48:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786380507;
	b=J4dqNRmI1+nKnSD4Z9glqbqK8meArFTmCK/u3HwFQQl+AgqyWiIQGHwcRyxi+uMXBZ5j
	 WYwh6cJQApwttkYzupLnXdUDPHNr80uQQYE/8Ddt9D7TWiIDI2xD0LFdwNjqKvNuEN75S
	 LMY/fSF9lsl1QIbsysRQdfahV06SUmQ3OJdPJYAvo6TRQeR1koMVoMImqaS8stJqHxtUU
	 uJnLl7KP5m0Q6ogvci3tcGZWa/R5gmqPMNIKWcJCpaetxAsC4eSNqyXBMe0UNu4Pf5W31
	 CJY1/W7uIEtvizGPFFDAa4g/mWEreJPvw+jSakhmmH22Kwlt6qWQC2XRYyGOBNTBAmw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786380507;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=bWCqiYDzg+UCsgY+rUcpj+sy1fpvfgzvU5kGvelbjPs=;
	b=mxlNlVJJQ2vBP3VTaTs6zT+06m4F6UJ4+a+Gj20IpffWNgjRYB993RqYCKEO2+8+qXel
	 bVbcUKUynsSDFiOJ2LUUosidogLCvJ1RLJVIrdZWgIGnT0BwBdp1Jvec08valDac87sCq
	 Jaip7nhAcJONnwR+MX4T2JFC9fbCsZnAf2Kdrak34DsakwL4MXxb2R6zlEFbzGuA21XDE
	 9uPDQ2l7N9ixCZhTGMuC8Pp0anuA8ekahCVkZSYXyjrl8QfSf+QshS7GMcuXhyYB5yX/w
	 B3m6EfkLOxlXLOgAgbSlgxZdFxp3zK3lncfR+U6Bmxh+flrvwlqsNK2B8TkTDnb8ieg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fPWvC5Tn;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 687F4F800BA
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2026 18:48:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 687F4F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fPWvC5Tn
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EAD8A60052;
	Mon, 10 Aug 2026 16:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CFF1F000E9;
	Mon, 10 Aug 2026 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786380503;
	bh=r+AeOLPbrsL3yUxkJi/4Fdm75CpPUzsCo/edWcnsE04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fPWvC5TnYT/NFdt4KeTMCVB1of7HKnr96eABsIY78cF1p7aEX0X0egYJFtJGDS0QV
	 8UsSQ6wWd51Vf8ct822dqoCDPtDo9WTLzwJQQ5/yoFj+2E/qfXu/Y2s7okE4C8Gael
	 LFQTqvDdN+2YXOXJcxg6MOokD0wEUgOgj7NyTcl6uPtE1lSrXgpxkXuKDW2ufcgTf2
	 PxCope+/lsDnPLYeE0dZA5r1AMq1/l6+wxLfka+HcLCErrdtrlnmv6wKR7PDzqgMxe
	 ceMF2mtbFkx91iQv6nsRb0DDBHkHEbFBUpR0jyfMVI5rvtJPxhsRFm5BACRJ8OHvlb
	 Fl31lUT/pm1CA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Lin Xianglin <1021538027@qq.com>
Cc: linux-sound@vger.kernel.org, Vijendar.Mukunda@amd.com,
 venkataprasad.potturu@amd.com
In-Reply-To: <tencent_428392223C2AD3BF23E7ABAA7521FE5C0C07@qq.com>
References: <tencent_428392223C2AD3BF23E7ABAA7521FE5C0C07@qq.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for HyperX OMEN Gaming
 Laptop 16-ap1xxx
Message-Id: <178636518244.155010.2458739450437226019.b4-ty@b4>
Date: Mon, 10 Aug 2026 13:33:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bWCqiYDzg+UCsgY+rUcpj+sy1fpvfgzvU5kGvelbjPs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqegDVEH4gF9cKYxy23rHAgZsJhB+3683JOrfck
 kIDfhWPnWiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanoA1QAKCRAk1otyXVSH
 0N5pB/91TKQ6WbrBegHOIYIFG6sBlGufHmnJ95yljpR50zBEP7hPTl2kI7cIWUo2eeWPzUeKo9P
 EL7HKVutuofbGOTo3eukJktQHe0bc2oIOA0+R0jXLpH2rNg0r5wt8WjZhjDsmhqmgqouwqOjKHi
 c9HFCOM4sTqCAg4sypxznTD/I9Lhpv4+RwRAfVt4T0EhJAHM26IW7LChTRcePnHrMBgOedUlhsT
 sbgtce8E4va13G8G8Yvmvd8KZA8moI4RvkeYSOsB1A6ZlHIXXEYpeb+ZDAHy052g3gMP5aM6SNJ
 pbifmgbe5GvVEmxkKflRe4wQbv5nKJ/LkxWikEE1FSFLzetc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: CQU2CNE56BMRO3MFK3YMWCKDTTIIPHWL
X-Message-ID-Hash: CQU2CNE56BMRO3MFK3YMWCKDTTIIPHWL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CQU2CNE56BMRO3MFK3YMWCKDTTIIPHWL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 07 Aug 2026 22:19:43 +0800, Lin Xianglin wrote:
> ASoC: amd: yc: Add DMI quirk for HyperX OMEN Gaming Laptop 16-ap1xxx

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for HyperX OMEN Gaming Laptop 16-ap1xxx
      https://git.kernel.org/broonie/sound/c/fe21db8c5e7c

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

