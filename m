Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32096CD8CB2
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 23:07:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94533601C9;
	Wed, 10 Jun 2026 01:06:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94533601C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781046423;
	bh=JgEeY7eB+za5CqBF1RW90q81nKBWj8SL2L9Mv9jKbrE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EXne+gydk8e3NVIuNQv+4NN1qfhDGj7rA6t4rgBQlr7y2Mz9wkuQaYTAwRxjwphzg
	 xqpqG2HZVt0XP+Arj+YuKPoKk/DhVg/2I5d00lqm3SFLugSvQo8N677Y8MPLNf1uyf
	 vKE5JjHzARohj2LFvL9aD4h9iXaoalPdDrtby1mI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C8453F80624; Wed, 10 Jun 2026 01:06:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 805DFF80624;
	Wed, 10 Jun 2026 01:06:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 10F1DF805F3; Wed, 10 Jun 2026 01:06:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781046379;
	b=j8vWAuQ8pYhbeaH+fJEDcGrIPtGQLhZBp5X9JtsPtg0P18iSq8sXiVRXYZrcOthoFnrt
	 K6eGiT+i+8/KMAwQFUycdr1JF7Gzgm+9vCzdn/QsC3s8bi1dryOtSpgfhMeZe/FfKnhbl
	 bawp4YR5R9uVC1Sk0kmGm25u95iBJFv6wQTcx3x2m/DWugDKiP3QfrgcA+b3pHf2+t9oi
	 DzlUah7CakCerzcILoFYI+puuL1BsQrmouTzK8XjMxGLtW0zmA+YLhx5SQVh2HQWA1ExG
	 pS0w0Q3wLk6tUUWblrPkse4AC8hgWY5app2z2TRXWuKSbVTArYxOI5C5V2ZyuhgcL1w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781046379;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=JgEeY7eB+za5CqBF1RW90q81nKBWj8SL2L9Mv9jKbrE=;
	b=Jq079c6GcaM0+8WMwIXp2FYnmRuAGV8uYXj7o6Um8+9cHY24/hSo+eKLW8+aSxPHYeHa
	 K6mGiD5GFjON6PxvSJfausdta/2EKVeaxzj2i0yBkAmhXz2WmvrjzWas4HwaajRWI4070
	 1cjzvGgfj4dN6KBO7xbEcccuxJokSKa2vgqYBQof+P7XuYUwEgL+KPGk03x5B3JaAsHT4
	 wgdZY/FhsMhZUgV6LbWElpeqEEyXYRjZ5ULTHyyeJzmt0OaRxPGVo+dipwZjHQP0QaUs2
	 0YKFbtzwqjmPkB4t6oCPO3Q4alK11+FtPlTV6NLI7SRstXkLkj5QXbQZCADWgWu0qgA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Q+Sflg4G;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 75B96F80623;
	Wed, 10 Jun 2026 01:06:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75B96F80623
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Q+Sflg4G
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3D9FD4030F;
	Tue,  9 Jun 2026 23:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC511F00898;
	Tue,  9 Jun 2026 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046374;
	bh=8pDXuObPF5gw4XW/4lBOLwp4F53GOe6GUabH0eYzzb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q+Sflg4GCrY+7baCctMMxwNdeyLNu8lm69Q/1po0FI39Z3okx6jnjKuKoKOrlozF7
	 vCL9wbOOByaoYn0JdplctiuiPzeD0HumS138ETj2Si37YQ/OdtDzYl2X8hILGEUnMa
	 eigqKRU3152Z8NnjjazxB7vh45dRAI54q/wP3YUFKbHtBizApmqBS1PlSikB2r5OD1
	 4+RRlsYl0iUjsF/rQfX5g01Typ0SU114h54fCN7Qe7p5a2ovPFZjhAaOD47UiiyeIH
	 cTL5tGeYiywe8CGeigiFGV7hkPe5a/KPuQVA6vemi+a4zEHC9SZWgOatwPaw4ik8ME
	 eGGXFkL0UNEWw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 perex@perex.cz, tiwai@suse.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Basavaraj.Hiregoudar@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
In-Reply-To: <20260609144146.3311301-1-Vijendar.Mukunda@amd.com>
References: <20260609144146.3311301-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: honor machine_check in SoundWire
 machine select
Message-Id: <178102720923.34323.10871612282287356569.b4-ty@b4>
Date: Tue, 09 Jun 2026 18:46:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JgEeY7eB+za5CqBF1RW90q81nKBWj8SL2L9Mv9jKbrE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKJxg5zFG+6P7IB/4vT8X+FMUEttZz6DrQOzy7
 mIfWZYeVRGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiicYAAKCRAk1otyXVSH
 0A+JB/0XpEMlIpNLDsdCIcFtBWHfn6P58WI/mSgrki8V4oxdSrMVrM3/f+VRflMn9DQx+/wi9sh
 hHmfYIA/Dfk0RB2iVA/CBEjgux1lA3x1raybrq0LDhsMNdMb4JtrVm9/Oi2pg6TwZkyhJwHlEbU
 nusnaJhoin5ZG4i9oyowXnyOhI3ledtJyxoWyKJDZ/TlgBETMQrTrC1roWNEyBDZEPBCZnQCMUK
 y7wUxxUjWGopDOZcNX07AOscz1f7+ToVVWWT8wy/UvLbjWIfyWBklgOd/pLzBU02JqCdNYBZNVf
 G7QXk5wZ8Q5ex0oaaTDY4dVPA1o/AspEd21dDAozyavZtsB6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: T6AYYXAEVN4J43CTI5MGHB5XDYA26ZMW
X-Message-ID-Hash: T6AYYXAEVN4J43CTI5MGHB5XDYA26ZMW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T6AYYXAEVN4J43CTI5MGHB5XDYA26ZMW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 09 Jun 2026 20:10:00 +0530, Vijendar Mukunda wrote:
> ASoC: SOF: amd: honor machine_check in SoundWire machine select

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: SOF: amd: honor machine_check in SoundWire machine select
      https://git.kernel.org/broonie/sound/c/ff457653ee38

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

