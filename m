Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DDBC30653
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:00:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0A3BE7D;
	Thu,  4 Jul 2024 11:00:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0A3BE7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720083619;
	bh=WbXzrLYbelpWYb+vWRColZJQkfGtkoJg8hCor2oynf8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vW+2ascOfaY0puY69Xhqtk0EUlXLSScEOLe8k/3fCKY45Tz2mQ+Mu1Gj8PW/vu00o
	 gpsP0wOgiDUEs5iQ3zFj62Zjb8Om82UitLRIRxDNQ7ozU6i9AHxv5aJPqKczY7/Lrm
	 fLZIH8VmfWzgJEUwRZJfC53eeP5CMwe/jCgHdxSA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DF49F8061A; Thu,  4 Jul 2024 10:59:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CCC0F8061F;
	Thu,  4 Jul 2024 10:59:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43B19F80508; Thu,  4 Jul 2024 10:56:00 +0200 (CEST)
Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 121D3F8014C
	for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2024 10:55:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 121D3F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=xwax.org header.i=@xwax.org header.a=rsa-sha256
 header.s=swing header.b=HYF35//5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
	s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=Mg5N1u3NQwC0syyKbSSGXV2bOG4ZP1SInZ/6+jwqoRE=; b=HYF35
	//55ipLifYlR5Cr36CmvuBr6m7/FGtH91JJ0Carn1SD9pDdd8ZiVjE/mhKiXehddjTMkN/ol7Z1ZG
	ADvidtbirlngCNUJaGnOdypeWsxqfaJ8qbSXUpFRWPhQLZTVVE3hc8tzibF0ftLbk0+9P9Tam3EH8
	o4MWgWbF3RXU=;
Received: from cpc93786-hari17-2-0-cust786.20-2.cable.virginm.net
 ([82.36.99.19] helo=tamla)
	by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1 (FreeBSD))
	(envelope-from <mark@xwax.org>)
	id 1sPIFo-000000007H5-3d36;
	Thu, 04 Jul 2024 09:55:48 +0100
Received: from localhost (tamla.localdomain [local])
	by tamla.localdomain (OpenSMTPD) with ESMTPA id 715619dd;
	Thu, 4 Jul 2024 09:55:33 +0100 (BST)
Date: Thu, 4 Jul 2024 09:55:33 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: Asahi Lina <lina@asahilina.net>
cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
    Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: Handling complex matrix mixers in ALSA
In-Reply-To: <48beda37-1795-4d48-987d-1e2582cb3a18@asahilina.net>
Message-ID: <5e0a07da-c5d2-1209-0f26-d164f25a31f1@xwax.org>
References: <48beda37-1795-4d48-987d-1e2582cb3a18@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID-Hash: WJRA5S2HSG6HFYS7FLJKI7WZJKH4VXDN
X-Message-ID-Hash: WJRA5S2HSG6HFYS7FLJKI7WZJKH4VXDN
X-MailFrom: mark@xwax.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WJRA5S2HSG6HFYS7FLJKI7WZJKH4VXDN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 1 Jul 2024, Asahi Lina wrote:

[...]
> The problem is that the device has a 66x34 matrix mixer, with up to 2048
> cross points enabled at once. Exposing each cross point as an ALSA mixer
> control (similar to how mixer_scarlett2.c does it) would mean 2244
> controls just for the mixer... which seems like a bit too much.
> 
> On top of that there is also VU meter feedback for all the
> inputs/outputs, as well as general fader controls for each output and
> global output configs and status. I'm not sure about the VU meters, but
> everything else sounds like it would map fine to normal mixer controls.
> 
> Is there some recommended way to expose this kind of matrix mixer
> interface to userspace?

I don't know if it's recommended practice, but the echo3g driver may be a 
prior art as it has a working matrix mixer for the Layla, and the 
corresponding echomixer in alsa-tools.

> I think for something like this you pretty much have to rely on 
> device-specific tools to make the UX manageable

For a full UX, perhaps. But the concept of a matrix mixer itself is 
general enough.

Perhaps there could be a UI tool which is self contained with one purpose, 
to control a 'standard' matrix mixer. It could be invoked alongside 
alsamixer or other mixer tool, and multiple times if there are multiple 
matrix mixers on a piece of hardware.

-- 
Mark
