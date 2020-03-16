Return-Path: <SRS0=b36W=5B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B89C0044D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:47:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB982051A
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YzKMKW0s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=domdv.de header.i=@domdv.de header.b="Ukc8mbAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB982051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=domdv.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87DEF18AB;
	Mon, 16 Mar 2020 11:46:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87DEF18AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584355663;
	bh=S/1Y4O23lIddwSUe1teP2zr0vwrIPG2pB/TowS44Who=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YzKMKW0smdSKEwtTQ/aPWtQsVQ7rg6h4dCCkekstx6vvJX+A829uLBUEjbWMMOmki
	 ujPvUYrrmFGL40klPZrpVJFytkBsypWo8L8+fdPK/T0Vkc45HpwY5oBg8kOwnObF+M
	 R7FP7CYL9DHR7Sk5HnHp9oSjMq11uDl0L7MLU8jY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD809F800CD;
	Mon, 16 Mar 2020 11:46:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16397F8015B; Mon, 16 Mar 2020 11:46:51 +0100 (CET)
Received: from zeus.domdv.de (zeus.domdv.de [IPv6:2a02:2ad0:c00::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EEBBF800CD
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 11:46:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EEBBF800CD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=domdv.de header.i=@domdv.de
 header.b="Ukc8mbAv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=domdv.de;
 s=dk3; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+l3oTbxdX7q1WFtg2eKRYQqV+Z7HWgVSDM8DO8p0Wkc=; b=Ukc8mbAvlH6dn3ZMCOxvo+HZZO
 PlgwujWe8lZd0wtaqnmfT/O5nt7QJ4fOIVQXagbOb6c7zvrucB959UGRteqDflERaUDvti6Yl7c1f
 xO1axwSeGYrjlidgtFRMKlGyevU4GfQYSNXNzL8HG+d3VHoAdkWUmBZ0Gq5ZiipxaV1E=;
Received: from [fd06:8443:81a1:74b0::212] (port=2572 helo=castor.lan.domdv.de)
 by zeus.domdv.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ast@domdv.de>)
 id 1jDnFd-0001zT-Q5; Mon, 16 Mar 2020 11:45:41 +0100
Received: from woody.lan.domdv.de ([10.1.9.28]
 helo=host028-server-9.lan.domdv.de)
 by castor.lan.domdv.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92.3) (envelope-from <ast@domdv.de>)
 id 1jDnFd-0001po-KL; Mon, 16 Mar 2020 11:45:41 +0100
Message-ID: <294a0fe8277587a815b6b54abe539c94c8f5b11b.camel@domdv.de>
Subject: Re: [PATCH 0/3] ALSA USB MIDI: Predictable low latency for USB MIDI
 output
From: Andreas Steinmetz <ast@domdv.de>
To: Takashi Iwai <tiwai@suse.de>
Date: Mon, 16 Mar 2020 11:45:41 +0100
In-Reply-To: <s5htv2ozo4t.wl-tiwai@suse.de>
References: <42a9a862efbc9cfdacc783f816f93340ccc58cec.camel@domdv.de>
 <s5htv2ozo4t.wl-tiwai@suse.de>
Organization: D.O.M. Datenverarbeitung GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
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

On Mon, 2020-03-16 at 09:42 +0100, Takashi Iwai wrote:
> Thanks for the patches and the analysis.
> 
> So, judging from the experiments above, outqueue=1 has no measurable
> performance regression?  For 4 ports, it's even an improvement.
> Then we may change the default value.
> 
> I guess you kept the old value just to be conservative, but if the
> number tells a better story and it's no part or ABI, we may consider
> changing the default for a better performance.
> 
> Or, is there any other potential risk by changing this?
> 
I'm very careful here. MIDI based equipment (and that includes MIDI
interfaces) is typically very long lived (I do have equipment that is
more than 20 years old). Thus I cannot guarantee that changed defaults
will not harm performance of older equipment.

I do prefer to keep the current defaults and allow users to, well,
experiment if modifications to the defaults do work and actually help
for their hardware. I would not want to break usability of older
hardware.

Regards
-- 
Andreas Steinmetz

