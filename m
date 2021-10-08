Return-Path: <SRS0=2Zex=O4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D03C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 11:54:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798C360F6D
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 11:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 798C360F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB0E5167D;
	Fri,  8 Oct 2021 13:53:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB0E5167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633694054;
	bh=jbttW1AsV1MohOn3aGFs+44TbiWsPDTuDpIzAB39TiQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iwwI16QhZw8TbvFN+L6w6z9Rf2XgjH/Z4mSCfVnTTUjoCkiLaR1fUIjjQa8dZ9Gtw
	 a1pmGzvfeuWwCdDSoBroXBgXTeayzBJWD4UrNj7Gd9uyoBvuJElJQiIGkRso+DYoAW
	 +Wd0saAJgsjVlfmleU0UhP6arnjxmmh0gyw8tzKY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A208F80240;
	Fri,  8 Oct 2021 13:53:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4AEEDF80246; Fri,  8 Oct 2021 13:53:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0C29F80240
 for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2021 13:53:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0C29F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="GR2QdsjV"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="2l7vV6Jw"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C2B5C219B2;
 Fri,  8 Oct 2021 11:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633693995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARppKVzpuPeNHqxCswVOFgUbFO18bm3TDyH1EtjhH2Y=;
 b=GR2QdsjVtFCZKUc4xc5yeZr/nQA6mhlBW6T2w+UYP869BaDTM01lmkex8mtLcrSHW4RHLm
 YPZNWANlazii+mWHxB+we9i9UEU2l9tzxtQxjdHa/PYC1c+t9Ye2DuKojsJ65miiB0G+bO
 ooqWG5CIWeOE6fDT9FHvV/EeGYZp+38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633693995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARppKVzpuPeNHqxCswVOFgUbFO18bm3TDyH1EtjhH2Y=;
 b=2l7vV6JwoBk/GFly1VxlIrpKeXOTF2ZbH0Ptu22haSDVRyXnYeOQ2c2xgSbo1LEXMjsL3t
 OIXppmKoAkyZIIAg==
Received: from alsa1.suse.de (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 92587A3B88;
 Fri,  8 Oct 2021 11:53:15 +0000 (UTC)
Date: Fri, 08 Oct 2021 13:53:15 +0200
Message-ID: <s5ho87z7mxg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
In-Reply-To: <CAK8P3a2DUvQSkUaDzwiRjg9d3w7pXxrw8q_oSawJKY7kEw1qtg@mail.gmail.com>
References: <20191211212025.1981822-1-arnd@arndb.de>
 <20191211212025.1981822-9-arnd@arndb.de>
 <29QBMJU8DE71E.2YZSH8IHT5HMH@mforney.org>
 <s5hpmsh9kdx.wl-tiwai@suse.de>
 <CAK8P3a0K3XtjiszC3XWgG0L8+AgO+xUGr_KEAnb9a5GmyecoUQ@mail.gmail.com>
 <s5hee8x9f92.wl-tiwai@suse.de>
 <CAK8P3a0pSZxqfk-bn+idrDYDwANSfiP9L6U1O5jLQvK+3vwyVQ@mail.gmail.com>
 <s5hy27497eo.wl-tiwai@suse.de>
 <20211007160634.GB7074@brightrain.aerifal.cx>
 <s5hr1cw95ar.wl-tiwai@suse.de>
 <20211007165158.GC7074@brightrain.aerifal.cx>
 <s5h5yu79aab.wl-tiwai@suse.de>
 <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <s5hv9277oux.wl-tiwai@suse.de>
 <CAK8P3a2DUvQSkUaDzwiRjg9d3w7pXxrw8q_oSawJKY7kEw1qtg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Rich Felker <dalias@libc.org>, Baolin Wang <baolin.wang@linaro.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 musl@lists.openwall.com, Takashi Iwai <tiwai@suse.com>,
 Michael Forney <mforney@mforney.org>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>
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

On Fri, 08 Oct 2021 13:45:45 +0200,
Arnd Bergmann wrote:
> 
> On Fri, Oct 8, 2021 at 1:11 PM Takashi Iwai <tiwai@suse.de> wrote:
> > On Fri, 08 Oct 2021 11:24:39 +0200, Arnd Bergmann wrote:
> 
> > >
> > > I've tried to understand this part of musl's convert_ioctl_struct(), but I just
> > > can't figure out whether it does the conversion based the on the layout that
> > > is currently used in the kernel, or based on the layout we should have been
> > > using, and would use with the above fix. Rich, can you help me here?
> >
> > So, at this moment, I'm not sure whether we should correct the struct
> > at all.  This will lead to yet more breakage, and basically the struct
> > itself *works* -- the only bug is in 32bit compat handling in the
> > kernel (again).
> 
> I'm still unsure if the musl fallback code is correct or not.

We need to verify the current behavior in anyway...

> > The below is a revised kernel patch (again untested), just correcting
> > the behavior of 32bit compat mode.  32bit apps on 32bit kernel work
> > fine as is, as well as 64bit apps on 64bit kernel.
> 
> Right, this should cover all cases of the ioctl itself misbehaving.
> In addition, we still need to disallow the mmap() interface on compat
> kernels then. Strictly speaking, we could allow the snd_pcm_mmap_status
> but not snd_pcm_mmap_control to be mapped, but I'm not sure if
> that's better than disallowing both.

IIRC, the compat mmap is already disallowed even for the
SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW (in pcm_control_mmap_allowed()), so
no need to change around that.


thanks,

Takashi
