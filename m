Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB1EC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:41:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF12420715
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XT3oHBUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF12420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78E05174B;
	Wed, 20 Nov 2019 20:40:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78E05174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574278861;
	bh=XUwxrR8U4xKA4YW9jU3eUZWnpYykE3QXGawpjn8Y2PE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XT3oHBULXeTqBtS/2nQpz5T6Z/gAmSHGNZuR22fEEVzpWM5tJBsQDemg+8trevZ8b
	 aajsazrsHF+HVs0Fv/bOWfKDM9zlZqW2qC43MD/g1l4krNPmzZvX9ghcN72l2/SGwQ
	 hGewTyJJe9KZMFFL3zJQTFsmvxvQ94n0prjxRZm4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3342F8013C;
	Wed, 20 Nov 2019 20:40:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBC7AF8013D; Wed, 20 Nov 2019 20:40:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 66F8FF800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 20:39:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66F8FF800C1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ABE61FB;
 Wed, 20 Nov 2019 11:39:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2113F6C4;
 Wed, 20 Nov 2019 11:39:57 -0800 (PST)
Date: Wed, 20 Nov 2019 19:39:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20191120193956.GD5705@sirena.org.uk>
References: <ef29c9d6-b359-a9df-f8fa-d547b02bc8d2@perex.cz>
 <20191120181946.GC5705@sirena.org.uk>
 <4fde7eec-4a5a-c882-87d2-177cfc808126@perex.cz>
MIME-Version: 1.0
In-Reply-To: <4fde7eec-4a5a-c882-87d2-177cfc808126@perex.cz>
X-Cookie: Best if used before date on carton.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] ASoC, DMI and UCM
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
Content-Type: multipart/mixed; boundary="===============5774238252191490175=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5774238252191490175==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2019 at 07:46:47PM +0100, Jaroslav Kysela wrote:
> Dne 20. 11. 19 v 19:19 Mark Brown napsal(a):

> > I'm not clear what adding the component string does here - is the
> > intention just to say that the card is built in to the machine and hence
> > DMI can be used?  If that is the case something more generic that'd also
> > work with other firmware interfaces might be good.

> Yes, basically, it would mean that the sound card is integrated to the
> motherboard thus the DMI info can be used for the special configs. I already
> added sysfs support to alsa-lib ucm substitution.

> Thinking more -  we don't need this probably urgently for ASoC drivers,
> because they all work with the integrated (built in) hardware, but it might
> make sense for other drivers. Probably another component identifier should
> be selected like 'integrated' or 'builtin' or so.

Either of those sounds good to me.  You're right that it won't make a
huge difference to most ASoC drivers, like you say it's not like most of
them have any non built in variants to worry about.  It seems most
likely to be relevant for something like USB.

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3VlosACgkQJNaLcl1U
h9AIQwf/TmyR+R5Q2BKkK3+yNt+J5wC8Vp9btcXb85pqTWpT1MJbg1ez8+XGEYMy
Lie4qxrscx+VK88dbMRrRffUxPXu9kBj+vLiUEddbXvgetBKynqXYFao7UcQ5n2g
smbD65r+K3yrHFnnJ0+cCqLvZEJYJZD7M396VelC0M0Dt1s+dW253txnAbS00Pf7
JOa04mKcfRrTipqFQpfP17b4VOmb50wPEPm/NDtCjhjn5MCy/TcC0ffl3i4Sz7xA
2Z9GQMY1HJzwE/ZeaCMOGBnKy86cxzcx5QmDSOvt70lxfxH47WaYZ2IeGcrT+Gts
8gvCNgK9JAAXXbWZb2ctxcjkjEWynA==
=03ZN
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--

--===============5774238252191490175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5774238252191490175==--
