Return-Path: <SRS0=II5U=3J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DBAC2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:38:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD59322527
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jan 2020 18:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MGls4yB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD59322527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39F601661;
	Mon, 20 Jan 2020 19:37:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39F601661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579545497;
	bh=GALpppA78tKuyNXjmt1yXvr8rojygmxIWLuPy0KiRxk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MGls4yB7veQNlL2K+J5HqsY+eqeUIkJH8/9paS8ov+CT0QM6AZsfIiLv27fMvurZq
	 dZrhVMkVdWzrWL0DoRePbcVmNVbbTVXvzKriXMTAafr6vSYT+W9GK6jhBj5rTfVvFw
	 u+qCmNMX/ub8Meh3XKs+z3u3ilJfeeUzvSf+vo6I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 934D1F801D8;
	Mon, 20 Jan 2020 19:37:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48C69F8020C; Mon, 20 Jan 2020 19:37:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 9EE02F8013E
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2020 19:37:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EE02F8013E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8738C31B;
 Mon, 20 Jan 2020 10:37:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035103F68E;
 Mon, 20 Jan 2020 10:37:17 -0800 (PST)
Date: Mon, 20 Jan 2020 18:37:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20200120183716.GM6852@sirena.org.uk>
References: <20200120160117.29130-1-kai.vehmanen@linux.intel.com>
 <20200120160117.29130-4-kai.vehmanen@linux.intel.com>
 <s5hpnfe2hvb.wl-tiwai@suse.de>
 <20200120171718.GG6852@sirena.org.uk>
 <s5hlfq22e3q.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <s5hlfq22e3q.wl-tiwai@suse.de>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: cujomalainey@chromium.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA: hda/hdmi - add retry logic to
 parse_intel_hdmi()
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
Content-Type: multipart/mixed; boundary="===============8426188634622651813=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8426188634622651813==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wKTlTxfx0Fr6BT7S"
Content-Disposition: inline


--wKTlTxfx0Fr6BT7S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 07:10:33PM +0100, Takashi Iwai wrote:

> In anyway, this fix is really independent from others and has little
> to do with ASoC itself, so I keep this picked through my tree.

Yeah, I don't think there's any problem with taking it separately.

--wKTlTxfx0Fr6BT7S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4l81sACgkQJNaLcl1U
h9BLwAf/aeCcXbVanvpMhK6SbwHrVgVHlvlVUivnKCslYhTHEeJ+1PE++2g5466C
wGD2ud0/QUbSk3UNo4qvVQbWXoR6nTLgXLnmtmYVjJhVhTbk0CQ3IxaSoqLCFbLV
2PYJo+muJuBJGzQikbHmrYLT9qn1WZO3JXEBegafXN79+EnETH74KcZ17kGzm/sO
XRfVo1+qVCaPh6mZR4iubss3utR8JYta8NOJsx1XEmU9LK2ZLLpXB+yWGYrsa7kZ
o9w2x9HGhKynNJQhaSx1mVveaPrfV2L/pvnJPn1LVj7X1fkK0tyWI6FSwow0qXnf
mTrpI685BNnyCmyqdsswkqE1C2XG3w==
=kJm6
-----END PGP SIGNATURE-----

--wKTlTxfx0Fr6BT7S--

--===============8426188634622651813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8426188634622651813==--
