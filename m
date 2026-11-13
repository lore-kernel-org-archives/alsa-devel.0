Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F4606B20A
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=EgSb7eGU;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PkM16QOu
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9691260204;
	Fri, 13 Nov 2026 19:01:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9691260204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794592878;
	bh=42qJZ2zd1/OG95s/m3tsoY0R2LgbY3r0DTBCQNhCNzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EgSb7eGU4Hhsvxo7SobMR/KQW19dj0WSw2EOrmR3Q9qI1l5swtEtOi1mYUmWOcPWg
	 FiFjf+NqA2/iHNiESQqxXKiSuXnXt01IT/4WbAsX3sz7cLhV2Pp1liO+ywZl7aMqqG
	 qOC/Oir+CEOPqnYuz1BzSPTHqvgRdCZr4iVNaB2w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4EE2BF805FA; Fri, 13 Nov 2026 19:00:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7896EF805BD;
	Fri, 13 Nov 2026 19:00:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73690F80552; Fri, 13 Nov 2026 19:00:38 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794592837;
	b=LBA/0474SRVjHeH0EBsovWK6mttYKLJjaDbKxYIbP+P8EI08kjVGKsUfecORj5g/sWvm
	 G+Q9AFUXZz9f3Trf7Dei6zztQzeIswXml0j8xdGBDND/zXSLq2peTDF5WsKnfZBDBIanY
	 CVvBWeIWElUNcrFuSiXKyjpPhmplK9PkSNoTx0zj6Fs34XBQj5GlTpaWXceBXPaEyYNo8
	 wlc3XdyKcvPiruiAHbVHWll+AEHEyJL/IxP6g6RfJ2BNMFiMcV7r1s1ZrL4LegHLWmE2A
	 CQaw0ZYfgAIHQ1jraJ9taSqxhYp3wePqCX6591UzbIrfJbVvCpSMxT135m0UIH1qJEA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794592837;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=42qJZ2zd1/OG95s/m3tsoY0R2LgbY3r0DTBCQNhCNzQ=;
	b=J90OVN6a+OiV8sWmCgi4Mazf8A6Ibi+tT0QKm63Kkx7YcPMTbhTFhyY/NJbulibjXDgi
	 pFnCoyeJ1/svgS8D7JOKN4H2u1KqgLzjlmcVPS6pY4n2HjebmdTzFI2junuuLToFwsR+X
	 aAh1TtxfQUFmsAzqzGwHwC9BU+WidPWSXg+fBz2NPRVbkoy6cmXt5mITWjajHRZQA/i8E
	 ZaC5HF3MzFgRZJWjZZUWZ+Jd1PyGgtBFlNOnnvrBvHzZeH41xcctS8RljvX37iXPsII4P
	 6BL5Owm30EaVAtEOyWMjppIWRKQHK9HT4paU1r9zHV01NLifoq3HEcLZT6sxscjncYg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PkM16QOu;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 494D5F8012B
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2026 19:00:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 494D5F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PkM16QOu
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C8FFB45B46;
	Fri, 13 Nov 2026 18:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091DB1F0089E;
	Fri, 13 Nov 2026 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592832;
	bh=9FGtgapqf+t9EUsMhhF0AQk1EeXyjV2Us13KHEtxoOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PkM16QOucH8gQY81GJ+cVa3AYvJGLSFc5I7y/3vq+iWIIR7g9P4Vc3LX80cTEYEhv
	 uYofe+IMGzlCkxzO1X4ceXRsFtdpNhdEHg/UffLXi0aZvSWpLIhLkE4uSKHF1C0aUA
	 d3EOHgNUwE0VAPqn6iayQyWTFo7CW/cGWD73y00O2ovdTvAT+CcOGI+8HQXv57czG1
	 RKdH7mG92hjsxKK2AMEAEW2kfqmXRT8lLvKG2yN86MJmzAKAr8GRnGkZGz2TbGaZm2
	 hdEQ/MD712cYOaiwAdmLTu8cvo0jH1MMbJ0lvqHrSrdoGqitwl2T+Kpp3skl4Wh9Jn
	 xJMumkP4q4zOA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: Vijendar.Mukunda@amd.com, anson.tsao@amd.com,
 Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, Guo Ren <guoren@kernel.org>,
 "open list:C-SKY ARCHITECTURE:Keyword:csky" <linux-csky@vger.kernel.org>
In-Reply-To: <20261112123603.2891858-1-syed.sabakareem@amd.com>
References: <20261112123603.2891858-1-syed.sabakareem@amd.com>
Subject: Re: [PATCH v4 0/6] ASoC: amd: acp: ACP7.F SoundWire configs and
 SOF function topology support
Message-Id: <179458523228.68977.1942336202187968930.b4-ty@b4>
Date: Fri, 13 Nov 2026 15:53:52 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; i=broonie@kernel.org;
 h=from:subject:message-id; bh=42qJZ2zd1/OG95s/m3tsoY0R2LgbY3r0DTBCQNhCNzQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+B9iuPftPxMXO9HOk9YuujsyjW6bm7f5dwPpq0/M2/
 72TLIzDOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRhe8YGfpdBU6pLdU4/3lp
 xFGrd/0fasUjVG6fnXRLLmPB8s/rH9xn+M3mXJMUlsB9t+f9LukFK9QkVhy2srJSPqH35V608qv
 iSB4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: MXJZ7O42PJXWYEIA7HT66S3KTF3FF4QU
X-Message-ID-Hash: MXJZ7O42PJXWYEIA7HT66S3KTF3FF4QU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MXJZ7O42PJXWYEIA7HT66S3KTF3FF4QU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Thu, 12 Nov 2026 18:05:35 +0530, Syed Saba Kareem wrote:
> ASoC: amd: acp: ACP7.F SoundWire configs and SOF function topology support
> 
> From: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> 
> This series adds the Cirrus SoundWire machine configurations for ACP7.F
> and reworks the SOF function-topology handling so it can be shared
> between the Intel and AMD ACP drivers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/6] ASoC: amd: acp: add Cirrus SoundWire configs for ACP7.F
      https://git.kernel.org/broonie/sound/c/0fad8a0a8aec
[2/6] ASoC: amd: acp: add SoundWire speaker quirks for Dell platforms
      https://git.kernel.org/broonie/sound/c/72b048630d14
[3/6] ASoC: soc-acpi: move common SOF topology helpers
      https://git.kernel.org/broonie/sound/c/e23ffd79d900
[4/6] ASoC: amd: acp: add SOF function topology support
      https://git.kernel.org/broonie/sound/c/50bb13ee80fb
[5/6] ASoC: amd: acp: always append the DAI type to SoundWire DAI link names
      https://git.kernel.org/broonie/sound/c/e8e52a9a8257
[6/6] ASoC: amd: acp: enable function topologies for ACP7.B and ACP7.F SoundWire
      https://git.kernel.org/broonie/sound/c/2732ae983737

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

