Return-Path: <SRS0=b8gG=EI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0BDC00A89
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:20:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0CA20691
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fc9MgFxn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Epznq/QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0CA20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30AE81737;
	Mon,  2 Nov 2020 18:19:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30AE81737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604337623;
	bh=DK5hG7Hl+usrKzyzofkycl7KuXmXYmJFS7OX+Znve1U=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fc9MgFxngNy/Q8lAgueZHsZEIA67ZDp2p+56kawbJv1apooagSUg3fdjtDcYTEK8V
	 6RL9S9ujxBkYhbzb7iJHtDhxctfAegr3SUOuBzSRwJPhNJ2YklTon57esOWPGKQHdn
	 dfw7gDF4nQEpWFqtPwGy3OW8IxRIW6TVGNM4qUHc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 728A8F804B3;
	Mon,  2 Nov 2020 18:18:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 026B3F80232; Mon,  2 Nov 2020 18:18:26 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68B48F8012B
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 18:18:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68B48F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Epznq/QL"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EE5E821D91;
 Mon,  2 Nov 2020 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604337501;
 bh=DK5hG7Hl+usrKzyzofkycl7KuXmXYmJFS7OX+Znve1U=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Epznq/QLQV+OUXgaAnagCRngDd7sAginMJhmFLejpPgmsHdhDOBZew7NH4j8xiD5n
 wUSjDU4NLAjOlpa3pNUJ5LRN+w6XgX0j1OL+kb8lblgDkYdBrLp6RAeykJH+Z/5dK+
 zOmy1ZpD03Ka5Xc6Br8vzl+M88V0sSzHNV2/2kE4=
Date: Mon, 02 Nov 2020 17:18:13 +0000
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, f.fainelli@gmail.com, sbranden@broadcom.com,
 rjui@broadcom.com, sw0312.kim@samsung.com, ranjani.sridharan@linux.intel.com,
 kuninori.morimoto.gx@renesas.com, perex@perex.cz,
 "trix@redhat.com" <trix@redhat.com>, lgirdwood@gmail.com,
 nsaenzjulienne@suse.de
In-Reply-To: <20201101160037.2295512-1-trix@redhat.com>
References: <20201101160037.2295512-1-trix@redhat.com>
Subject: Re: [PATCH] ASoC: bcm2835-i2s: remove unneeded semicolon
Message-Id: <160433748157.18840.3548192910799118546.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Sun, 1 Nov 2020 08:00:37 -0800, trix@redhat.com wrote:
> A semicolon is not needed after a switch statement.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: bcm2835-i2s: remove unneeded semicolon
      commit: 46713ed258695e2de00ab2738160f89220c0a976

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
