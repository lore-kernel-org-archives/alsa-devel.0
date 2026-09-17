Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301FCC982D0
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:15:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57AA660205;
	Fri, 18 Sep 2026 00:15:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57AA660205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789683334;
	bh=ba+kuQU3AOx1eiVpm1PJ9aqoQNnMVSYLGwIvL9wLSE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LoIIEq+YB0X1G8HEKsOCFbjMxq3YnD6hIfiLwrjoupMv33jjxHeSOfuXmcDKJNMqV
	 NmSijWBVgft9HpN4NCxy8xVIR3GugHQSUn6r6GmHV7uxJn9OSoClkoIA+Ua3qQ4Vuj
	 CMJveLaX1CHqgYntDcn/Ey3B6M406KSht/Np9bVs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11CF7F80600; Fri, 18 Sep 2026 00:15:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E0C1F80602;
	Fri, 18 Sep 2026 00:15:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8080F80518; Fri, 18 Sep 2026 00:14:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789683292;
	b=Xc++HYvvmg5Nm6OFTF1T1pCK5DCOsYNGFsbT9SDyhqzCpOw9LK6OpBOYQuQCKO14owKb
	 ERdZTXvnqac/o5C6ZqVg2OixU/7XFceu/rjRSztfw+8Upmw6/5it1shZ+H5sPA1qrh6RW
	 sZsUSPzVJZyJ18iuuNRl71mOeW8D4G1Hf+Wl5j3S3lS0+FLdc1ierzonruf1fMAqyJaFI
	 zWkiRPkNEor2trQ3QXfJLp9G9agtTo5AXymQDM0v+lwZ5aLlw+vnEjZrs6NhDc90ntGqx
	 FYLAtZbm2TuuzfQu+b+JiLVPN5TQeTG5GhbndKQBOpNJbyzl+cXS3tRFqfYzFLX9Y+Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789683292;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=ba+kuQU3AOx1eiVpm1PJ9aqoQNnMVSYLGwIvL9wLSE4=;
	b=eS5Ci4Lri8ndsFlBUcuuacYTN5Za17qXRrZzivvZQ7yMUs8amP9S7VV0Nqa+7eyYsM7K
	 IeH0HHMYGfupr83Va7N67T5z/UZ4du3M2DUcdKzNwH7kYbiO6DhbVyqU2Qqss0Bey1zhk
	 DjCOAph1YUwR0EMdbr2FzWKfmIp1on2VFDN32TKp18Yf+bPHwIT9EGXfSzfBKQzPGSvEB
	 jXjDCdD/xBwYIQybmVxEcS+WHp2YKE3orkGraWmdahZq31RhqK6L/fJTWwO79p869h9bV
	 Uj/tXIErZMBQs8FwmZehOkKgEKRoZ3W97IQSeE7YLiJ/RixEGB4znjIDUJ8I1r6l70Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BHRkZSoJ;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3E37EF8025A
	for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2026 00:14:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E37EF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BHRkZSoJ
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 94FA0600AA;
	Thu, 17 Sep 2026 22:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8377C1F000FF;
	Thu, 17 Sep 2026 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683288;
	bh=MSp2ypqXXj3D7zZ2GgnhtARAVUTIikCeJUnEzXegoFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BHRkZSoJ9r0oPC4v1xqtuLNKaStzYj5J8GAlv7gBZDLz9aeFsnteqEM6Nnk8KXDas
	 /ZInH1/V8WVqRm2/RaelELdlhk7j8fqHcnPfUH6P0IIJfswMSOEIcQAcI5f8WXboEb
	 9S3Z0LTgHTn+KEZDxUOR6Q6kSQzpLtEiyd06BIJK68ehW2WPAGEPlGEmrG3RycbCgk
	 IlQnVkoAMbYwB/iJtKOH9QIQNx5iDKezfosO4nnghQjBOKde3SzfmuLxi2MkD4se58
	 UH66w4FEfvII2E/ES5Rl9vOIpYB7RfhP+C46N0ScZieERHZfxavgO/B20ou0Tn0StV
	 E/NNEw8Dnmggw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar.Mukunda@amd.com, Seiji Adachi <seiji_adachi@yahoo.co.jp>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20260917131851.2122144-1-seiji_adachi@yahoo.co.jp>
References: <20260917131851.2122144-1-seiji_adachi@yahoo.co.jp>
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to
 quirks
Message-Id: <178967298267.285745.10034745820609778188.b4-ty@b4>
Date: Thu, 17 Sep 2026 20:23:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ba+kuQU3AOx1eiVpm1PJ9aqoQNnMVSYLGwIvL9wLSE4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrGZU9FLCSv3PZFeThCgPTCPN0hjo7XHdQ7WEf
 sjE2y64jIGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqxmVAAKCRAk1otyXVSH
 0BlnB/9hFb5tjRMTkzIs0ymxaueaJxwC5KP+GHC04nhJtciIJVXu3jat52HPHUmWCSQfTfwN0v9
 8lhGAiKDAm5KHH/YI7X1eV3o7HalxSb8boOjWkDxH+rUpiAygEV3ui8drVUqvtDX11W4kTAO9Hl
 skat1iYLoR45Rs5poWHwPLYxscv//8akfZdWz+j/cjeJc+bYO51n5m2ZsGwvY9xryGy4/zZWmsi
 vVP3ovYErQhzccnchCE9vXUzZ2PJCzqZND/1DJFnw8XL/+qIlhrCANXbedtTl1Z/a1CrFbkKdI4
 6TBKc/AkEc2XyYZbjxWuP6lNZYbjcy82L/Q3STII+A6aGFcV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: OEDB3KVFPQTVS7CRFOEYLGE3QDYM3AJ6
X-Message-ID-Hash: OEDB3KVFPQTVS7CRFOEYLGE3QDYM3AJ6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OEDB3KVFPQTVS7CRFOEYLGE3QDYM3AJ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 17 Sep 2026 22:18:51 +0900, Seiji Adachi wrote:
> ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks
      https://git.kernel.org/broonie/sound/c/4cae4ca34992

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

