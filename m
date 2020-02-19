Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40350C34047
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:05:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F7324673
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LllC+V/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F7324673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B40A1687;
	Wed, 19 Feb 2020 17:04:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B40A1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582128349;
	bh=JgJ/vrMOiRMDUW3ju7uoxCx5v6yF1jGNqosrYOSOeIw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LllC+V/eG7Et1LwyHeeAcAq4klCteCysiwKYYL8zYfhBL6GCfuTAGPl8l4eN3pr/u
	 rY0xASIyXcHnC4sLRwtKIqSxT3ZrWrzCcsLpCPYVNfeslUseTLlUyYvrFzFonk79qC
	 U6+UK6uKoqXWwJ47pA2/OWsIIx3CL8kWP0RmU2mQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D1DEF8025F;
	Wed, 19 Feb 2020 17:04:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31778F80273; Wed, 19 Feb 2020 17:04:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 77C59F80114
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 17:04:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77C59F80114
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F4B71FB;
 Wed, 19 Feb 2020 08:04:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D7A3F6CF;
 Wed, 19 Feb 2020 08:04:51 -0800 (PST)
Date: Wed, 19 Feb 2020 16:04:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: simple-card: switch to yaml base
 Documentation
Message-ID: <20200219160450.GE4488@sirena.org.uk>
References: <87blq1zr8n.wl-kuninori.morimoto.gx@renesas.com>
 <20200219155808.GA25095@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Content-Disposition: inline
In-Reply-To: <20200219155808.GA25095@bogus>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
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


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 09:58:08AM -0600, Rob Herring wrote:
> On Fri, Feb 14, 2020 at 02:13:05PM +0900, Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >=20
> > This patch switches from .txt base to .yaml base Document.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > +  dai-tdm-slot-num:
> > +    description: see tdm-slot.txt.
> > +    $ref: /schemas/types.yaml#/definitions/uint32

> Is there a max?

No.

> > +    description: see tdm-slot.txt.
> > +    $ref: /schemas/types.yaml#/definitions/uint32

> max is 32 or something much less than 2^32?

It'll be much less than 2^32 but could potentially be fairly large in a
big telephony system.

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5NXKEACgkQJNaLcl1U
h9DkIgf+PId+cf44wocBGhUhG5MM+TGNp2SLlvXDPC9TiWLqmdmtPLAYKVQQehxq
v5dH0QMF9b3zI4zcMLX/LjT6UJGptws3jGlVQWTpxdl/4evXXgmYIJ/6F9PFClfl
4qw6j/8DgmnFT4/Z3a/H4bXOjdooxbsU8YQ45xqHjwqlEhIkwWuWVvUCiVUt3wR1
ds7xrNP2XUvckeC90M/OVmv9TDVzjkDEp5MrWRCUIK+ptKWtMDJNKlv5uF+Sh/FU
ICjgBBiL82lrk9eRccdIVjjeXDFOwQMfx4KXW1IwfrbW+ZvAL9gP/UCQo5+pqVnq
fHt1FURjfodweBdVzejev4FDZCWbAA==
=MTvU
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
