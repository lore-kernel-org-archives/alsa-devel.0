Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB2C43461
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:43:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B006D2176B
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BPBlyQXs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6hSYHs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B006D2176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEF4D177C;
	Mon,  7 Sep 2020 16:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEF4D177C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599489781;
	bh=vyE2X1zQKzP1YNOY504/+A2IyiOqZJITaebb9PZflls=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BPBlyQXs2uh8O80VZwOYfHJLugThU7H+WL07HliBaRCBXgO+bRnLPJi8+KsC65XTE
	 reZ8Gw/thZvNSJwT2XMZIbrkdpRJaXnc8bbRwArKKkB5+grTqo+nWPq8odpzbq164B
	 3/douCIycg7Z4QL5c4aMXRjkQ/xCjpfQN9kMnM0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37492F800D3;
	Mon,  7 Sep 2020 16:42:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D511BF80227; Mon,  7 Sep 2020 16:42:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11121F800D3
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 16:41:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11121F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="c6hSYHs2"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 02CC821481;
 Mon,  7 Sep 2020 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599489714;
 bh=vyE2X1zQKzP1YNOY504/+A2IyiOqZJITaebb9PZflls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c6hSYHs20N7asJxie1tfww4JQBkA2E6D0wkvqfpBxR6REkJBlWNdSnD0BGokzdT4l
 8FQxIwgIf1zsTzXYN8FnnKoBqJnlW6WjlPKXiD9ZcSdMdk6dD4ajO6FaxA1iJCtkaB
 l0gAZvE0zqwF3JbPujEb6oKOdpp5kkpqGisnALyw=
Date: Mon, 7 Sep 2020 16:42:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 01/10] USB: move snd_usb_pipe_sanity_check into the USB
 core
Message-ID: <20200907144209.GA3751762@kroah.com>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
 <20200902110115.1994491-2-gregkh@linuxfoundation.org>
 <s5hh7sg9rgq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh7sg9rgq.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 Jussi Laako <jussi@sonarnerd.net>, linux-kernel@vger.kernel.org,
 Alexander Tsoy <alexander@tsoy.me>, Jesus Ramos <jesus-ramos@live.com>,
 tiwai@suse.com, Alan Stern <stern@rowland.harvard.edu>,
 Nick Kossifidis <mickflemm@gmail.com>, Dmitry Panchenko <dmitry@d-systems.ee>,
 johan.hedberg@gmail.com, marcel@holtmann.org,
 Eli Billauer <eli.billauer@gmail.com>, stern@rowland.harvard.ed,
 dvyukov@google.com, himadrispandya@gmail.com, Chris Wulff <crwulff@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-bluetooth@vger.kernel.org,
 "Geoffrey D. Bennett" <g@b4.vu>, Emiliano Ingrassia <ingrassia@epigenesys.com>
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

On Wed, Sep 02, 2020 at 04:35:33PM +0200, Takashi Iwai wrote:
> On Wed, 02 Sep 2020 13:01:03 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > snd_usb_pipe_sanity_check() is a great function, so let's move it into
> > the USB core so that other parts of the kernel, including the USB core,
> > can call it.
> > 
> > Name it usb_pipe_type_check() to match the existing
> > usb_urb_ep_type_check() call, which now uses this function.
> > 
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Eli Billauer <eli.billauer@gmail.com>
> > Cc: Emiliano Ingrassia <ingrassia@epigenesys.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Alexander Tsoy <alexander@tsoy.me>
> > Cc: "Geoffrey D. Bennett" <g@b4.vu>
> > Cc: Jussi Laako <jussi@sonarnerd.net>
> > Cc: Nick Kossifidis <mickflemm@gmail.com>
> > Cc: Dmitry Panchenko <dmitry@d-systems.ee>
> > Cc: Chris Wulff <crwulff@gmail.com>
> > Cc: Jesus Ramos <jesus-ramos@live.com>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: alsa-devel@alsa-project.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for the reviews of all of these.

greg k-h
