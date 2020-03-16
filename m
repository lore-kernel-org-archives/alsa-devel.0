Return-Path: <SRS0=b36W=5B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A36C0044D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:05:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FF420663
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 12:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uSK6rM2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FF420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56FAB18C1;
	Mon, 16 Mar 2020 13:04:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56FAB18C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584360300;
	bh=Z6bp7v7F4CERo1cfYiHBsU9t/osbajJ1nYo30Gde18o=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uSK6rM2XvsWo6ebBCHcGEQOKCdaYD3rUvj61CIyf97DdxYGwxz0467ByDOYtTjEBD
	 jhiBtuhEDM7ztU/6E0d1eEqWBEPZ+kKQQ2MyCNEoU1pfCU3u729cDXxpxEoGm07OjP
	 KuZcra5etMaBYt9Ga05RDbe3AXUQSEJUAQiUwZQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F300F800CD;
	Mon, 16 Mar 2020 13:03:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F7D0F801F9; Mon, 16 Mar 2020 13:03:51 +0100 (CET)
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [IPv6:2a01:4f8:212:88::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A6D6F800CD
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 13:03:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A6D6F800CD
Received: from [10.1.2.107] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id BBBFF5767067;
 Mon, 16 Mar 2020 13:03:46 +0100 (CET)
Subject: Re: [PATCH 1/3] ALSA USB MIDI: Fix port starvation
To: Andreas Steinmetz <ast@domdv.de>
References: <c9aed355adc93d5de0cc4c740d16d19e3e210f79.camel@domdv.de>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <36c09bfb-7d28-84c5-acba-9c74ad153a83@ladisch.de>
Date: Mon, 16 Mar 2020 13:03:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c9aed355adc93d5de0cc4c740d16d19e3e210f79.camel@domdv.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.101.4 at webclient5
X-Virus-Status: Clean
Cc: alsa-devel@alsa-project.org
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

Andreas Steinmetz wrote:
> the snd_usbmidi_transmit_byte helper had to be converted to
> return output notification to allow for the 'repeat' shortcut.

Why not simply handle one MIDI byte per port in each iteration?  It
could be argued that single-byte MIDI commands are likely to be real-
time messages and deserve to go first.

> Current multi port MIDI interfaces do
> typically have 2^n output ports and 2^x as wMaxPacketSize where x>n.

The USB specification requires bulk endpoints to have a wMaxPacketSize
value of 8/16/32/64 for full speed, or exactly 512 for high speed.

> For the patch to properly work the wMaxPacketSize of the device must be
> large enough to allow for at least one MIDI event per port in a URB.

There are devices that handle only the first four bytes of a received
packet (because Windows used to send only small packets), and one of
them, the ESI M4U, actually has more than one port.

My original idea for that FIXME was to use round robin until the packet
is filled (or all ports are empty), and to store the next port index
(where to start for the next packet) in the endpoint.  This would be
able to distribute the balancing over multiple packets.


Regards,
Clemens
