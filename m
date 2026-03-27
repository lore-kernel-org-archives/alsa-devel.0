Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A611410F2867
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:41:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6A8D601F0;
	Fri, 27 Mar 2026 21:41:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6A8D601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774644097;
	bh=20FKg2jN5AOEKZDjLShJANH9cTTEOSbofFssfjZdmio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nQdnu8ptCfuQAp57CC2T+GNubyl1O7cHlhGcxtYzBrGA13sAjnhS+kpjh1gpOLd1G
	 o47lBHgMUS9GiTrlOTrqV9IVOlTLTRAp9UDggHMzcuUogbFlQLfTiuMpWHhCURAEOW
	 W62oZrHDUoMG8iVTLiEsETlr1Zn5XsSSsbdIH+UU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90604F805E9; Fri, 27 Mar 2026 21:41:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 208FFF805E9;
	Fri, 27 Mar 2026 21:41:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A947F804F3; Fri, 27 Mar 2026 21:40:55 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EEAA9F8025A
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 21:40:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEAA9F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DATdsHbN
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AB89C43759;
	Fri, 27 Mar 2026 20:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E37C19423;
	Fri, 27 Mar 2026 20:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774644048;
	bh=20FKg2jN5AOEKZDjLShJANH9cTTEOSbofFssfjZdmio=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DATdsHbN+gs0R98kZIYEaN1sLOH+l+KcK6Whsu/6Gy00N1Dg3ZxkPMWvOkkCJ00+y
	 5bGUxmdXdCSSNg557VvZkgrTWaGRrGs9cHNASFNTEs+9g6e9EHehziWEe1bfvHjgZK
	 0azXtr3P/cnmqSiGq4RWIaoWV5XkhRkknQ7aPA/fmDVWLzABKN+ibEglgoe51XS/8r
	 bLnQzkTEsepLi8qAUTsqCC0XS8I5hC0mvf1ZDz26XPXVLases9gDfO0V1jbHV47lLZ
	 AYDAlu/wzx+GjE26tnfu34CBO6AB/8eqkuJ9LabIiVHlzo/8gA1h430l/RieVLbaBR
	 GEw+ipqx46cQQ==
From: Mark Brown <broonie@kernel.org>
To: Sachin Mokashi <sachin.mokashi@intel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 tiwai@suse.com, pierre-louis.bossart@linux.dev
In-Reply-To: <20260324163400.1276247-1-sachin.mokashi@intel.com>
References: <20260324163400.1276247-1-sachin.mokashi@intel.com>
Subject: Re: [PATCH] ASoC: Intel: ehl_rt5660: remove unused macro
 definitions
Message-Id: <177463884254.777262.10318442447476766465.b4-ty@b4>
Date: Fri, 27 Mar 2026 19:14:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=broonie@kernel.org;
 h=from:subject:message-id; bh=20FKg2jN5AOEKZDjLShJANH9cTTEOSbofFssfjZdmio=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpxutOVn+k1MLTReJTcijj3282dhCIQj7VWqUQV
 OMCgLFEpa6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacbrTgAKCRAk1otyXVSH
 0MzOB/9VxpAnWkgR1umkP29REQABPYZvge/15LwISZvRDut4uDcxqTqSgx/+gsjt2qTQKOcFnDC
 H3+3o6VZlbZo4E1in6JKEbargBUaDsINIOfrk8sEqv5bs3b21dQSfUPw1HyyUzrig7JJMoeUy0p
 S2gCv58Q8/fRgy2MZ8HFYaqiKHDwALnXonGMQqLcTeVPNcbhceea5OUYdHs/qpU8oSab5mDHG3h
 PdyCjwvCdSjoD9hAYOlrW+cANfG+get49W/kjACaEqtjSnHRAAWRvuQhuq8nkCeU4B0nLfRdCoP
 Ruy5aXXGcE5Jycf/jb8IvZN+RxWVdiCLLI/JnRD5+cbSbgf3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: UHVCWY64U6SM5B6EFE2P6SXBVLHKEPLS
X-Message-ID-Hash: UHVCWY64U6SM5B6EFE2P6SXBVLHKEPLS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UHVCWY64U6SM5B6EFE2P6SXBVLHKEPLS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 24 Mar 2026 12:34:00 -0400, Sachin Mokashi wrote:
> ASoC: Intel: ehl_rt5660: remove unused macro definitions

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] ASoC: Intel: ehl_rt5660: remove unused macro definitions
      https://git.kernel.org/broonie/sound/c/ebbe5d957efa

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

