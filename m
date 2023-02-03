Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D504C636CC
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Feb 2023 07:26:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8DD9820;
	Fri,  3 Feb 2023 08:25:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8DD9820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675409175;
	bh=w/73Uc/n5KxsufzX5CddSnsJWhi8Tl5rHcWOUj980gE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=FUZr/arc1nVAunT0gwMqipxm1i8IM5TNPfLLWIRxb6X0wtazjKTUbMMDr6RmZeb3r
	 J4w88cueWzC84GiaJdjSK76dbbObi099yhtzeV2H0tQP6/9hE/wSkyX19Jby9YZtz1
	 MATmn+dECRu4K1oiPFjtv3CE2wxbfOubAgRF+Lyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 163A3F80254;
	Fri,  3 Feb 2023 08:25:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A19CCF8032B; Fri,  3 Feb 2023 08:25:23 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02C39F800E3
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2023 08:25:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02C39F800E3
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=KvD8eTpj
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 479EEB82913;
 Fri,  3 Feb 2023 07:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9EAC433D2;
 Fri,  3 Feb 2023 07:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1675409118;
 bh=w/73Uc/n5KxsufzX5CddSnsJWhi8Tl5rHcWOUj980gE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KvD8eTpjLOtWB+UEaur78gdbkDk2uNg4iTyG7EduGBBQeFYYfDMJR0zI5M46iGXgI
 B/g60xlZj15BQnrefnVhdWcwV0eYwBhVI1fWaHKJRFJ022Eb8m0gihPo6B9goL/ROM
 S4BKuWCyK0zSKt6MO3m0b0jgs8LUO3Xke14ThSpk=
Date: Fri, 3 Feb 2023 08:25:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/22] usb: remove the dead USB_OHCI_SH option
Message-ID: <Y9y221RalpLWJE0S@kroah.com>
References: <20230113062339.1909087-1-hch@lst.de>
 <20230113062339.1909087-3-hch@lst.de> <Y8EEbCP6PRMzWP5y@kroah.com>
 <20230203071542.GC24833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203071542.GC24833@lst.de>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org,
 linux-rtc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Feb 03, 2023 at 08:15:42AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 13, 2023 at 08:12:44AM +0100, Greg Kroah-Hartman wrote:
> > Do you want all of these to go through a single tree, or can they go
> > through the different driver subsystem trees?
> 
> Looks like the big removal isn't going in for this merge winodw,
> so can you queue this patch up after all Greg?

Sure, I'll go apply it right now, thanks.

greg k-h
