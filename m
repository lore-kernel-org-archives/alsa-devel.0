Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA92C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 13:00:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B497664E60
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B497664E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B13B1668;
	Tue, 23 Feb 2021 14:00:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B13B1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614085253;
	bh=tXfPV7WCVvB69kexHWizre2X6U4tyokVz03NkZnFYVk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e2A0iW05U6+o3hwOMjxPui++EKYCda5HkPZXWU9Xt+Dxkd6l904usBaN+c7MECvAV
	 1lHi1RZCxSLJtGzv3NjlnW+cb/0imgTo8mMY4fEZzK4Zc/dKXKLYT8Ao8wnKJj66G/
	 sibT7B2FnqnYXNQHO8fS4opx97k84x+0iNj1iX5o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63A63F80169;
	Tue, 23 Feb 2021 13:59:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2C0CF8016A; Tue, 23 Feb 2021 13:59:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 821D0F80129
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 13:59:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 821D0F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="ZqH+HaXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614085186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nsb6410KD77Etu5NLRJ2iY9H5YUf7juaiTO6VgDZxRs=;
 b=ZqH+HaXugY8Zo1X+GIZZCnGN/6VZUacXma4sHtgzQMRDB0cQ7Q5hOK8Jhm/dMimzJzA9KX
 OiwoNQU7amB/BFQ4MTrkN9FL8KgHVAdxVIpGVZD/cVpJgNGbSqfWSQLRY1fH+cWWE7HMjK
 Cs3FZcIMMKTUxEM+7qQDPvk7uhqF5eY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-1IjLfRyIMkCS1hihsXVo6g-1; Tue, 23 Feb 2021 07:59:44 -0500
X-MC-Unique: 1IjLfRyIMkCS1hihsXVo6g-1
Received: by mail-wr1-f71.google.com with SMTP id v3so824844wro.21
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 04:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nsb6410KD77Etu5NLRJ2iY9H5YUf7juaiTO6VgDZxRs=;
 b=s9byt/gVPcUQVjOTvhEky48gtbUkQvutaFvtrFpNpS6PWiwkrUiXzGXXLhg7yeRhM4
 d4QVbluVfRAyIRp2TNQgapti9RbFKXhHfQEJ41LSjurGR6BHzf0Vot1DUGrdxZi870T/
 eCQ0+2y2zkNdUBye+22N+9zPNv1ruQ3qNam/EnTIlkG+7AvKbUoNbkAvhMQYHDLdXLhq
 nfD6TBqFJa64QE+5uxZCtrj0FGPIka0tB4okStahz0URRWbtW0OENddp2dC1epjTetvA
 XzyMRizt3a6PBSTD4cL7CBGALReMx6hObgVTzu7G1EFzV5CRYpV5WZYFdZ9ajmLTVKS2
 niyA==
X-Gm-Message-State: AOAM532zm9If6Y55VqHvR+9P5s5D+fQ+4UHZnfOWpke2weEA9TTioxWD
 nGKCu620ZRuhUbxg5MFm8eGnP7E0LAqOWCMX4RO70sZYtShJNPtEVbFwWitoZK0GckKeE/SX/rV
 VSbags2Xnf9eSIPYsZYOrmZA=
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr23167721wmk.27.1614085183403; 
 Tue, 23 Feb 2021 04:59:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziaQQBGEm0zpZoJ3pmPnb/Dw/YUrycTxx3mxxJDNxlW3WbQMuk3Z4T9hEc58x5SpZ/z8vOYQ==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr23167709wmk.27.1614085183240; 
 Tue, 23 Feb 2021 04:59:43 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id n66sm2527905wmn.25.2021.02.23.04.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:59:42 -0800 (PST)
Date: Tue, 23 Feb 2021 07:59:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: [virtio-dev] Re: [PATCH v5 0/9] ALSA: add virtio sound driver
Message-ID: <20210223075813-mutt-send-email-mst@kernel.org>
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210223070839-mutt-send-email-mst@kernel.org>
 <bce13fa2-3ee5-0c6c-5761-17f0389c2d7b@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <bce13fa2-3ee5-0c6c-5761-17f0389c2d7b@opensynergy.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, virtualization@lists.linux-foundation.org
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

On Tue, Feb 23, 2021 at 01:33:57PM +0100, Anton Yakovlev wrote:
> On 23.02.2021 13:09, Michael S. Tsirkin wrote:
> > On Mon, Feb 22, 2021 at 04:34:35PM +0100, Anton Yakovlev wrote:
> > > This series implements a driver part of the virtio sound device
> > > specification v8 [1].
> > > 
> > > The driver supports PCM playback and capture substreams, jack and
> > > channel map controls. A message-based transport is used to write/read
> > > PCM frames to/from a device.
> > > 
> > > As a device part was used OpenSynergy proprietary implementation.
> > > 
> > > v5 changes:
> > >   - Fixed another bunch of sparse warnings
> > >     (replaced virtio_cread() -> virtio_cread_le()), no functional changes.
> > > (Sorry, I didn't know how to run sparse locally, now everything should be fixed)
> > > 
> > > [1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html
> > 
> > 
> > In the future please number patches from 1, not from 2.
> > thanks!
> 
> But they are numbered automatically by git. Patch #1 is for virtio_ids.h

Weird somehow I was missing patch #1. Applied now, thanks!

> 
> > > 
> > > Anton Yakovlev (9):
> > >    uapi: virtio_ids: add a sound device type ID from OASIS spec
> > >    ALSA: virtio: add virtio sound driver
> > >    ALSA: virtio: handling control messages
> > >    ALSA: virtio: build PCM devices and substream hardware descriptors
> > >    ALSA: virtio: handling control and I/O messages for the PCM device
> > >    ALSA: virtio: PCM substream operators
> > >    ALSA: virtio: introduce jack support
> > >    ALSA: virtio: introduce PCM channel map support
> > >    ALSA: virtio: introduce device suspend/resume support
> > > 
> > >   MAINTAINERS                     |   9 +
> > >   include/uapi/linux/virtio_ids.h |   1 +
> > >   include/uapi/linux/virtio_snd.h | 334 +++++++++++++++++++++
> > >   sound/Kconfig                   |   2 +
> > >   sound/Makefile                  |   3 +-
> > >   sound/virtio/Kconfig            |  10 +
> > >   sound/virtio/Makefile           |  13 +
> > >   sound/virtio/virtio_card.c      | 462 +++++++++++++++++++++++++++++
> > >   sound/virtio/virtio_card.h      | 113 ++++++++
> > >   sound/virtio/virtio_chmap.c     | 219 ++++++++++++++
> > >   sound/virtio/virtio_ctl_msg.c   | 310 ++++++++++++++++++++
> > >   sound/virtio/virtio_ctl_msg.h   |  78 +++++
> > >   sound/virtio/virtio_jack.c      | 233 +++++++++++++++
> > >   sound/virtio/virtio_pcm.c       | 498 ++++++++++++++++++++++++++++++++
> > >   sound/virtio/virtio_pcm.h       | 120 ++++++++
> > >   sound/virtio/virtio_pcm_msg.c   | 392 +++++++++++++++++++++++++
> > >   sound/virtio/virtio_pcm_ops.c   | 491 +++++++++++++++++++++++++++++++
> > >   17 files changed, 3287 insertions(+), 1 deletion(-)
> > >   create mode 100644 include/uapi/linux/virtio_snd.h
> > >   create mode 100644 sound/virtio/Kconfig
> > >   create mode 100644 sound/virtio/Makefile
> > >   create mode 100644 sound/virtio/virtio_card.c
> > >   create mode 100644 sound/virtio/virtio_card.h
> > >   create mode 100644 sound/virtio/virtio_chmap.c
> > >   create mode 100644 sound/virtio/virtio_ctl_msg.c
> > >   create mode 100644 sound/virtio/virtio_ctl_msg.h
> > >   create mode 100644 sound/virtio/virtio_jack.c
> > >   create mode 100644 sound/virtio/virtio_pcm.c
> > >   create mode 100644 sound/virtio/virtio_pcm.h
> > >   create mode 100644 sound/virtio/virtio_pcm_msg.c
> > >   create mode 100644 sound/virtio/virtio_pcm_ops.c
> > > 
> > > --
> > > 2.30.0
> > > 
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 
> > 
> 
> -- 
> Anton Yakovlev
> Senior Software Engineer
> 
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin

