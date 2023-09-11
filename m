Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10321EE7FF4
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Sep 2023 15:09:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E117214E;
	Mon, 11 Sep 2023 17:08:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E117214E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694444977;
	bh=wnj4qD36tPFKmzcZsVVwem6YXErpIqxR5n+uACnZbTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vAH9CwlWKBIBdJbZYI0P5r6CivzRHwl5H/OZPp3vmyr9VUKWkagK1Bnj0dINyMUqF
	 rPWQrGhlAcHiA2ybRh2lKHo+90f0AcIvNrpDFgQuR/fo9OIquIbRo0BobimSyG4EAR
	 CtnYqPGL8GGxt0AO50auXN8ZyK5hTmdRFMDdZ9sI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6FA3F80571; Mon, 11 Sep 2023 17:07:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 26891F8055B;
	Mon, 11 Sep 2023 17:07:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79062F80431; Mon, 11 Sep 2023 17:07:54 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4D6EEF801F5
	for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2023 17:07:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D6EEF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=i+i1kM9d
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id EFEF2CE1745;
	Mon, 11 Sep 2023 15:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3323C433C9;
	Mon, 11 Sep 2023 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694444860;
	bh=wnj4qD36tPFKmzcZsVVwem6YXErpIqxR5n+uACnZbTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i+i1kM9dzB7Id4yjsy2uaOvRdXh4+CRr6jibwaiL3Uru8TrIDksjYevGRUOBhDunb
	 o76Pl7Da7sE9VFkyMxgr9KIC67X2L/3+Qre0cQ46RxlKmSMUanCFLEpu7V+6e86oR4
	 nTcqtuvWLbXtOuCDkWsl3QkMOtU/G+KWXkz05zzcZjx32Bnar2jfLqA6D5avzfCPUI
	 mIJKLDdcrOv7EqJSrtNyZfwZrcdHGwLF4s6gi8WVW0FOQNQDxY0qLnAI3mp9movbyl
	 mrUlCxNW76wCaPBiMIBDNsys7qwQSxUkZCRXnY4ee8N69MWxA/ijrvu4WhZmZCk55+
	 KThjh3Otumucg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com
In-Reply-To: <20230823092113.788514-1-ckeepax@opensource.cirrus.com>
References: <20230823092113.788514-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Shrink stack frame for
 __soc_pcm_hw_params
Message-Id: <169444485840.1851820.15755094643403493354.b4-ty@kernel.org>
Date: Mon, 11 Sep 2023 16:07:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: ESXFAYXKLN6JBYGLSKAJVBHVLELFCP3E
X-Message-ID-Hash: ESXFAYXKLN6JBYGLSKAJVBHVLELFCP3E
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ESXFAYXKLN6JBYGLSKAJVBHVLELFCP3E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 23 Aug 2023 10:21:13 +0100, Charles Keepax wrote:
> Commit ac950278b087 ("ASoC: add N cpus to M codecs dai link support")
> added an additional local params in __soc_pmc_hw_params, for the
> CPU side of the DAI. The snd_pcm_hw_params struct is pretty large (604
> bytes) and keeping two local copies of it makes the stack frame for
> __soc_pcm_hw_params really large. As the two copies are only used
> sequentially combine these into a single local variable to shrink the
> stack frame.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-pcm: Shrink stack frame for __soc_pcm_hw_params
      commit: 396b907919e028d89bac912e49de014485deb8dc

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

