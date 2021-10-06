Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F09DC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 14:26:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8AD61056
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 14:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A8AD61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC661839;
	Wed,  6 Oct 2021 16:25:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC661839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633530378;
	bh=P5fJRAs6hdeKxsNDMy/kRPP23vjvmQizvE/JaG3Gz7k=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nlMeXYsz/bYz23VxP1FlMxQyD9SI4i7v6fZGXOti02duXS58PgWDAqn6+g6RQytb7
	 4iRio964Dwb2/xNGWpVC2UmETV0Pl/HJBkEVRhNtjQcJYtMwhB5rpCSlXryTRxqDHZ
	 KhZIwnxI0sy/cLpcDVvzGStWGaWkY0+iHPW/Em2s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69639F80229;
	Wed,  6 Oct 2021 16:25:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7453CF80240; Wed,  6 Oct 2021 16:25:24 +0200 (CEST)
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9EBDF8010B
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 16:25:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9EBDF8010B
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 5D86FC800AA;
 Wed,  6 Oct 2021 16:25:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id cK3OxzFKXTNg; Wed,  6 Oct 2021 16:25:14 +0200 (CEST)
Received: from [192.168.178.82] (host-212-18-30-247.customer.m-online.net
 [212.18.30.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPSA id F0CF6C800A8;
 Wed,  6 Oct 2021 16:25:13 +0200 (CEST)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for TongFang PHxTxX1
To: Takashi Iwai <tiwai@suse.de>
References: <20211006130415.538243-1-wse@tuxedocomputers.com>
 <s5hpmsib5wp.wl-tiwai@suse.de>
From: Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <ca37123b-5779-b546-089b-9af61f68a2b2@tuxedocomputers.com>
Date: Wed, 6 Oct 2021 16:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5hpmsib5wp.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com
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

Am 06.10.21 um 16:10 schrieb Takashi Iwai:

> On Wed, 06 Oct 2021 15:04:15 +0200,
> Werner Sembach wrote:
>> This applies a SND_PCI_QUIRK(...) to the TongFang PHxTxX1 barebone. This
>> fixes the issue of the internal Microphone not working after booting
>> another OS.
>>
>> When booting a certain another OS this barebone keeps some coeff settings
>> even after a cold shutdown. These coeffs prevent the microphone detection
>> from working in Linux, making the Laptop think that there is always an
>> external microphone plugged-in and therefore preventing the use of the
>> internal one.
>>
>> The relevant indexes and values where gathered by naively diff-ing and
>> reading a working and a non-working coeff dump.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Thanks, applied.
>
>
> Takashi

Thanks for being quick as always ^^

I forgot to add cc: stable to the patch. Whats the best practie to do that after the patch has already been applied?

Just send it again mit with cc: stable?

Kind regards,

Werner Sembach

