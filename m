Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B97C61DD3
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:10:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B32A6601F2;
	Tue,  1 Sep 2026 23:10:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B32A6601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788297014;
	bh=D5hv3wlI2CaoLrVDhvXydRbpllKQ3x0haqalY9UZnVY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZN3QGFfTVqEdJ1kzYRFJXatHQeBuRmMCfoDNWK+P3C/KSpvixVzx9EI99t5HTytjR
	 7LBarSe2kF6G8fiaqx4eP2Dv/ni/7/RU6IXzP1WBgnRB40syWNezO9USzqiMKz7eoZ
	 YQBJGvTF8b4TQLHH33McsFjzYQZa2UfKsQmFrJNg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5242AF8061C; Tue,  1 Sep 2026 23:09:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 85D06F8061E;
	Tue,  1 Sep 2026 23:09:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB4F9F805ED; Tue,  1 Sep 2026 23:09:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788296961;
	b=aDUkS7NCRYozq6priiBhVe+QMXWmHzC/vvej750Nn8kMt7BZRWXsE96R/ptXgqeE0YXd
	 KShJnenDEX6FRWXQdXm7oaXy1qulIhxRJgv3zkiaC6T3Mz75/WVv6KQjH1R/QOa9n9lFs
	 j/RBUu3LBxaPFSpKMrLMhJeyIlUdVrAim11u8A2swCH9pwg5x4heOh4ybGHxnRydtnCIZ
	 WdQz2csY64YfaxmYLro6tYLyZTjw/l1OnUtEnRG/LK3KYqmB2gUiwMDCtuuOjobXKTio6
	 Ew3KlyJHDg/ySLmr9y4HRex5f4vewUJU/nlo5lp96as6uq/aFIJDST4h7m7paDbe+Ig==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788296961;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=D5hv3wlI2CaoLrVDhvXydRbpllKQ3x0haqalY9UZnVY=;
	b=i5PfTF1HAaYKcdaE3sr42Fk9faW7eRHeqlzkHy2upjxcSbnGYEtomqYZU9G0S2CVLPzI
	 vefCNyDDJYLTkM4sZRAkSa2lVvSdLZ0Ibp057r3oUIdsLn7XiKiLTyKGX6ayhi56crG6i
	 1QrMf8NA2bsGgBfuoCTi6GZGlaW8tNbEO9vkBD2WkfE0RGY3DbWxT8jj3WUJFzZscJM/8
	 13YUWzFI0/lig4tzI2EXZk7ERUD87xJb25/7dc0msI5YDCHHMypjGtiejx/9+TEQjpXsX
	 VUvPAl+tI+xgZRphP/9f5NMvYKvHQS9CuufXbCvszh/VjeIPNbwlCmTkDJnL85Vw2DA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="ZVKcaQ/T";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6BC34F801F5
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 23:09:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BC34F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZVKcaQ/T
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84F4560A54;
	Tue,  1 Sep 2026 21:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03D81F000E9;
	Tue,  1 Sep 2026 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296959;
	bh=dEICXWx9HguKjDNkrIL8O0KNwtUvoyzlch0tLwhJ4Tw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZVKcaQ/TVObQxAiun6W3mJnajcsLgXXoYs0++wcU6/yNcCBqUJCsYmquKCS7uymU/
	 hATERFjbM06/k7Cy6BQoIG55y+ovQVS+Oxdvh7L8b+K31m3sF935+lALBnu8UqZYgF
	 TL/iEir8zTwU7Ht00wMeTbeRJvciVsohcRyZwSVn0XuRKvAiYO1931BYwo26Li5FFU
	 X3Ystj4Nkfjzp9Rd3gdqclT6QdPsO9rkA3ZOsueZRCFMxqGfB3hz13gtubYNZTB38B
	 C3Q0l2vijB1a5irfZcP9jWbGPP0/oIW+nBZP3w5LukJfYQUK7OfCM20Z0yeha5GLwr
	 13Icgz4ikx+uw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20260901093751.2962786-1-jack.yu@realtek.com>
References: <20260901093751.2962786-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt721-sdca: Adjust latency control to fix
 no-sound issue
Message-Id: <178828052103.33904.17086187569112585943.b4-ty@b4>
Date: Tue, 01 Sep 2026 17:35:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D5hv3wlI2CaoLrVDhvXydRbpllKQ3x0haqalY9UZnVY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqlz77SQPr4VbB6GaHeujFkZUFTT7RkLerJirZS
 53e8XZulEeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCapc++wAKCRAk1otyXVSH
 0KoVB/4sTdmxhd9ISwE4y+L0+0d0dhbKWyjvTavum6/muJSlsnIAXk+38gQXEXNw+3CUkAucacA
 FBmgXpWzPnPFE6MbN5ylrLQeD7FA0u+vrPvqPsUV05kZAaF+otV8sJTLuKx6JOjqL6PQd28CO7N
 DSD88lntid7njqaY/fBb8UPVEvZRjIKff4BMj2jL4uya+lheMFe1SyeolauYOTrUpykappuyARV
 a9yOxOaqgiOU91toIgI8LtdY02vkIQE7kaojwHa11os3IuDyrtxLyfeYiCQVfrpQQ5rHYL8X2CC
 9H2Z8yjFRsfwGA5KfbNeq6s+Re0KMqTZBqrk5puetDb79lyj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: TOBWCGQFL7H3KGSZ3MMKV6IYTZDRWSHT
X-Message-ID-Hash: TOBWCGQFL7H3KGSZ3MMKV6IYTZDRWSHT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TOBWCGQFL7H3KGSZ3MMKV6IYTZDRWSHT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 01 Sep 2026 17:37:51 +0800, jack.yu@realtek.com wrote:
> ASoC: rt721-sdca: Adjust latency control to fix no-sound issue

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: rt721-sdca: Adjust latency control to fix no-sound issue
      https://git.kernel.org/broonie/sound/c/a20afec40ea1

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

