Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532B2C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 06:52:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BE3207E8
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 06:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SW5oSlSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BE3207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26E561787;
	Wed, 27 May 2020 08:51:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26E561787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590562337;
	bh=2qpOukN+r2zz5WUIyCJIdytnKDhKoJOFuvO6vXYx5VQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SW5oSlSOyrRmeO5T29eCDWDzkGHJPrGW2+FPsVLINtcQvQJ9QmH/bXollVguIUxtm
	 KOWq1GzIVt/B72rUUxPosFJsCc5tIwFARdZX0YAPw9TuYzr9H0yKzHcifS8Z6M4NWq
	 8u7C4nyw2Ypf4+PsPMf4peeyl7PZnl1UxBNmvKNw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAEE9F80149;
	Wed, 27 May 2020 08:51:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24317F8014E; Wed, 27 May 2020 08:51:25 +0200 (CEST)
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [IPv6:2a01:4f8:212:88::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6F9CF80146
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 08:51:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6F9CF80146
Received: from [10.1.2.92] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 1329E5C6502D
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 08:51:16 +0200 (CEST)
Subject: Re: Alsa Midi Driver Question/Issue
To: alsa-devel@alsa-project.org
References: <770a8eb1beaf66e2ac4d3f12e42adda5@grossmann-venter.com>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <55e62133-e616-8d1c-5635-ba2532143331@ladisch.de>
Date: Wed, 27 May 2020 08:51:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <770a8eb1beaf66e2ac4d3f12e42adda5@grossmann-venter.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.101.5 at webclient5
X-Virus-Status: Clean
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

liebrecht@grossmann-venter.com wrote:
> Bitwig absolutely requires to have exclusive access to a USB pad Controller

ALSA has two MIDI APIs.

The low-level RawMIDI interface gives low-level access to the raw bytes
going over a port, and usually allows only exclusive access.

The sequencer interface deals only on messages, allows user-space programs
to create their own ports, and allows multiple connections per port.  When
a sequencer port corresponding to a hardware port is opened, the RawMIDI
port is also opened and thus blocks other accesses.

Apparently, Bitwig uses the RawMIDI interface.

Try loading the snd-virmidi module (which creates a virtual sound card),
and tell Bitwig to use that.  You can then connect its sequencer ports
to whatever hardware or software ports you like.


Regards,
Clemens
