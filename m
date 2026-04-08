Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF64710F995C
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:07:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48BD66021A;
	Wed,  8 Apr 2026 20:07:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48BD66021A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775671630;
	bh=D+1aJhA1fbMDBRhRQFskpkRYvACysKc5lAtrmzctoXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=poLe79BkxG3ElIBYhpWNIxou7Xp/s3gGF3/avmidXM8DbE04OEuCJdKwoGvk6r+8e
	 OygS5V3OxanZgsH0h9HqChwyn3rzr0gpZr87Q/UMuPzgrj4MsirknSWESv1c0LtB3h
	 dQ2Nq+3kmT1dSbQC5qHHt6QdmNCQnfzKpbyMmnUA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11D4CF8063C; Wed,  8 Apr 2026 20:06:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C2AE9F80638;
	Wed,  8 Apr 2026 20:06:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3911DF805F7; Wed,  8 Apr 2026 20:06:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8A81EF805F0
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 20:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A81EF805F0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mMksU3l9
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4419040681;
	Wed,  8 Apr 2026 18:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE670C19421;
	Wed,  8 Apr 2026 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671562;
	bh=D+1aJhA1fbMDBRhRQFskpkRYvACysKc5lAtrmzctoXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mMksU3l9e2mfJEoUoqkPe9ANad0g/XLDqiCks0aajWsg4gxtiPVNnjHaAHhlwPYBJ
	 Vnj4jJA9B0KwoSNUG4DzEoOFbFRf65NVm5Zodq0mJwdJg1ik++sCDhndcN8XZH8DCD
	 +cePY84HgcHQA+LqQw41E457Z7BvCWSBhNNZMDIdt8dAR9MYNNT0RMf3FQhK3e8KaZ
	 WUxswVlzqg3YGRTEEAckEBYLU7kBnrTeoks6s4vcEGURhhkG5YNx7ym/bOU8bYIaQH
	 eCtN5xJ0u2tx4u0al+tUm0j+1br7vZuQxnT+WjhK/PHuM7dBki0YiGy/wrpn+YZpWP
	 pQNEDatt1IAEQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Tomasz Merta <tommerta@gmail.com>
Cc: olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Tomasz Merta <tomasz.merta@arrow.com>
In-Reply-To: <20260408084056.20588-1-tommerta@gmail.com>
References: <20260408084056.20588-1-tommerta@gmail.com>
Subject: Re: [PATCH] Subject: ASoC stm32_sai: fix incorrect BCLK polarity
 for DSP_A/B, LEFT_J
Message-Id: <177565110420.101848.2541520016618788420.b4-ty@b4>
Date: Wed, 08 Apr 2026 13:25:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D+1aJhA1fbMDBRhRQFskpkRYvACysKc5lAtrmzctoXo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp1pkGAgVDFHAEDSi6lBJRIOX68cVzVmjV+y1BI
 7gKoAgxfjCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadaZBgAKCRAk1otyXVSH
 0FjNB/45tntugNDNxCdID/5Lz5G2h8qJZdC0ODK5KmNYDnpHdFrxciiDud5HgoOP7IvECFJfbUW
 +31PfjaS17mDZWFaimJkEDxXV6Fa0Bw6XwY8VTJXKidpKjr68sUjNGEBJ29Unzrt22ZkRA4zzDk
 QnJIQWJpWmRCVbse7RMkQg3hLac/7H3DS/VUDp7ALXkTPVewWoqmGEpGG+ZHLR6/nUZASIQNBxA
 AdlrVbKikbiKjQSYeCVBT+UCf1g/LJTHiHtHqATapHlu2xZ3Uqr75MVyb5lm706hDTvrnqnEyC5
 Tfye2VruGcHRlnvHeAHjaBtrWoDNhmAed3ImAMpChI2Tp+8k
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: Q3P6UVKWOZ3A4DDR77U5PAVSWH27DEQK
X-Message-ID-Hash: Q3P6UVKWOZ3A4DDR77U5PAVSWH27DEQK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q3P6UVKWOZ3A4DDR77U5PAVSWH27DEQK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 08 Apr 2026 10:40:56 +0200, Tomasz Merta wrote:
> Subject: ASoC stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.0

Thanks!

[1/1] Subject: ASoC stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J
      https://git.kernel.org/broonie/sound/c/0669631dbccd

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

