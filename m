Return-Path: <SRS0=e91y=7R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333CDC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:03:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B490C2077D
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 19:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YzSr3zmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B490C2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DF251658;
	Thu,  4 Jun 2020 21:02:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DF251658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591297422;
	bh=cmkuM7iDYK0BpDNhnRd0/htUTJwq6fvVVZF2/jCMs4w=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=YzSr3zmT4RS5ThO+dfSf3YdIYsxFvsV3O+mtbKe0L1L2gREgpveIlsPSUbtwtFdJs
	 KHtfNuvlP2zBT0XsRZy7PVVcRUtawHSOCU0vOQCUR7VNoTkZ+doAKmeo3Jfb/V1sps
	 pcQ4Yq8wASKNwVypMqdIWXe2o/9j7bnaG1m4YERc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CC5DF8023F;
	Thu,  4 Jun 2020 21:02:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA69CF80254; Thu,  4 Jun 2020 21:02:45 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED265F80108
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2020 21:02:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED265F80108
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6347FAC52;
 Thu,  4 Jun 2020 19:02:33 +0000 (UTC)
Message-ID: <4c046724106e88b69584c6bf5604a5e7f7189c1f.camel@suse.com>
Subject: Re: ALSA control service in user space
From: Scott Bahling <sbahling@suse.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Date: Thu, 04 Jun 2020 21:02:23 +0200
In-Reply-To: <20200603100556.GA198303@workstation>
References: <20200603100556.GA198303@workstation>
Organization: SUSE Software Solutions Germany GmbH
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-WNdEKnmotQlgNpAJAsRR"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Cc: guy@guysherman.com
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
Reply-To: sbahling@suse.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--=-WNdEKnmotQlgNpAJAsRR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, 2020-06-03 at 19:05 +0900, Takashi Sakamoto wrote:
> Hi,
>=20
> Today I released hinawa-rs[1], Rust bindings to libhinawa v2.0[2].

...

> Now instead of Python 3, I select Rust language to write the server
> programs for audio and music units on IEEE 1394 bus. The hinawa-rs helps
> the third and fourth of the above tasks.

...

What does this mean for the future of hinawa-utils? I have created an OSC
server interface[1] to the Tascam FW-1884 control surface using a fork of
the hinawa-utils with a few enhancements[2]. The OSC server works great for
controlling applications like Ardour with the FW-1884. I was just cleaning
up the code and was prepared to submit my patches for hinawa-utils, but if
that will go unmaintained, I might just integrate the hinawa-utils parts
into my OSC server code and only depend on libhinawa directly. What do you
recommend?

[1] https://gitlab.com/tascam-fw-1884/tascam-fw-osc
[2] https://github.com/sbahling/hinawa-utils/compare/master...fw-1884

Regards,

Scott

--=-WNdEKnmotQlgNpAJAsRR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQjvzoZ9RLbHiUT/sAst8aI6UpxIFAl7ZRT8ACgkQAst8aI6U
pxJfCw/7B1BByxYLdiPfSVOxzwM3z+F4Bs+5MQ+4kZQY7q3+HHJgAPZBG+K7rQfy
QdmTr8IQeOJK91MeWTA44vOIN9xvMdj3uiHQHI1WUacJyMaYeeKhDaf0j8JH5aja
3jhoHEmqxxWpSR4fPLg0BQ3H+/c2j7TL54+IYV0U7QpiXvZlA3Y3kXHKMNrLnyFi
bZosHEKLMRWoFP1pCjSWyeAeQN+t3s0j+SgRI0Jzqljv2epv+1xu53y9GYBtyjlp
4T2P3rD8RCoU2WCkZ4bY1XD94FlunosAaQ4Rd4T2Pl+pqL/8E9aTHNueFPBJCAWy
Mqs1I7307a5DabTAGjkTHcxSmzZIEEIbFyx+3Z1GyOL89dVrre3GWbivUsYeR/sO
cSdqUyGZw7ZEEQquM7tL2Qg2Z9hlFh4LqRK4AKz61B9LhnS7banzXZjtGin7UHT6
+UDYW7K6dVCQC9bFbek3E8OySwjI9rr08tOoX1Zd3X0sahdi2Xzv1qWpxDftOUwW
uXTsmT5bQTbeTZscRsggBXTFTJkmu5KnI3cNc/7LG+LyJHosE8c7hiWcXbvQOR4Z
icTrbOhVFtu152Y92mHF218/C5fJ+tlU2kEclgT4PmDnY3QC2dyd8MnqKj9DEZzF
SvT9dVq9/qrzVAdFtzQyN6zEHeEzLZzk+hwbkoTszKLlskBCyqM=
=XYWL
-----END PGP SIGNATURE-----

--=-WNdEKnmotQlgNpAJAsRR--

