Return-Path: <SRS0=1fsy=7W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC422C433E1
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:18:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3808E2074B
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2020 13:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N8Uc7wKp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="WvAeGGBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3808E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E5AD166E;
	Tue,  9 Jun 2020 15:17:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E5AD166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591708683;
	bh=TlLZeOqml6wgxmkxuKIWIRG7bpP2JBHvK+JBeRuHLbw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N8Uc7wKpQf4qOtljWdw/mbVOf3sthSeBO5IXsW/gb0Vx+1ckr8HUo6RMwAUa5Q960
	 psnptANE6LZUqHDvJhzaMagwQ2Sz+pawNEiQtMd/YHx2U6eKEqO1HI+Mob1UOfVzE9
	 C8O3Wq35vAg49jXsHUr5EWUqwlhMiwoLteJKZ6Ro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A6FBF80278;
	Tue,  9 Jun 2020 15:17:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D7A3F8028C; Tue,  9 Jun 2020 15:17:00 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAEDBF80124
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2020 15:16:54 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B823CA003F;
 Tue,  9 Jun 2020 15:16:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B823CA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1591708612; bh=Q6pAyvWAA5MDPmhkXsBCOnRP+oa87wANg1kmgbc1Kpc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=WvAeGGBAMKiFOFjTPXv8K3w5I1fxEZVOhQaZiXlSH1MVoJCMwtDLsMxaOSFHber3c
 L1N+Ix+80HnPbrBixJ0V62C0B7d0XedIZzq/bLDST90WHVbtdXfgzYan8OfYvWB76T
 tZVa+PvCOJTQmgNlwOSN0GHaj8vF3zuHqiiSmrAI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  9 Jun 2020 15:16:38 +0200 (CEST)
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
To: Christoph Hellwig <hch@lst.de>, Takashi Iwai <tiwai@suse.de>
References: <20200609054306.GA9606@lst.de> <s5hsgf4irzt.wl-tiwai@suse.de>
 <20200609084305.GA21671@lst.de> <s5hlfkwip1h.wl-tiwai@suse.de>
 <20200609091727.GA23814@lst.de> <s5hh7vkio0n.wl-tiwai@suse.de>
 <20200609113123.GA547@lst.de> <s5h3674ii49.wl-tiwai@suse.de>
 <20200609114059.GA1228@lst.de> <s5hzh9ch38h.wl-tiwai@suse.de>
 <20200609114955.GA2027@lst.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a20ab909-bb60-8d47-0da3-122a724aecbe@perex.cz>
Date: Tue, 9 Jun 2020 15:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609114955.GA2027@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, x86@kernel.org,
 David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
 "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>, tiwai@suse.com, hch@infradead.org,
 mingo@redhat.com, bp@alien8.de, Pavel Machek <pavel@ucw.cz>, hpa@zytor.com,
 tglx@linutronix.de
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

Dne 09. 06. 20 v 13:49 Christoph Hellwig napsal(a):
> On Tue, Jun 09, 2020 at 01:45:34PM +0200, Takashi Iwai wrote:
>> Yes, for the sound stuff, something below should make things working.
>> But it means that we'll lose the SG-buffer allocation and the
>> allocation of large buffers might fail on some machines.
> 
> We crossed lines there.  In general due to better memory compaction and
> CMA we have better chances to get larger contiguous allocations these
> days, so this might not be too much of an issue in practice.
> 

But turning off the SG DMA scheme seems like a step back. Would be possible to 
fix this kind of memory mapping?

					Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
