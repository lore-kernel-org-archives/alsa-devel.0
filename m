Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813A8C19437
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 20:07:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E9922225
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 20:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E9922225
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deus.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1713C1840;
	Thu,  3 Dec 2020 21:06:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1713C1840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607026052;
	bh=GQco8SjzoXTIeMda3xFlCfZLCE+K8/9l1WpnFhTCYSE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nEc8yexOm/ORKQvhmuxto2jkVIqlD3CWRq4AsoCv7ZFT4XBSisH0IWCNpvFDVmynY
	 vYXbXfG+LYnEy25XtXjuE0DRnRTM+aRGYGytO/88YaAyuYs4Xec4e/h73q1e2PsxpR
	 uPDpInJEj8w8K/YoujnvcW1/SKJwKj4vNJSJuBtg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 432E5F80158;
	Thu,  3 Dec 2020 21:06:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96395F8016D; Thu,  3 Dec 2020 21:06:39 +0100 (CET)
Received: from roobarb.jellybean.co.uk (roobarb.crazydogs.org [46.235.224.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D98F8F800E8
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 21:06:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D98F8F800E8
Received: from localhost ([127.0.0.1])
 by roobarb.jellybean.co.uk with esmtp (Exim 4.92)
 (envelope-from <bjb-alsa-devel@deus.net>)
 id 1kkurw-0001ZW-CV; Thu, 03 Dec 2020 20:06:24 +0000
Date: Thu, 3 Dec 2020 20:06:24 +0000
From: Ben Bell <bjb-alsa-devel@deus.net>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Subject: Re: Behringer WING usb audio - cyclic xruns dependent on
 periods/buffers
References: <20201126180612.E3E0CF80166@alsa1.perex.cz>
 <s5hblfjjguc.wl-tiwai@suse.de>
 <20201128093612.48C0CF80166@alsa1.perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128093612.48C0CF80166@alsa1.perex.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bjb-alsa-devel@deus.net
X-SA-Exim-Scanned: No (on roobarb.jellybean.co.uk);
 SAEximRunCond expanded to false
Message-Id: <20201203200639.96395F8016D@alsa1.perex.cz>
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

On Sat, Nov 28, 2020 at 09:36:00AM +0000, Ben Bell wrote:
> > In general you should avoid 44.1kHz if you want a small period size
> > for a realtime process on USB-audio.  With 44.1kHz, the packet size
> > can't be fixed in integer, and the ISO transfer requires variable
> > packet sizes.  OTOH, ALSA API requires the fixed period size, hence
> > it'll lead to inconsistencies occasionally.

So changing to 48kHz had no appreciable effect, but I'm working at that
rate for now to eliminate the 44.1kHz weirdness from investigations.
Using a USB2 card, also had no effect. Testing with a different USB audio
interface (albeit a simple stereo one) didn't exhibit the behaviour, even
when I took buffer sizes right down.

I'm not sure where to go to get more information or where's the best place
to ask for help. I'm happy to do the leg work, but I don't know enough
about the kernel, alsa or USB to figure it out without some help.

Current question: what is the delay in /proc/asound/card1/pcm0c/sub0/status
actually measuring? I'm assuming it's measured in samples? I've written
something to scrape the stats out in a tight loop and report.

What I see is a cycle where the delay rises and then a chunk equal to the
frames per period (or sometimes, earlier on fpp-48) is removed. That feels
like chunks being read out of a buffer. All fine.

After a while though, the maximum delay we reach with each cycle is creeping
up. It increases by one every few cycles (usually two or three, or three or
four -- always oscillating between two values) but of it's still only being
emptied by a full period's worth of samples each cycle. So the overall effect
is the delay creeps up and up until it hits the buffer size and then we get
an xrun.

Like I said in the initial email, it feels like some sort of clock drift
problem, where we're managing very slowly to collect more samples than
we're reading -- to the tune of about 1 extra every few cycles -- and
nothing on the consumer side is ever managing to compensate for that.
I'm not even sure how that sort of drift would be possible though. Seems
surprising.

Does any of this sound suspicious, or for that matter completely normal?
Any suggestions where should I be looking next?

bjb



