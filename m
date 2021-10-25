Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33460C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:44:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51C960555
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A51C960555
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19F5416D5;
	Mon, 25 Oct 2021 18:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19F5416D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635180239;
	bh=K0Kpvc0OulldRog10BpW9uV+5Ap0vvFVLeAAOvO4H6Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rwAlwpKnh6nWYpbyLf5GMc5LqvIMDplJzepI+U4j7Vkt/wUqx7VAOMeb4sosIkDbh
	 tJ35bdpoeUej1Ebbuc14RiULQw55IiXgeOdw7N+UE4Ywe9Xr8aLWqAREnNTN0vhtjE
	 I6nVnhG0uj/XF+1Jk05Xxj+susXc1b0y8mtMVJ/c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D97AF80520;
	Mon, 25 Oct 2021 18:40:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 170ACF8051D; Mon, 25 Oct 2021 18:40:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BBB9F8051A
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 18:40:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BBB9F8051A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="W3RmhSzV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E596B60F6F;
 Mon, 25 Oct 2021 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635179999;
 bh=K0Kpvc0OulldRog10BpW9uV+5Ap0vvFVLeAAOvO4H6Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W3RmhSzVFfh5RJ/cuqvdXTgiBWwrdIADre33R0XA8lX/bYr+rTg2+uE04KMImeqTC
 oK2stpXwEsKB+egrAbxoTI4AoIUlCF/+nhMg20Z4eyryPT8Uf3bOLUpyKLEhoimC5/
 bRbTG3oYIOzbrAjFFvO4CAOZn1J85p0IKWKaLw9nakpAQprfWr0JYltrdn51k+/rnM
 tGSa/1kN/Wt/qqFJwzr/VjZ1DLGaf66v5AhszxT2oYgJ1ZFFJfpN5CejS67BN+hEzi
 d9p+wsT0CUjgOyWms1JexN4NmnBYhH8bFmLOn+FlgpIw4ZxAhAFK1XTaQEioX1xVVc
 7r5dlw/rWjv3Q==
From: Mark Brown <broonie@kernel.org>
To: John Keeping <john@metanate.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: doc: update codec example code
Date: Mon, 25 Oct 2021 17:39:29 +0100
Message-Id: <163517996155.3558038.10361487855050489332.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211024151731.360638-1-john@metanate.com>
References: <20211024151731.360638-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
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

On Sun, 24 Oct 2021 16:17:31 +0100, John Keeping wrote:
> As the codec API has evolved the documentation has not kept up and still
> uses old fields that have been removed.  Update the examples to
> represent the current API.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: doc: update codec example code
      commit: a6d968a3e8f01bdc09fc397697ce27ef75392ce7

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
