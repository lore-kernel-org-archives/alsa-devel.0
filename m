Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCBE606A326
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=B17OJc6x;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFEMRo0x
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60A4E601DB;
	Wed,  4 Nov 2026 11:44:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60A4E601DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793789095;
	bh=jew7XJSxJQqaOtdnSxrm64K2PlOc89ZbTn38/2rmJaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=B17OJc6x6UdNAv2wSxdYpLZKo83vz8UmJkZv8E5v1IxWnp0m9i6hErWPcmhK+OvUS
	 70d+PACFYGOvgU3g8V8PEQbevSOwC6Zxesk817c1T0DCOKYj1E8qHa9blH6vubgj2J
	 4tt4gKclKFOr3at2242N3+/drl8aLtUTCHh7ddmE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3A39F8061E; Wed,  4 Nov 2026 11:44:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FA93F80615;
	Wed,  4 Nov 2026 11:44:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF6DFF805AA; Wed,  4 Nov 2026 11:43:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793789034;
	b=InOu7/+Fj5BIseRLOtOWBgw7850mZjedfhWY1TY0pU00YPO7Ygx63rvVrjiRFFtfq2Du
	 gSBwaQW/y+0YUj+XtQckmAl73KX1hNB7roAS5ZDEYnhniO7GZirywVTWrm9gSP3uzQ64j
	 lujbYMdB+ARtoeotczJ2xWjBndP6OpD1LRYipTGVHyMqg1KiKl8QeiMR+4FEBEKSPEXmn
	 yBIROw54iJRez18gQrur2V4nu4eIMAAa+/8a8FsQ3GZ+rwNItf/o+/xAq9Y2kCrTPuHu3
	 Xn85NbU3komSW+gytJ7NA++IJ3auroEqXrswD6QN7wzlDwL9AL4qJ1wga9XSiobTUJg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793789034;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=jew7XJSxJQqaOtdnSxrm64K2PlOc89ZbTn38/2rmJaE=;
	b=ZYlktsDhYRXCSM3NyqXkwEytZINOwTuDhyb2X27oqwEwDb2GNoe7oeJBHiM9ypimlmTm
	 wrS0eo34jIEF+LR0EdbzZMsbyNyvQOetSSuPSqLZSmIy9Sx7R3NqkS+w6yA8tlmr/gibO
	 uLeYq0cf80ZLbxoYcai2oiOmzB1RH+q81gVPAAbW9l2fZ45lZTjzJ5L4emqp3gyTimv0c
	 AnQrla4xXqDoAPSW81hQMitbj4JPeg2PRQsSfDIGSKlVBRhKSm0vZo9JZ6QLlVq50N+Ez
	 qlFl9kGd1PK6wk4tzy5O+3QZigPZgNAMJfesjXuRgoYR+Zl0FygZnqgdLBjPJXgUU2A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QFEMRo0x;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 05507F8055B
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 11:43:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05507F8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QFEMRo0x
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D3F8A40DBA;
	Wed,  4 Nov 2026 10:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF51F0093A;
	Wed,  4 Nov 2026 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793789029;
	bh=jtFW2Z4D9v5PYabAjWKZegOLBC5+FNygrH0PfJg3j60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QFEMRo0xnAFMramP6LxxKIiB5tXaZC725HQJrjfJW6fZaEMOMjJIkEHh403aehpeY
	 2Wi7B2UxnNvdYFkwD3LXavGLriprQN8KGFLEnbi1f2fcfxHBYM9pG2vCP5+6GzuqfG
	 Il2L7jorCniHC4Oq7bDItozmTBnh0ruDfW47KTvExGH4nbn89J8EUSpG39H1kG5vy+
	 YyYnP6UUYWpzuN3C4JNEq7wgbFAv6vbKFFg1F6TLu288I+mXWZ+y3LCae2kAjp2sNW
	 sgQazdNQI5gVgaLvVJ7EC1m+Rq+jtTrUqldhGGDojg14Dg5eTXwApUgRSEHnGmbEkZ
	 jJ+tMkKrG4MWQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 7C17125D8BDF;
	Wed, 04 Nov 2026 10:43:47 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org,
 Qianghua Wang <qianghua.wang@senarytech.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 alsa-devel@alsa-project.org
In-Reply-To: <20261103064123.115057-1-qianghua.wang@senarytech.com>
References: <20261103064123.115057-1-qianghua.wang@senarytech.com>
Subject: Re: [PATCH] ASoC: Intel: soc-acpi: use dummy topology for SN624x
Message-Id: <179372792116.2270148.12182339528895629863.b4-ty@b4>
Date: Tue, 03 Nov 2026 17:45:21 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jew7XJSxJQqaOtdnSxrm64K2PlOc89ZbTn38/2rmJaE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJe8yTvC9E0q76cYxd9278tzJ7/re/Ght01HXJm+202K
 /FprNbsKGVhEONikBVTZInL4n5ZX/J6Dd/BhW0wc1iZQIYwcHEKwETeZDD8FTKWZ199R+1fo58F
 V4LG9R4x+zN/pnE+1plX3Xl7UaPuc4b/jj90b5b1RtSc3CD3rLvnLFNO84LDuj771YLEJL9ejpX
 iBAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: EFQF2EEKMHT64JH5F5OS4TGZDC2FRELM
X-Message-ID-Hash: EFQF2EEKMHT64JH5F5OS4TGZDC2FRELM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EFQF2EEKMHT64JH5F5OS4TGZDC2FRELM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, 03 Nov 2026 14:41:22 +0800, Qianghua Wang wrote:
> ASoC: Intel: soc-acpi: use dummy topology for SN624x

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: Intel: soc-acpi: use dummy topology for SN624x
      https://git.kernel.org/broonie/sound/c/97d5fbab9e62

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

