Return-Path: <SRS0=22TH=3O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D3C2D0DB
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jan 2020 14:39:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9D72071A
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Jan 2020 14:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aAxyckov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9D72071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jensverwiebe.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E5F3166B;
	Sat, 25 Jan 2020 15:38:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E5F3166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579963181;
	bh=27fsQGvcKxo5RTm/GjAC965a/pvGMINC8uk9RokcuKw=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aAxyckovkuAcRTCS2i+B7A9wkWu6GLsBXH9RfSYbQOtuWqoS7LGuTHrQWO4hQ8LpX
	 iWtEqgYxQhZkK+2I9M0Bwxzcaxr2WhJ0/TOnCPs6pe0k5R4DIx6HWovybDj5nYYXct
	 IreBPR4rpo9X8jpoVSx8YiDLjXWBlcTiQtM3W+Xo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EC36F8012E;
	Sat, 25 Jan 2020 15:38:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D798F801EC; Sat, 25 Jan 2020 15:38:49 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DE8FF8012E
 for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2020 15:38:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DE8FF8012E
Received: from [192.168.178.21] ([77.10.30.73]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4h7p-1jdBtS2FJX-011j49 for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2020
 15:38:45 +0100
To: alsa-devel@alsa-project.org
References: <s5hd0b71v0o.wl-tiwai@suse.de>
From: Jens Verwiebe <info@jensverwiebe.de>
Message-ID: <9f87437b-983c-01f8-60ec-e4c1f0ea3d7f@jensverwiebe.de>
Date: Sat, 25 Jan 2020 15:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <s5hd0b71v0o.wl-tiwai@suse.de>
Content-Language: de-DE
X-Provags-ID: V03:K1:ja0Q7YR1uJ9Wzffngh1W1I4oImQ0HPHg4M+Q1RJGnpQFY56Ac17
 +1eqTEAQBYze3xPzk/FERS15JbUUQy7qKmdzcYFHFDGgkewcNAy7BxA+MpcUngIduMPfIbF
 k/rfVzwVNOtY+6OWsap7pl71Ll1gxbDtG+xYV7muuTyJqaJHk+IVTbWvSPWkliUCP6xYGZo
 ts98W9KiYgyTRvoqlwQ/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UvEoJeQjEIw=:xSsFttbFEn/hRlndQE/utx
 wDCIgIqqIFtP5Y5kY/eiVWTMEBkD1kPXE+gYDY6LslQEXCtJWbRal5wyYHEo9697vAvr36fle
 XLg74N7xjih1tun8tvc2iJBj4MWuQr2FkjA31TANnReULWNf5xxnWoosxgjJBrfC34hfcKJP4
 Ta4iYO+gcQPW60gYaelrNaWs4TxBmyYpNnIaZEXaj1NRWUM6NOHKpLqmc2BKXifRRyjRRo4qJ
 M+kCPERK9HI8qtjAZeN/97cJ7lm3ixZaMrDukk0t6DPxZfB109rFfjJ28h9y91CYp5p7Qd3l3
 tPIy1vfa2CXFGFHsr/3usTOxKVq0snSXvTEf8G/+i1XY74DqzzOCx9FPTmg/UABrKibsL1LDX
 QteBAMluJpfNUwZKL0GhDIBIQPGvRb/4LEmlNgXYb5Uo7Wxyg1h+6/S3PfU6c79IDKJxHZ2Yl
 nSdE12jsEG/zCAszuK9l02ZvobkPuM5d8kG3hp3zbPx9xl7XtcgFg7kb5ymup5cdvXnpw68zA
 gwfav+Dx9odfhAyIgczXvwZ/OD8FwZru20eLOG9G7MVNSCdePpS6bZpA7juplO7MrFj9T/g5E
 r5W2FP67NJqzi1PtIklMHXrjqLXxRsyICmCKgGdD3Fa027v4K/2Ly3DhbWWsMZw/HdBf7DTKc
 KB7XyP46r1e1vJai/NcIxQySwMBntpXbn45bpT/PZw5q55fc2lppINWNpl+m//jwgoji5NdFR
 dS9bjYt05cZwpBTx72iM2aK/QArdqFKxxj1RAJzR57Kpwy8ccneH3aeh2J4ICQGIiNVKzBU+U
 XHnGdauFCgPVbXdlucIItC3ssV1bLkAwU8SjMpe//ReWFlkTitWISnnAzqxNcGN4iwElEHy
Subject: Re: [alsa-devel] [PATCH] ALSA: usb-audio: add quirks for Line6
 Helix fw 2.82
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Kinda

Nicola made a request in the line6 forums and got at least helix lt 
confirmed.

As he took over my original patch + a fallback i want leave this to him to

maintain all new ( core ) ID's now.

Also i'd like to mention again that this "hardclocking" only makes helix 
devices

setup initially but does not prevent the sync shifting away after some time.

I was hoping the solution Mike Oliphant found for the Boss device would 
also fix the Helix sync,

but there is a bit more todo i fear. ( implicit feedback not working )

Still on that ....


Jens

-- 

Jens Verwiebe
Allerskehre 44 - 22309 Hamburg

Tel.: +49 40 68 78 50
mailto: info@jensverwiebe.de
web: https://www.jensverwiebe.de

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
