Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA4DC433E1
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:09:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217FD207BC
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gJpW7CrK";
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="YtIFvNqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217FD207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE2B21671;
	Mon,  8 Jun 2020 12:08:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE2B21671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591610953;
	bh=Xrng9HgE5HPvIAp1NSK4MnUJUDNRKMXBFpteoCe0zYw=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gJpW7CrK1vBRXGm78MDjZC687DrkacG2Zf+b4sdG4vKksQfzIcDEG+8CUHtAaBAyv
	 iaIonNAUdca7aptLJ6UPV2+SnVKmlQFm16fzLI7NiEXMFmBcY0poCgVMa9d8DAyDwk
	 laP7Cwz5G9AUnVX6fdrk8AJX4UJWFf3BSVxguH88=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B047F802A0;
	Mon,  8 Jun 2020 12:06:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBBA4F801F7; Mon,  8 Jun 2020 12:06:41 +0200 (CEST)
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B8DCF8021C
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 12:06:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B8DCF8021C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl
 header.b="YtIFvNqv"
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 49gTRr0G62z2d;
 Mon,  8 Jun 2020 12:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1591610792; bh=Xrng9HgE5HPvIAp1NSK4MnUJUDNRKMXBFpteoCe0zYw=;
 h=Date:From:Subject:To:Cc:From;
 b=YtIFvNqvAgjAXTyf+AhtXaVrR7FsPn42OVG+x8gNrWDykD5AAnSh8U17Toy7c27Mm
 sWWzHnXRiNKpBHvJ2eyDgTSLtJlLCzVElljrXW1XiJUnPI5yClZZb9vIPdE8BsNiL+
 /dH1BS1D/f5490Z50t3q5TCFZzX9tfzKar4ffgRMPmVmZTAymFEYsL6Q/4g0JuOjYZ
 DxTlYgihFZFrsgV7twUoUmOzUVF3bC5tJSx6naxrgInPZ2d58z5201NBD/IVHHjSww
 fXbA4gSyu6lF9ooRp9zvdXbRv4bioQ9X/NcDtBuJRL58M09jR2EUh9q/ix11tIBf/X
 eBOMxOOiM3/1w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date: Mon, 08 Jun 2020 12:06:30 +0200
Message-Id: <cover.1591610329.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/2] ALSA: pcm: stream linking locking fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

Two patches fixing locking issues for SNDRV_PCM_IOCTL_LINK handling:
first adds a check preventing linking a stream to itself, second quiets
lockdep warning about nested locks.

Michał Mirosław (2):
  ALSA: pcm: disallow linking stream to itself
  ALSA: pcm: fix snd_pcm_link() lockdep splat

 sound/core/pcm_native.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.20.1

