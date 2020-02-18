Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5571C34049
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:43:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FFF24655
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lHj1Klg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FFF24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B70791672;
	Tue, 18 Feb 2020 18:43:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B70791672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582047836;
	bh=ULINXfseSagNOZvW6UiN82T7bMpUY/tI1ixigPcoiZw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lHj1Klg4L6mIJ3Eq9gIzqDpxm6AEr7+vooZ2Pl4V6hq7EpFIazDhVYD8IlONUbxPu
	 IJ1MauZlqDTQdssFcJMF0z9PLudBk+X3l6dG3M3goYPzQj8vhkqj/lOEGZ28B7Gbv1
	 1xfBTB3uJbzg7UiQYIpYKCCCdyRNGu1aUTsoTcwI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 386C5F80145;
	Tue, 18 Feb 2020 18:43:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11F37F80148; Tue, 18 Feb 2020 18:43:05 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 9312AF800C4
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 18:43:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9312AF800C4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74FC431B;
 Tue, 18 Feb 2020 09:43:00 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5F53F703;
 Tue, 18 Feb 2020 09:42:59 -0800 (PST)
Date: Tue, 18 Feb 2020 17:42:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] ASoC: cpcap: Implement set_tdm_slot for voice call support
Message-ID: <20200218174258.GK4232@sirena.org.uk>
References: <20200211181005.54008-1-tony@atomide.com>
 <ae2b7d9e-d05e-54ac-4f18-27cc8c4e81a0@ti.com>
 <20200212144620.GJ64767@atomide.com>
 <9a060430-5a3e-61e1-3d2c-f89819d9436f@ti.com>
 <20200217232325.GD35972@atomide.com>
 <8fc1dded-6d28-f5cd-f2f9-3a6810571119@ti.com>
 <20200218153211.GI35972@atomide.com>
 <20200218170628.r47xc3yydg6xx2yh@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="opg8F0UgoHELSI+9"
Content-Disposition: inline
In-Reply-To: <20200218170628.r47xc3yydg6xx2yh@earth.universe>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
 Merlijn Wajer <merlijn@wizzup.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Pavel Machek <pavel@ucw.cz>, "Arthur D ." <spinal.by@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
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


--opg8F0UgoHELSI+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 06:06:28PM +0100, Sebastian Reichel wrote:

> simple-graph-card is the current machine driver. We might have to
> introduce a Droid 4 specific driver instead. I used simple(-graph)-card
> instead of introducing a new driver, since the setup was simple enough
> without modem and bluetooth. The simple card was perfect to test the CPCAP
> codec driver. The TDM things might be complex enough to create
> a new machine driver (as I mentioned in the original patchset
> adding CPCAP codec support).

I tend to agree here, phones are generally one of the most complicated
classes of system for clocking and interconnects and the CODECs they use
often the most complex too so they're really stretching the generic
cards.  It'd be nice to be able to handle things with generic cards but
it's likely you'll run into issues that it'd be unreasonable to force
you to address for system enablement.  OTOH if you manage to get one of
the generic cards working well that'd be excellent!

--opg8F0UgoHELSI+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MIiEACgkQJNaLcl1U
h9D6Wgf+KODCNr6XeqdBCSDh3Rzl0aYLJntwETttXe5OX9SV2VAbUhheJKFsmhmK
UN8bsVZNmhwC8qIAXznxkbwp+9BPnM72lmIuniA8KqRiNHGdMwHUYRqw4g9c53qX
p2U5E9eZ35ilwDKYpb7SXn4r9pL02zAN7LqfcNs+v4CQ0LuGN/1xxsVKz7MlZ+t1
J8iizIybXeDxYCIWEHOSQn9+Hq0kdzqziJKLnApzilqRqtB51QWUK/vU1nPtQBfd
WPaGdaIa3qIh+R2PuhThKlJnQPaD/RRyM6TTApWjYrq8OfvfSvAC7f9r3P5yo3K3
lT8+OH3w5S8ZHUAE2G1tfHCaNIRiuw==
=tBdt
-----END PGP SIGNATURE-----

--opg8F0UgoHELSI+9--
