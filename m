Return-Path: <SRS0=R5RK=XF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2B7C3A5A2
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:06:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF1F208E4
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QoED+30V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF1F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=novotny.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5744C165E;
	Tue, 10 Sep 2019 10:05:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5744C165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568102799;
	bh=Usk1Hz5X707hAc1HH3eWmhvfUJ6CQh0vvuMadHww6l4=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QoED+30Vi2tCH+2dqo7ua0kkLuqZEXd1W3mXvgWF9XAXAqHe6BHKbdVy2/Md7Sun4
	 i1utsNw6Hp8M7ih6zvzI/B+xQznNHeMqRUqnv2K/o7KYRPfxMxmI3g1MmurKp4br82
	 qF+ov63YfcRpvnCycIR1N3sX4mploLMQUcvz5UwI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D574CF800C9;
	Tue, 10 Sep 2019 10:05:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69D57F80368; Tue, 10 Sep 2019 10:05:47 +0200 (CEST)
Received: from hosting.pavoucek.net (hosting.pavoucek.net [46.28.107.168])
 by alsa1.perex.cz (Postfix) with ESMTP id 19784F800E9
 for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2019 10:05:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19784F800E9
Received: from tomas.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz
 [176.74.132.138]) (Authenticated sender: tomas@novotny.cz)
 by hosting.pavoucek.net (Postfix) with ESMTPSA id 06DBE101BDD;
 Tue, 10 Sep 2019 10:05:40 +0200 (CEST)
Date: Tue, 10 Sep 2019 10:05:39 +0200
From: Tomas Novotny <tomas@novotny.cz>
To: Tony Lindgren <tony@atomide.com>
Message-ID: <20190910100539.03a4ea67@tomas.local.tbs-biometrics.cz>
In-Reply-To: <20190909162407.GO52127@atomide.com>
References: <20190906165109.53c5a306@tomas.local.tbs-biometrics.cz>
 <20190907091358.GA7166@lenoch> <20190909162407.GO52127@atomide.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Cc: linux-omap@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>,
 alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] omap-mcbsp: TX Buffer Overflow
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Tony,

On Mon, 9 Sep 2019 09:24:07 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Ladislav Michl <ladis@linux-mips.org> [190907 09:14]:
> > On Fri, Sep 06, 2019 at 04:51:09PM +0200, Tomas Novotny wrote:  
> > > Hi,
> > > 
> > > we have AM3703 based board similar to BeagleBoard. I'm hitting this error
> > > after upgrade to latest LTS 4.19.71 (upgraded from 4.1):
> > > 
> > > omap-mcbsp 49022000.mcbsp: TX Buffer Overflow!
> > > 
> > > This appears during or after playing of short (~2s) ding-dong wav. That error
> > > exists for longer time, because handling of tx buffer overflow irq was
> > > introduced in 2016: 4e85e7776eba ("ASoC: omap-mcbsp: Enable TX/RX under and
> > > overflow interrupts"). I've cherry-picked it to 4.1 and I see the error there also.
> > > The sound seems clear and ok to me, but we are using low quality speaker.  
> > 
> > Just FYI, for stream capture there's
> > omap-mcbsp 49022000.mcbsp: RX Buffer Underflow!
> > 
> > As far as I remember all stable kernels we have in production - 4.9.x, 4.14.x and
> > 4.19.x - are affected. IGEPv2 with both DM3730 and OMAP3530 are affected
> > (headless machines, CONFIG_VIDEO_OMAP3=n).  
> 
> Hmm I wonder if this is still related to the SoC idling?
> See commit 9834ffd1ecc3 ("ASoC: omap-mcbsp: Add PM QoS support for McBSP
> to prevent glitches"), maybe something still needs to be fixed in that
> area.

I also found the cpuidle information somewhere, but CPU_IDLE=n (and let PM=y)
didn't help me. I'm speaking just for playback. I can do some better test if
you want.

Thanks,

Tomas

> > And DT is probably worth updating:
> > omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
> > omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
> > 
> > I never motivated myself to dig deeper as catured stream looks pretty normal.  
> 
> These mean the devices should really have separate nodes
> in the dts rather than combining multiple devices into a
> single node with multiple reg entries.
> 
> The issue with combining multiple devices into a single device
> is that flushing posted write with a read back to one register
> range will not flush it for the other which can cause mysterious
> bugs.
> 
> Regards,
> 
> Tony
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
