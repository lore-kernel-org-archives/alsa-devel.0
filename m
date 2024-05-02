Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D4AC4345F
	for <alsa-devel@archiver.kernel.org>; Thu,  2 May 2024 09:01:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8AE30E7D;
	Thu,  2 May 2024 11:00:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8AE30E7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714640466;
	bh=F5Z3CegIuDz1KYzRsgzmDjZXhBZBJKlckcG9UPbVRbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tBcjGaqyb8qmHoNyPkYbMO6Q4YPsplMYG+ufHa61NUZLTAMdvFaZBFd9v19FCQZ45
	 uiI+xPb98oSZLeTWQ6WBG7lJyOO5Wh1f9fpoEz2l/iRNTajiec+wwJU6YA3fk+i0Rp
	 NKkb26ej/pA7p1SuNPw7HUHcNv/fS22jhtmfnBzs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21464F8025D; Thu,  2 May 2024 11:00:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ECAD1F8057D;
	Thu,  2 May 2024 11:00:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B810F80266; Thu,  2 May 2024 11:00:27 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 46FADF800E2
	for <alsa-devel@alsa-project.org>; Thu,  2 May 2024 11:00:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46FADF800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DLBAfjSh
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5349C61A0D;
	Thu,  2 May 2024 09:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645ECC113CC;
	Thu,  2 May 2024 09:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714640406;
	bh=F5Z3CegIuDz1KYzRsgzmDjZXhBZBJKlckcG9UPbVRbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLBAfjShKr935qgIqx23bWiHXrn7CRnEUkn38ngre0YYP1eJiKj4vTQh/m1B/a8Ms
	 wbTE3rPt4rsZAk69+U5zgpWlqXdpgnJtWpC3+DUZK5shSYpaFSfrgmGys00QN9axic
	 jLmhK6fkJbRaU1NnP5sghmMr3paAiADobp1W6l/iCV30A96r94qCfGDUsrIq0b79x6
	 P7lU4qdM+qiWFUfEeEvlOuwCB4Wb68fO+sXeqiDrp/dcO5nG+mk9fxUG7XjtW1eN2S
	 OUyKULESIuqRiPvyV8LOA3bqHE4x+BCRfsNgCiJnKRbcnguykfNdTAD44sAJ0chiOa
	 GeVN/aj3vjbqA==
Date: Thu, 2 May 2024 09:59:56 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, Sebastian Fricke
 <sebastian.fricke@collabora.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
 m.szyprowski@samsung.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <20240502095956.0a8c5b26@sal.lan>
In-Reply-To: <87sez0k661.wl-tiwai@suse.de>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
	<20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
	<ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
	<20240430172752.20ffcd56@sal.lan>
	<ZjGhPz-bokg6ZbDJ@finisterre.sirena.org.uk>
	<87sez0k661.wl-tiwai@suse.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: ENYHHMJANNHBZCBB4K3SIX4F5YUL2XVD
X-Message-ID-Hash: ENYHHMJANNHBZCBB4K3SIX4F5YUL2XVD
X-MailFrom: mchehab@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ENYHHMJANNHBZCBB4K3SIX4F5YUL2XVD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Em Thu, 02 May 2024 09:46:14 +0200
Takashi Iwai <tiwai@suse.de> escreveu:

> On Wed, 01 May 2024 03:56:15 +0200,
> Mark Brown wrote:
> > 
> > On Tue, Apr 30, 2024 at 05:27:52PM +0100, Mauro Carvalho Chehab wrote:  
> > > Mark Brown <broonie@kernel.org> escreveu:  
> > > > On Tue, Apr 30, 2024 at 10:21:12AM +0200, Sebastian Fricke wrote:  
> >   
> > > > The discussion around this originally was that all the audio APIs are
> > > > very much centered around real time operations rather than completely  
> >   
> > > The media subsystem is also centered around real time. Without real
> > > time, you can't have a decent video conference system. Having
> > > mem2mem transfers actually help reducing real time delays, as it 
> > > avoids extra latency due to CPU congestion and/or data transfers
> > > from/to userspace.  
> > 
> > Real time means strongly tied to wall clock times rather than fast - the
> > issue was that all the ALSA APIs are based around pushing data through
> > the system based on a clock.
> >   
> > > > That doesn't sound like an immediate solution to maintainer overload
> > > > issues...  if something like this is going to happen the DRM solution
> > > > does seem more general but I'm not sure the amount of stop energy is
> > > > proportionate.  
> >   
> > > I don't think maintainer overload is the issue here. The main
> > > point is to avoid a fork at the audio uAPI, plus the burden
> > > of re-inventing the wheel with new codes for audio formats,
> > > new documentation for them, etc.  
> > 
> > I thought that discussion had been had already at one of the earlier
> > versions?  TBH I've not really been paying attention to this since the
> > very early versions where I raised some similar "why is this in media"
> > points and I thought everyone had decided that this did actually make
> > sense.  
> 
> Yeah, it was discussed in v1 and v2 threads, e.g.
>   https://patchwork.kernel.org/project/linux-media/cover/1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com/#25485573
> 
> My argument at that time was how the operation would be, and the point
> was that it'd be a "batch-like" operation via M2M without any timing
> control.  It'd be a very special usage for for ALSA, and if any, it'd
> be hwdep -- that is a very hardware-specific API implementation -- or
> try compress-offload API, which looks dubious.
> 
> OTOH, the argument was that there is already a framework for M2M in
> media API and that also fits for the batch-like operation, too.  So
> was the thread evolved until now.

M2M transfers are not a hardware-specific API, and such kind of
transfers is not new either. Old media devices like bttv have
internally a way to do PCI2PCI transfers, allowing media streams
to be transferred directly without utilizing CPU. The media driver
supports it for video, as this made a huge difference of performance
back then.

On embedded world, this is a pretty common scenario: different media
IP blocks can communicate with each other directly via memory. This
can happen for video capture, video display and audio.

With M2M, most of the control is offloaded to the hardware.

There are still time control associated with it, as audio and video
needs to be in sync. This is done by controlling the buffers size 
and could be fine-tuned by checking when the buffer transfer is done.

On media, M2M buffer transfers are started via VIDIOC_QBUF,
which is a request to do a frame transfer. A similar ioctl
(VIDIOC_DQBUF) is used to monitor when the hardware finishes
transfering the buffer. On other words, the CPU is responsible
for time control.

On other words, this is still real time. The main difference
from a "sync" transfer is that the CPU doesn't need to copy data
from/to different devices, as such operation is offloaded to the
hardware.

Regards,
Mauro
