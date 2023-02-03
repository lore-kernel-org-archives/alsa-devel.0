Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB15BC636CC
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Feb 2023 07:16:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3247982C;
	Fri,  3 Feb 2023 08:15:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3247982C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675408601;
	bh=g2rKBy6ttBpin6VEjF2G8fzQJij2V1B+dvTvF2f5kRY=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qhM5pjaxMHRnNEkPejrBsBafI+rNFmuQ1SIBTwQc3dywBBzBfcIMBJYzGQunQEKNG
	 1Kv7nNxca77hDecKW65XcZgrNZyNrfcsLYp5dfOiooPjd0XN7CCAiKALQX1xRXVFOZ
	 JvgbGKRSN7IJfypb3ofp3aQ8twDbSFJfUOtVX6iM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E484F8045D;
	Fri,  3 Feb 2023 08:15:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13E4BF80423; Fri,  3 Feb 2023 08:15:47 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AABF0F80423
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2023 08:15:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AABF0F80423
Received: by verein.lst.de (Postfix, from userid 2407)
 id DB51E68C4E; Fri,  3 Feb 2023 08:15:42 +0100 (CET)
Date: Fri, 3 Feb 2023 08:15:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/22] usb: remove the dead USB_OHCI_SH option
Message-ID: <20230203071542.GC24833@lst.de>
References: <20230113062339.1909087-1-hch@lst.de>
 <20230113062339.1909087-3-hch@lst.de> <Y8EEbCP6PRMzWP5y@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8EEbCP6PRMzWP5y@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 dmaengine@vger.kernel.org, linux-rtc@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Jan 13, 2023 at 08:12:44AM +0100, Greg Kroah-Hartman wrote:
> Do you want all of these to go through a single tree, or can they go
> through the different driver subsystem trees?

Looks like the big removal isn't going in for this merge winodw,
so can you queue this patch up after all Greg?
