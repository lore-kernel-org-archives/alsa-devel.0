Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5132EC46467
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Jan 2023 08:03:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A13B5188;
	Mon, 16 Jan 2023 09:02:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A13B5188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673856205;
	bh=37g2l5WJER5xmk4p1edgqBhlUL4ewvHF5ICHVX03mrU=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=iEpV3IhQKpzvWLY+mibhg/2tCEILkOYBcvlOUNaHZXMVJ3q6n6+PNn+zHntU77ZMY
	 aIxejGpYfDGKKNvxKMd1iQFnZtzp5jSf0YJ9d0paNElPAiOMRdx5m4TihcCdYnzAI7
	 QBMiP2xCHvVF3LqEeeni3fYjw0b7foWVgJKzwVJU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F76DF8055A;
	Mon, 16 Jan 2023 09:01:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42905F8024C; Mon, 16 Jan 2023 08:14:41 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A730F80083
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2023 08:14:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A730F80083
Received: by verein.lst.de (Postfix, from userid 2407)
 id 32DA668AFE; Mon, 16 Jan 2023 08:14:37 +0100 (CET)
Date: Mon, 16 Jan 2023 08:14:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: remove arch/sh
Message-ID: <20230116071436.GB15848@lst.de>
References: <20230113062339.1909087-1-hch@lst.de>
 <11e2e0a8-eabe-2d8c-d612-9cdd4bcc3648@physik.fu-berlin.de>
 <CAMuHMdUcnP6a9Ch5=_CMPq-io-YWK5pshkOT2nZmP1hvNcwBAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUcnP6a9Ch5=_CMPq-io-YWK5pshkOT2nZmP1hvNcwBAg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Mon, 16 Jan 2023 09:01:06 +0100
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
 Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Jan 13, 2023 at 09:26:23AM +0100, Geert Uytterhoeven wrote:
> Indeed.  The main issue is not the lack of people sending patches and
> fixes, but those patches never being applied by the maintainers.
> Perhaps someone is willing to stand up to take over maintainership?

The other problem is that it hasn't a DT conversion, and there are
lot of crufty platforms, and crufty hooks in various drivers and
core code.

It's been mentioned a few times that it might be time to go to a minimal
DT only port and then regrow what people are actually using, but for
that we need indiciations of what people are actually using.

And yes, it does need a proper maintainer, and some actual maintainer
option like cutting down unused machine support.
