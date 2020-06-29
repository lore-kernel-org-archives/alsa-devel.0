Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8B8C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C730D20760
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UZ1JBKTw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+ucAQ9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C730D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42B59847;
	Mon, 29 Jun 2020 22:07:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42B59847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593461309;
	bh=CFy0XiHvO0+goP6LXEaAAtd6WGeOa3kVbpguRZ50Wcs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZ1JBKTwmYUU1WCFmyjspI+QN1bZFllqpjtGjxfNkg1n98TqR4SU/nOUXPzAW+ISq
	 BwQoI5lE5xLgNzwF4zhABspBoVOpXQv2Af9heesMhMldLW0RNd9RvCZohCyBLUIyK6
	 BTNI/bfHCyX+OqsSeZao4UPZvBy86XTjAqk852Bc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1D54F8020C;
	Mon, 29 Jun 2020 22:07:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D05FF80217; Mon, 29 Jun 2020 22:07:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 612E1F80096
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 22:07:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 612E1F80096
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="D+ucAQ9r"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D5C520760;
 Mon, 29 Jun 2020 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593461250;
 bh=CFy0XiHvO0+goP6LXEaAAtd6WGeOa3kVbpguRZ50Wcs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D+ucAQ9r/Ni6hZV/uOTTT+23wR7/A/Nt3CAKRxD7WXxHGJqY0Eh6j0mbhnGnQCxP+
 b2S9SvV3tDNw5WW8IOcsT0B/MI1YbENRGgR/ESoNb2W/TR1IJbdlBwM9rbY+BFgXW6
 em5RNOYCT2ugSn22qiyF24bn/lVM+jxt3B71NbOk=
Date: Mon, 29 Jun 2020 21:07:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ASoC: rt5670/cht_bsw_rt5672: Some bugfixes and cleanups
Message-ID: <20200629200728.GJ5499@sirena.org.uk>
References: <20200628155231.71089-1-hdegoede@redhat.com>
 <2dda2d0a-2aa5-d9a5-d214-6ab0259de43c@linux.intel.com>
 <b93be4cd-0d32-4bc0-d3f8-4f8a22996469@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oplxJGu+Ee5xywIT"
Content-Disposition: inline
In-Reply-To: <b93be4cd-0d32-4bc0-d3f8-4f8a22996469@redhat.com>
X-Cookie: Real programs don't eat cache.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
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


--oplxJGu+Ee5xywIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2020 at 10:02:23PM +0200, Hans de Goede wrote:
> On 6/29/20 5:14 PM, Pierre-Louis Bossart wrote:

> > I added a minor comment on patch 1 but is a good set of changes, thanks Hans!

> Since Mark has already merged this, I believe it is best to keep
> patch 1 as is, still thank you for the clarification of what is
> going on.

I was kind of expecting an incremental patch for that TBH.

--oplxJGu+Ee5xywIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl76Sf8ACgkQJNaLcl1U
h9AqiAf/UkbEYftLCPnnKy2ii7T2oyzVNjQmzz1m1CMle4dlwIf7/7LsACkT4gUx
ir57EGBHM31jRfjknZeqJGGPBjqyQJpubFuQpMqsYjIFu3DrDce2RBpkefjIWeR0
0X8fhendeduvhG31GG6eDkmRi522GoT13kGYez/7QHzHZIS8J9L5EyOO8oliIAo7
bIP6yV6JE+0MK54VQS7eFMLB67TN5BrceP3x/bOVO+/miiCsKnOGRC1Zgrt9c5eN
/XILsWSAPDzsIZ6I6TlmeXG6EBnTjO1MhHxebTnGAo6OAzpAvaCpqf9b7dX5TyOn
xCTqiYkjqy1yFBXSgNa22pu8VMcQiw==
=ugt7
-----END PGP SIGNATURE-----

--oplxJGu+Ee5xywIT--
