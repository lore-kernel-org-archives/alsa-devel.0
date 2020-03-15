Return-Path: <SRS0=Xern=5A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A90C10DCE
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Mar 2020 11:59:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D4020663
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Mar 2020 11:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PZtnXrrK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=domdv.de header.i=@domdv.de header.b="FPuhmfmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D4020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=domdv.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A88F41;
	Sun, 15 Mar 2020 12:58:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A88F41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584273555;
	bh=MjFiTFoDnO8i211USixOAWnclqSyAHAvQPSHlZU5GQQ=;
	h=Subject:From:To:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PZtnXrrK+beF/dVAfVJgeX2ksxBcxxkm4qf9FtrZJ1mi+iqCao+hX+7sF21B6kq6z
	 i9CBhU+6JVXbvkerO7ItxhYWg2WhBYpGzwfivSPrBg7SsX/uhkJWpNcBUtosI9Ar9e
	 N8Yp7yr5I8UOz3vRtOApSKR5dWy00arWcVilye4U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62A5BF800CD;
	Sun, 15 Mar 2020 12:58:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 230CAF8022B; Sun, 15 Mar 2020 12:58:22 +0100 (CET)
Received: from zeus.domdv.de (zeus.domdv.de [IPv6:2a02:2ad0:c00::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77C71F800CD
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2020 12:58:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77C71F800CD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=domdv.de header.i=@domdv.de
 header.b="FPuhmfmG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=domdv.de;
 s=dk3; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:Cc:To:From
 :Subject:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MjFiTFoDnO8i211USixOAWnclqSyAHAvQPSHlZU5GQQ=; b=FPuhmfmGET6ari3ojnZziOMTJd
 QfiibOWWC+AlZM6jOxKgpqNbfrAzwA9xfnoW4uPMVuSYLpZgIJ2VwSgt4MN2uVYHXhlW4YpveJtD+
 WDpV/OtfF8Bz3t4LU8c94nZTXVBn3zT49Gw16Dekd4n9X/GI8ZBTG6FAXCbQPwfMqW1A=;
Received: from [fd06:8443:81a1:74b0::212] (port=1692 helo=castor.lan.domdv.de)
 by zeus.domdv.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ast@domdv.de>)
 id 1jDRtK-0007gS-8R; Sun, 15 Mar 2020 12:57:14 +0100
Received: from woody.lan.domdv.de ([10.1.9.28]
 helo=host028-server-9.lan.domdv.de)
 by castor.lan.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92.3) (envelope-from <ast@domdv.de>)
 id 1jDRtK-0007oi-35; Sun, 15 Mar 2020 12:57:14 +0100
Message-ID: <3b4a4e0f232b7afbaf0a843f63d0e538e3029bfd.camel@domdv.de>
Subject: BUG: ALSA snd-virmidi: snd-virmidi is not MIDI 1.0 specification
 compliant
From: Andreas Steinmetz <ast@domdv.de>
To: alsa-devel@alsa-project.org
Date: Sun, 15 Mar 2020 12:57:13 +0100
Organization: D.O.M. Datenverarbeitung GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de
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

snd-virmidi, as of kernel 5.4.23, does not adhere to the MIDI
specification:

From MIDI 1.0 Detailed Specification, Document Version 4.2, Appendix A-
1 (RUNNING STATUS), Page A-2:

"3. Buffer is cleared when a System Exclusive or Common status message
is received."

snd-virmidi does not clear the running status in case of a SysEx
message.

How to test:

Load snd-virmidi module and get the card number of the module.
In the following 5 is assumed as the card number and device 1 is used.

You need two shells, in shell 1 do:

aconnect 'Virtual Raw MIDI 5-1':0 'Virtual Raw MIDI 5-1':0
amidi -p hw:VirMIDI,1 -d

Now, in shell 2 do:

amidi -p hw:VirMIDI,1 -S '80 01 02 F0 01 F7 80 02 03'

This sends a note off, followed by a SysEx, followed by another note
off. The result in shell 1 is:

80 01 02
F0 01 F7
02
03

So snd-virmidi did not clear the running status. The correct result
would be:

80 01 02
F0 01 F7
80 02 03


