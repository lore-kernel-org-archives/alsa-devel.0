Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0490C6FA8B
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 23:11:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F63D84D;
	Tue, 20 Sep 2022 01:10:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F63D84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663629081;
	bh=pQAafg01ffLkLSnjXIOUXsCOiRe48tHjwt1h0N8nmLk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/CUu2o+4qXllDCwtULUmXDCqKxZxCYIedw7Eo9TtRNngAw85ayeU7Y6Zw9qbIKBI
	 vgE181u/gJ7YDXxchU+e4w7ZfK51uW/PIuyoVU3YXeWAMXnB50F7XoBuVjjvF9UwuK
	 oqop5TBUiM3/c1x2qAKH6qkeMSdswvAs6HCppzXk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C0D3F804AE;
	Tue, 20 Sep 2022 01:09:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 612AAF80539; Tue, 20 Sep 2022 01:09:47 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD2C4F804AE
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 01:09:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD2C4F804AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UJN/7k+o"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B2BE3B81A6A;
 Mon, 19 Sep 2022 23:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A80BC433D7;
 Mon, 19 Sep 2022 23:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663628975;
 bh=pQAafg01ffLkLSnjXIOUXsCOiRe48tHjwt1h0N8nmLk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=UJN/7k+oxHQX1lnx0WHwyZuv9q/IHW4RNld5TD/wK8JjKutyQOq4pMmrU/nZ75sg8
 YlRa3QneYkn2oeRWhBlgwzEaT4DC1jGhvYgZONMZPwIdc3O+Z9MT/dHXII4ZhrI2HQ
 my+zhPwLpwxw2IkjvmpgQuxx/N6uFlVsCk4DvVIgoCLiOg3bVfRJS/9n9bjlLzEF+T
 GQZYwpkvawpAP3/NafmDfbixrHqa2WtIj4FD3R95lICIsbha7c6Ntk7FW6fBE0XbJh
 /3W2kbujPj9BZ+MO5XwAZww1Yr1FfnO4lm9eUApFzRSvhps7dlq+Vm+0S8tmlr4tTR
 Ms9ZjFRnI4CIA==
From: Mark Brown <broonie@kernel.org>
To: Wallace Lin <SJLIN0@nuvoton.com>
In-Reply-To: <20220915012800.825196-1-SJLIN0@nuvoton.com>
References: <20220915012800.825196-1-SJLIN0@nuvoton.com>
Subject: Re: [PATCH] ASOC: nau8824: Fix semaphore is released unexpectedly
Message-Id: <166362897277.3419380.16351123570334874819.b4-ty@kernel.org>
Date: Tue, 20 Sep 2022 00:09:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: alsa-devel@alsa-project.org, scott6986@gmail.com, WTLI@nuvoton.com,
 KCHSU0@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com,
 CTLIN0@nuvoton.com, dardar923@gmail.com, savagecin@gmail.com,
 supercraig0719@gmail.com
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

On Thu, 15 Sep 2022 09:28:00 +0800, Wallace Lin wrote:
> From: SJLIN0 <SJLIN0@nuvoton.com>
> 
> On resuming, we anticipate that the jack is detected before playback
> or capture. Therefore, we use semaphore to control the jack detection
> done without any bothering. During booting, the driver launches jack
> detection and releases the semaphore. However, it doesn't perceive the
> maniputation of semaphore is not like resuming procedure. This makes
> the semaphore's count value become to 2. There is more than one thread
> can enter into the critical section. This may get unexpected situation
> and make some chaos.
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/1] ASOC: nau8824: Fix semaphore is released unexpectedly
      commit: 7042bde216ada135b2f88423ae714ab9a22e3a22

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
