Return-Path: <SRS0=MK90=ML=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7474C07E9B
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 11:57:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAAB6113E
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Jul 2021 11:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAAB6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F03083B;
	Mon, 19 Jul 2021 13:56:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F03083B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626695862;
	bh=bf/A3J/zlY4cs6b/oaf8Mqh4IOEAAWYGQ8bvt90zfYU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lHtIz3Urm20XA1bJG/9KgrLa17NJJq//zFHiUFoaA9vUs3SxzmJ7r7JwwFR50oeur
	 pf26sioCZl6YBObfIs6pGK2X92zIewFheQZjvIH7bQdt9mw9v9DjXOrWe2r2hIAQre
	 dKjKJWHRD9DYbmS7Pv8KfuZPkYaB2mkmAsOJeti4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BB19F80218;
	Mon, 19 Jul 2021 13:56:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B748FF80227; Mon, 19 Jul 2021 13:56:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20122F80169
 for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2021 13:56:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20122F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="c3Yaxyic"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AC156113B;
 Mon, 19 Jul 2021 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626695800;
 bh=bf/A3J/zlY4cs6b/oaf8Mqh4IOEAAWYGQ8bvt90zfYU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c3Yaxyic+53fBMFofsxUgVgiK9O/Nar0We6OaKpcm8f7+R3NhnK5w39KFCRPHr99+
 auqU55QHHH9DekAtqyrfV9l0HQ6F7iVjoLuCNr0YlzMYXU0hpSKIHTXKSBRfciWgGH
 6Mh5PyLqowKbS/eASS9Yexn/XybW0M47O9x3qI9ecW6HhEBkM6uqkW4ek5O39Vq4Yu
 3y7y9Lh9c03ifk7k49D1DaMyX793L2EUDyPA5upaa4eUWtHVslk+TCg0UXaIaBghQj
 ipyNgnAjNYF1ZUWmi/+ZrVebhTuPzEOef+9US34eGSpT12OjceKhsR5BN1LlIFKYtr
 UaoL09EvSx1qw==
Date: Mon, 19 Jul 2021 12:56:36 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH RESEND V2 00/12] Add Vangogh ACP ASoC driver
Message-ID: <20210719115636.GA4174@sirena.org.uk>
References: <20210717040059.310410-1-Vijendar.Mukunda@amd.com>
 <5673f620-fec1-d2a3-0b78-a1cfdda04acd@linux.intel.com>
 <ff857faa-c8c4-0f73-4ede-f8f3ded4e923@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <ff857faa-c8c4-0f73-4ede-f8f3ded4e923@amd.com>
X-Cookie: You will be divorced within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alexander.Deucher@amd.com, alsa-devel@alsa-project.org,
 Sunil-kumar.Dommati@amd.com, krisman@collabora.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 17, 2021 at 10:04:15AM +0530, Mukunda,Vijendar wrote:
> On 7/17/21 1:22 AM, Pierre-Louis Bossart wrote:

> > usually the version number is at the patchset level, here you included =
v1, v2 and v3 patches and all but the last one use the RESEND prefix?
> >=20
> > is this intentional?

> As We have respin the patch series, we have updated cover letter with
> version as V2.
> Got your point. Cover letter shouldn't have any version number.

> We have updated patches as v2 version with fixes.

> It's my bad. For last patch, We have removed extra stuff which we have
> added earlier and marked patch version as V3.

No, you haven't got his point - his point is that everything in the
series (including the cover letter) should have the same version.

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD1aHQACgkQJNaLcl1U
h9DbeQf/Q6mYESWY3+epdVKtyZUrJTtXAnp4U+fHHTjHs4DwvIdhkcheQ1wtekLd
6bi4I6Qda2bwzJVQFJm4fXFIIMy/G5q2HkvaHhTBWipHBsoDUdhP1qp6TFHGd+iP
7j1vUsV5cJ69zEge4E/Ir1EnElubgSBkVrOPg1HEQzAEi7hPcUXkCcZTm9dJCwKd
Xf9Ogegf97KKQibVnO9iI6BAezl8+v+moi2mkczJTNa0LJzTbACLM5TkUDXYxSn8
HNnQhCPQRmiQpLLC5RiR2gh3QTJI3Z1DddiWBlbwE4TjnIBE+vDYE5HuDXUYs1HJ
itS1pVF6/EHh9co4qCtvG6cJSmJFAw==
=B8Fl
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
