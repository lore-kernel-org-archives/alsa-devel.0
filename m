Return-Path: <SRS0=lfZM=BO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9380CC433E1
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:04:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422C622C9F
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cXxqNwrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422C622C9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74B44165E;
	Tue,  4 Aug 2020 12:03:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74B44165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596535469;
	bh=V/gSWNp9dRmlhIku9v1APqSIQi+F/s4ezcSIh+xlDeU=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cXxqNwrk0kd/JZW5ETcv4BGnTi6d7FMfgnGLloWte1CPJlMR9HW0pfhxATM0RC3+K
	 IFgHuu9+pHROaJW7oIJIMG7xIxgm0nSx7mwsa8wF9czBvIWqoAoc0dp1VZyu2wI8ct
	 /gof9EewAL8GU0jFeJ4/onj5U+yYGEJA89YTF6FM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18A92F8014C;
	Tue,  4 Aug 2020 12:03:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59BB7F80150; Tue,  4 Aug 2020 12:03:36 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 427B6F800B7
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2020 12:03:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 427B6F800B7
X-Originating-IP: 82.255.60.242
Received: from classic (lns-bzn-39-82-255-60-242.adsl.proxad.net
 [82.255.60.242]) (Authenticated sender: hadess@hadess.net)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1B594C0005;
 Tue,  4 Aug 2020 10:03:28 +0000 (UTC)
Message-ID: <177c5035121d784c06e07631121e1b276962b957.camel@hadess.net>
Subject: Re: Lenovo m720s combined audio jack not working (ALC233)
From: Bastien Nocera <hadess@hadess.net>
To: alsa-devel@alsa-project.org
Date: Tue, 04 Aug 2020 12:03:28 +0200
In-Reply-To: <fd8d4a187c86c3514e4442a404ad2568014c5d0b.camel@hadess.net>
References: <fd8d4a187c86c3514e4442a404ad2568014c5d0b.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Mark Pearson <markpearson@lenovo.com>
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

On Tue, 2020-08-04 at 11:56 +0200, Bastien Nocera wrote:
> Hey,
> 
> The front audio jack on my newly purchased (but not new) Lenovo m720s
> doesn't make a microphone output appear in PulseAudio when a headset
> is
> plugged in. The headphone part works correctly though. The "sof-hda-
> dsp 
> Front Headphone" evdev device will switch the state of
> SW_HEADPHONE_INSERT as expected.
> 
> Does anyone know whether the headphones/headset switching is supposed
> to be automatic, or would that trigger a "what did you plug in"
> dialogue as on some Dell machines I've worked with?
> 
> I couldn't find any quirks in sound/pci/hda that would be directly
> related to this problem (eg. Lenovo, ALC233 and mic presence), so I'm
> a
> bit stumped.
> 
> I've attached the pinout information from alsa-info.

I should note that I'm using BIOS version M1UKT21A, and that the latest
is 25 releases newer, so that it's very possible that a newer BIOS
would fix this. I'll have to try that first.

Removed David from the CC:, as I don't have a current address for him.

