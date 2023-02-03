Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB33C61DA4
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Feb 2023 07:16:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35BE874C;
	Fri,  3 Feb 2023 08:15:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35BE874C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675408564;
	bh=AF2dgrN02VYoSqDLZ6wwwx4xVDbukLvJC7eC9RwXOUg=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=LuTw4V28GV9BNyphanqc3yuQ54o47M4OdY2uLEAl8ZRwyhEUQK67FQP4qU6FBlw7D
	 m0qxAv6nlF1vZn58sWvUfniy5riEtt4wejIZAxgStquNfyAdIyyCVEhdshZhNB/keW
	 7/EOVB0Vhyabeq7SsXLkI1aydY6u1JwfYzAoJ1qc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFDE8F80254;
	Fri,  3 Feb 2023 08:15:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE521F8032B; Fri,  3 Feb 2023 08:15:11 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0998F80169
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2023 08:15:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0998F80169
Received: by verein.lst.de (Postfix, from userid 2407)
 id AFA2168D05; Fri,  3 Feb 2023 08:15:07 +0100 (CET)
Date: Fri, 3 Feb 2023 08:15:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/22] gpu/drm: remove the shmobile drm driver
Message-ID: <20230203071506.GB24833@lst.de>
References: <20230113062339.1909087-1-hch@lst.de>
 <20230113062339.1909087-2-hch@lst.de>
 <Y8EMZ0GI5rtor9xr@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8EMZ0GI5rtor9xr@pendragon.ideasonboard.com>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, linux-rtc@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

So given that the big series doesn't go in, can we get this removal
picked up through the drm tree?
