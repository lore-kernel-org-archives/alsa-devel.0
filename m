Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED54C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 16:55:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C726A61177
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 16:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C726A61177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F35216FD;
	Fri, 29 Oct 2021 18:54:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F35216FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635526537;
	bh=xJMcJlZ5X3eXJxE7o9KfSrs2+XgcENRmMvxeR2ZxKWQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FOZgxPsnTnUPfgkTuxkg6zVg4kJEe7dQ09/wYuCyyRRXpiTXPEJ55XR7FiNL9VUIu
	 KyaYQ+zkB6FJrRqADkM611Ee2tVwrkLp2JDvYx+SQ/+fc09o+peog+ruCayBE4bp7O
	 P55khJ5OIb4ep1Yr51tOWJyGm/JynfeeYmr11TmQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CF3AF8010A;
	Fri, 29 Oct 2021 18:54:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EED3EF8025A; Fri, 29 Oct 2021 18:54:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C141F8010A
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 18:54:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C141F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fAO4KmRx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D77961184;
 Fri, 29 Oct 2021 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635526472;
 bh=xJMcJlZ5X3eXJxE7o9KfSrs2+XgcENRmMvxeR2ZxKWQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fAO4KmRxyDHZ80ape2mgFBfMKBMDY9HiW5DkEzIfu+pJzSRyPvGUTKJvLM+dlT0hi
 /VPxuibsdC7VHMWFUM66ox+HzN1Xn3vNdOvWa4cGfQ08u4eu7bTlywBD9iys9FGYlv
 wvm03JRh2HUx2PAmdA+i/ZOy3ezyZ5DP+8VIFs2bvRqFhyyd6/nc1K8oGs62Pz9Ru9
 CfDQ+TuNXg86HDR0C3oiHHWHIYVbM4Q+xhl+Tjxji3qkIfF1dVD5fZyWwyC7+z9Xkx
 98o64YNmrF2JldeKam8EIqH1SpgR8nzdyYnqgGQRWaRvfNFNGg06b7lslb6wNDb3Ej
 2OR9kJV60KKlA==
Date: Fri, 29 Oct 2021 17:54:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Brent Lu <brent.lu@intel.com>
Subject: Re: [PATCH v4 3/6] ASoC: Intel: sof_rt5682: use comp_ids to
 enumerate rt5682s
Message-ID: <YXwnPd5ZRn024HOK@sirena.org.uk>
References: <20211020155715.2045947-1-brent.lu@intel.com>
 <20211020155715.2045947-4-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wRC+e69iwlw8jUnU"
Content-Disposition: inline
In-Reply-To: <20211020155715.2045947-4-brent.lu@intel.com>
X-Cookie: Please go away.
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Rander Wang <rander.wang@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mac Chiang <mac.chiang@intel.com>, Gongjun Song <gongjun.song@intel.com>,
 Bard Liao <bard.liao@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Paul Olaru <paul.olaru@oss.nxp.com>,
 Libin Yang <libin.yang@intel.com>, Huajun Li <huajun.li@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Curtis Malainey <cujomalainey@chromium.org>
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


--wRC+e69iwlw8jUnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 20, 2021 at 11:57:12PM +0800, Brent Lu wrote:
> Use comp_ids field to enumerate rt5682/rt5682s headphone codec for
> JSL/TGL/ADL devices and remove redundant entries in tables.
>=20
> Signed-off-by: Brent Lu <brent.lu@intel.com>
> ---

This doesn't apply against current code, please check and resend.

--wRC+e69iwlw8jUnU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF8JzwACgkQJNaLcl1U
h9CJ+wf+KM8JpratXROtpko1giAoVs0fSdbEHkH/arWfVgCh+d3CojV7Y9YUezid
MWqb4+nhpEJVelVVxvdREThE1BTHPPa9F9eDh57qJFneClpWOA9OG4dkhT02AK6K
47CNsHGZWWCTUFqpxPcQ4HsytIrUGtlxTqXQ9hlBiNEuaacc6BHLAa2K6EHBgfnb
mmFxdOPlEJ4x+qwtkPbWc45V6WpbIOEN8xmKa/C2KaDT3rev7Eu7g0I06XLAqKzi
+davyAcReu3MxkqKQUMM6y1KILmppdeAhB9+oQ/2v4ITz/fSfbgA5J3Z+rykT4fv
88iVxIqwC24DK+0RkoAhi5o4O1MrZQ==
=VgIZ
-----END PGP SIGNATURE-----

--wRC+e69iwlw8jUnU--
