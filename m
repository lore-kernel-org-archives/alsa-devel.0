Return-Path: <SRS0=cdus=L5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D28C07E99
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jul 2021 15:52:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC8F6196A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jul 2021 15:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC8F6196A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B16D15E0;
	Mon,  5 Jul 2021 17:51:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B16D15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625500321;
	bh=glhegRlbhTXXlkziDdj/aqJGW6U/IEMbgXbZb5HXqko=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IfpLX7ZAl98+KwD9QjXvlPgXSMro5kuvJ41u9J+B5FnfYXMtQjSJ6pA8QZOofvN5y
	 o36WELhf6l483ESALxtdMGodW8n74UxaJrEeZSalOuYq2UL5sLELTEoZ/lYM8vjNQt
	 AOa77t0DqffMFnvcoIjaI26o0+WmhW/HaCzlqFHg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6118F8014E;
	Mon,  5 Jul 2021 17:51:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC3E6F80224; Mon,  5 Jul 2021 17:51:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96CB4F8014E
 for <alsa-devel@alsa-project.org>; Mon,  5 Jul 2021 17:51:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96CB4F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IvDyVcbx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0181161968;
 Mon,  5 Jul 2021 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625500263;
 bh=glhegRlbhTXXlkziDdj/aqJGW6U/IEMbgXbZb5HXqko=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IvDyVcbxBreYf+AJ2hJivcLrpH4d5zsbB2N2UpZPPjpKnqaXUQAkR0bOMj49s/FR+
 fBt59drojMHynuSXfkb1tjHz6t74uxDO+RA1MQZGOnofF6Hd5C6iGdzuQVEt5946mt
 lGUsyb8AJEZUPRt18VOt3hE3ofHcmiytZi6mA/kRxYF+C/6FnQcaGX2AWHVXDSxgRj
 J7lUMIf4sDD9maESYX0AaglVz04LUHJWCBjsazwxf/VFRqtfLXRJd+kOSui4kednbM
 +v4B8Knpz0V4/L/cIyreYoLuIv6ZqF9YXU6FZGvTs/7+/Sp2F/1Bs30F1ktSBkuB6O
 v5Q8uEuKpyCVQ==
Date: Mon, 5 Jul 2021 16:50:32 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: ti: davinci-mcasp: Fix DIT mode support
Message-ID: <20210705155032.GB4574@sirena.org.uk>
References: <20210704150450.20106-1-peter.ujfalusi@gmail.com>
 <20210704150450.20106-2-peter.ujfalusi@gmail.com>
 <4b530480-bcd6-08cc-b8d6-7e57d0a823ce@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <4b530480-bcd6-08cc-b8d6-7e57d0a823ce@gmail.com>
X-Cookie: Star Trek Lives!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tony@atomide.com, hns@goldelico.com, alsa-devel@alsa-project.org,
 linux-omap@vger.kernel.org, lgirdwood@gmail.com
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


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 05, 2021 at 05:58:04PM +0300, P=E9ter Ujfalusi wrote:
> On 04/07/2021 18:04, Peter Ujfalusi wrote:

> > +	u8 slots =3D mcasp->op_mode =3D=3D DAVINCI_MCASP_DIT_MODE ? 384 : mca=
sp->tdm_slots;

> This is wrong.
> 384 will not fit to u8...
> I wonder why I don't saw this...

Or the compiler for that matter...

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDjKkcACgkQJNaLcl1U
h9DcDAgAgMKsrDYJYnXxsZ8DtK7RFf44t36R6GVLc5F5txpjuo8sfqRO5wUMblKK
ctbXxhjWqKUY8giWyDjuA+F7UE0eOYvA5HAQz/7cGdexXuy+eACm42+ps4FXMqTz
5Dpjd01WdVs+Tdatq0om/uxWOatNoGUVbB2fKdvTw63FFDkCKa6REjBVikBcWd0G
/Afi5p7U62RKkCtQUB6yvnwrmH7BN9IKgS/Z9ki/zyBaKlCcjwo1AV7/0QSmS41a
ncCmla2vAwoyeZ4e4h56runprOdodekEq5U6RA504z8pH8wr3ck0yRLHiZ7ira8N
zkWUqd32rHveHN64+epaCbC4n6MGLg==
=HKQh
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
