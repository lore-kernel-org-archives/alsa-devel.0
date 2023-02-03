Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BDCC05027
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Feb 2023 13:50:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B832E7F1;
	Fri,  3 Feb 2023 14:49:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B832E7F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675432234;
	bh=twmuq3q7Al8t0dG5XXte9ZDuYRAzK64pORvKsi5dZtQ=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YLUMGBHR2d1nWePtmKtzAJ6msOIC1TWU1xSrBXjlmvAlFJbQW8HR6b3PyRx1zdjyS
	 7ceSc/yu94DIu+acQjZdiPjcBXX0zwzWQHBX8NU/8xy+ralHwbTRGjcuq7UzHs0QTS
	 WnnLTvMwk34AcIwtDnH/Ytry0zgptzJxjP2NFyaI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E84BF80254;
	Fri,  3 Feb 2023 14:49:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E063F8032B; Fri,  3 Feb 2023 14:49:42 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0EF9F800E3
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2023 14:49:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0EF9F800E3
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.a=rsa-sha256 header.s=mail header.b=qsORpL0U
Received: from pendragon.ideasonboard.com (unknown [95.214.66.65])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2CCD6890;
 Fri,  3 Feb 2023 14:49:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1675432177;
 bh=twmuq3q7Al8t0dG5XXte9ZDuYRAzK64pORvKsi5dZtQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qsORpL0Uj9JY/PCmdctSdYjH8WIxXKO/aZb04ghWAK+rrFLld+EHf3mQOdDASKs2O
 E/t/SxPHoRRVXzLbXtGYYK630y/NTwjRZgUtemJ8Qt6dSjM/n5bAa5HzrAyPw+lu2K
 RhP1lSURZKaxzqZBrqJWn0+5vNmsfXyGPFKyTbb0=
Date: Fri, 3 Feb 2023 15:49:35 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/22] gpu/drm: remove the shmobile drm driver
Message-ID: <Y90Q73ykVEHRNII4@pendragon.ideasonboard.com>
References: <20230113062339.1909087-1-hch@lst.de>
 <20230113062339.1909087-2-hch@lst.de>
 <Y8EMZ0GI5rtor9xr@pendragon.ideasonboard.com>
 <20230203071506.GB24833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203071506.GB24833@lst.de>
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
 linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-gpio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org, linux-rtc@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Feb 03, 2023 at 08:15:06AM +0100, Christoph Hellwig wrote:
> So given that the big series doesn't go in, can we get this removal
> picked up through the drm tree?

Geert has a board with an ARM-based SoC compatible with this driver, and
he expressed interest in taking over maintainership. Geert, could you
share your plans ? Should the shmobile_drm driver be dropped now, or
will you revive it in a relatively near future ?

-- 
Regards,

Laurent Pinchart
