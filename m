Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454F3C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 20:39:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9652D16DB;
	Mon,  9 May 2022 22:38:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9652D16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652128783;
	bh=5TjOLfZUDyL7nRyao1L/iBSRk9RJFTU+SSSLF19iQ50=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4PNYKwezH0lp5B2cViCUv0GsvrceTSyn0RNOW1TNHRPOvOBx6iqfVTdjwmi/6/Ux
	 WGEB+a/5rrwve3r2ndakB63/IpofqfH8goqxjvO4soyR0aH0ltrGMEuS3Mt9b3FcTn
	 Cq8W2ajAetYOGD+MN7KCPCBlSj+tg43GKmlpWhSA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24027F80237;
	Mon,  9 May 2022 22:38:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF153F8025D; Mon,  9 May 2022 22:38:51 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0671F8011C
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 22:38:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0671F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="MSu8yd2G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=sVDi3ZkthDWhU24EgtzN+wCLFG3z5NXVqbnb7DL7KRg=; b=MSu8yd2G1QdsEetiBeGz/X3MKM
 95MHBpcDUIVbe77heF3/WbEV+39tM/Gth0iTVQ2YXNQSdpZ+hLuwy5Yvfg7qNvoqE/FD0fnND5y1D
 Nd0OqoHaem/jn+UyniR/gmp+kRo7GS5JczmtEIpjDS6/1+W944dyqpLsL0ypUb1o7ACx8eItUzN7T
 nv6i0CJCp4GhlzodxwzbvAzpMNrIjGnUWW/ZesZkCeSyuC64rOwnmNFd+ct2DEfYGIZFuYk+NgrVq
 6++7eT9mQ3pukrjrCDRBhq/MXjqgdfKATRraJkN+m9zX4Eww8OKfegheqNNEkVj16ohJN9pddjl9w
 Cx/4S4MQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1noA9F-00GBdr-0y; Mon, 09 May 2022 20:38:29 +0000
Date: Mon, 9 May 2022 13:38:28 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v6 0/4] Let userspace know when snd-hda-intel needs i915
Message-ID: <Ynl7xGy+a9MYjXi1@bombadil.infradead.org>
References: <cover.1652113087.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652113087.git.mchehab@kernel.org>
Cc: mauro.chehab@linux.intel.com, Richard Weinberger <richard@nod.at>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, intel-gfx@lists.freedesktop.org,
 Lucas De Marchi <lucas.demarchi@intel.com>, Takashi Iwai <tiwai@suse.com>,
 dri-devel@lists.freedesktop.org, Vignesh Raghavendra <vigneshr@ti.com>,
 David Airlie <airlied@linux.ie>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-modules@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
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

On Mon, May 09, 2022 at 06:23:35PM +0200, Mauro Carvalho Chehab wrote:
> Currently, kernel/module annotates module dependencies when
> request_symbol is used, but it doesn't cover more complex inter-driver
> dependencies that are subsystem and/or driver-specific.
> 

At this pount v5.18-rc7 is out and so it is too late to soak this
in for the proper level of testing I'd like to see for modules-next.
So I can review this after the next merge window. I'd want to beat
the hell out of this and if possible I'd like to see if we can have
some test coverage for the intended goal and how to break it.

  Luis
