Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA24C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:50:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C19206F4
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W5rNio9N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="kp4TGNEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C19206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEA6815E4;
	Wed, 10 Jun 2020 15:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEA6815E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591797012;
	bh=RcCDENTk4744k5I08BTTzwKJGi3k1YJpsjPoSpppoUY=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W5rNio9Noj6Fbfesz0Jqfn+H04T7gPm/KgcyvVe9S/Mb6mo6CMDRUJ5XlfSWelmQx
	 wvWzMeAgpi9yIpXlNLUI07a2auWzoLddwdWbMVGY//YGMo1L8XSCEi6cjGDT1+lmxP
	 jdcHENvHL7rCjUuXSdNuwqqnZNLYC12KvU0/EZkM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68F79F801F7;
	Wed, 10 Jun 2020 15:49:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC9BDF8021C; Wed, 10 Jun 2020 15:49:20 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBBCAF80058
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 15:49:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBBCAF80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="kp4TGNEF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=D5hKdquVX+IdfMBHborXt+0KRg8Bp/MjyiIh4IgWVZA=; b=kp4TGNEFrdV4GRHUB2yDqvSZlb
 YB/iG0WPSPzt7nCV4xGBlvcbqtv+FkpjNm6dr8jTWFHkrYy/yvhYJ7mV3b7zecScChv9XdrKhCev2
 57eFaS2cGCbTkQ038qc8RWfLt9sVIYIdk0OSog0iDuPH+1RTpaeKxea+jT99RHcwAkA4=;
Received: from [2a00:1370:8125:614e:c510:d933:d0ef:dfce] (helo=home)
 by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.93.0.4) (envelope-from <puleglot@puleglot.ru>)
 id 1jj16R-0007Kv-6f; Wed, 10 Jun 2020 16:49:15 +0300
Message-ID: <325c117faed8514693f0f82d00961efa09fc1b00.camel@tsoy.me>
Subject: Re: Clock sync problem?
From: Alexander Tsoy <alexander@tsoy.me>
To: Laurence Tratt <laurie@tratt.net>
Date: Wed, 10 Jun 2020 16:49:14 +0300
In-Reply-To: <20200610074409.aknnhrzzu3ulfa4e@overdrive.tratt.net>
References: <20200607133959.kmljpqdwefuio3mk@overdrive.tratt.net>
 <s5hk10i58io.wl-tiwai@suse.de>
 <14f91307-c121-a9f8-4045-1319ee0ca49e@bollie.de>
 <s5htuzl4r4f.wl-tiwai@suse.de>
 <d74af0e9a3074c3c9104cac7407185c825378de5.camel@tsoy.me>
 <20200610074409.aknnhrzzu3ulfa4e@overdrive.tratt.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Thomas Ebeling <penguins@bollie.de>
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

В Ср, 10/06/2020 в 08:44 +0100, Laurence Tratt пишет:
> On Mon, Jun 08, 2020 at 05:43:05PM +0300, Alexander Tsoy wrote:
> 
> Hello Alexander,
> 
> > > The frame size calculation in USB-audio driver wasn't accurate
> > > enough
> > > because of the computation in Q16.16 format.  It works OK for
> > > async mode,
> > > but for others, it can accumulate rounding errors.  The recent
> > > change
> > > corrected it for a more precise way.
> > I believe that SSL and Audient devices operates in async mode.
> > Would be
> > nice to see "lsusb -v" output for them.
> 
> Please find attached the "lsusb -v" output.

Thanks! So SSL 2+ is indeed currently needs implicit feedback quirk.
The question is why it didn't help in your case.

