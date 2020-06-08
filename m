Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B0FC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:33:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E62A206A4
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bgswEdeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E62A206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bollie.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B59B15E2;
	Mon,  8 Jun 2020 10:32:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B59B15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591605205;
	bh=BSK/c5FkEOeV9RpvB0Ax5dsayyzpcarhUzL6mtIMa3U=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bgswEdeBO/4AZQwYXh/30ABT6zohM6WQ7fkg1nxC5zJr128gXJyGPoOQ2K8q+XGhr
	 Itj0m1rARwRPdDvAAkrgU1HIrWAk2IJXe4HzEvdhrekrkmHnZrcbpbNiBz0CiUbcUj
	 JEZ6dQLEIA7sY6Neh3ZB7vsHouI+HNPO7VZdl2N8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F69AF801F7;
	Mon,  8 Jun 2020 10:32:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 095F2F8021C; Mon,  8 Jun 2020 10:32:33 +0200 (CEST)
Received: from bollie.ca9.eu (bollie.ca9.eu [81.169.254.190])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 166F6F80125
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 10:32:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 166F6F80125
Received: by bollie.ca9.eu (Postfix, from userid 8)
 id E428EC315E; Mon,  8 Jun 2020 10:32:26 +0200 (CEST)
Received: from [192.168.1.100] (p3e9d4712.dip0.t-ipconnect.de [62.157.71.18])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by bollie.ca9.eu (Postfix) with ESMTPSA id D804CC04FA
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 10:32:24 +0200 (CEST)
Subject: Re: Clock sync problem?
To: alsa-devel@alsa-project.org
References: <20200607133959.kmljpqdwefuio3mk@overdrive.tratt.net>
 <s5hk10i58io.wl-tiwai@suse.de>
From: Thomas Ebeling <penguins@bollie.de>
Message-ID: <14f91307-c121-a9f8-4045-1319ee0ca49e@bollie.de>
Date: Mon, 8 Jun 2020 10:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <s5hk10i58io.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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


On 08.06.20 09:19, Takashi Iwai wrote:
> On Sun, 07 Jun 2020 15:39:59 +0200,
> Laurence Tratt wrote:
>> Hello,
>>
>> I've found an interesting issue with an SSL2+ audio interface -- it plays and
>> records fine (and, for the money, the sound quality is excellent!), but
>> recording slowly but surely drifts over time. For example, if I record a
>> click track in Audacity (or Ardour), play it through the interface and record
>> it, and then line up the start of the recorded click track with the original,
>> the two tracks will be around 5ms out of alignment after 30s. Interestingly,
>> this problem does not happen with OpenBSD, where the two tracks line up
>> precisely.
>>
> The recent change in USB-audio might help for a case like yours.
> Try my sound git tree (for-linus branch) or Linus' tree.  The former
> should be pullable onto 5.7 kernel cleanly.

Since I recently had clock drift issues with Audient devices, I'm 
intrigued by this. @Takashi Can you quickly elaborate, what you think, 
Laurance's issue might be and what has changed in that tree that might 
help him fix it? Is there some general issue with the current (stable) 
sound/usb implementation?

Thanks!

Thomas
