Return-Path: <SRS0=z+9C=DX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A41C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:19:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46F620897
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YlQaEwS7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xOFC0xX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46F620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD5EE17B2;
	Fri, 16 Oct 2020 17:18:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD5EE17B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602861577;
	bh=rgeQjAZ0kzxnk8SwXsOvCKN7o5QSYlfcQcgpKjlVIBE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YlQaEwS7pNa4347g4a1rrm3T6IRRuSFCCql+KzDYv9Kl3d2XUXxJYfkS20/+Sevoj
	 4TfETWw5nyo7X0LE4VegOjDOnsYTJ0ig1LrvQkSei3GlcxtoWoUevzEwKnOg+XFMKb
	 t/fZhcW1bsWTu6HfByxhWuOoQWKsbPYfENPrWuoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74E20F8020D;
	Fri, 16 Oct 2020 17:18:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1930EF80217; Fri, 16 Oct 2020 17:18:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C83A6F800B8
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2020 17:18:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C83A6F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xOFC0xX1"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E891C20897;
 Fri, 16 Oct 2020 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602861520;
 bh=rgeQjAZ0kzxnk8SwXsOvCKN7o5QSYlfcQcgpKjlVIBE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xOFC0xX1gIoo4Cbk07OV9cXGBwYcCa9MigKKW1zmacVlTi811BbqPB4d805bK3D7z
 wEt5uMbXHm4huhSU6vgLL+2AtqkdgW1XoSV0iBeKGnzZ2ewKvOTR3rmYOHNW3rV/uQ
 Kg90usJVdKnr6IvoZcAkhmQNdFzSxraX4Q7b587A=
Date: Fri, 16 Oct 2020 16:18:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/7] Add dts for Rpi4 + Cirrus Lochnagar and codecs
Message-ID: <20201016151831.GE5274@sirena.org.uk>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014185632.GD4580@sirena.org.uk>
 <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
X-Cookie: Pournelle must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 nsaenzjulienne@suse.de, linux-rpi-kernel@lists.infradead.org
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


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2020 at 02:30:08PM +0100, Richard Fitzgerald wrote:
> On 14/10/2020 19:56, Mark Brown wrote:

> > Why extend simple-card and not the more modern and flexible
> > audio-graph-card?

> I'm struggling to understand how to use audio-graph-card where there are
> multiple alternative codecs. The host I2S endpoint has to point back to
> the codec endpoint, like this:

OK, this seems like a more urgent problem to address given that the
graph card is supposed to be able to support things like TDM.
However...

> 	cpu_i2s_ep_cs47l15: endpoint {
> 		remote-endpoint = <&cs47l15_aif1>;
> 	};

> But obviously that depends on which codec node was enabled. Listing
> multiple endpoints makes the whole port node disabled if any remote
> endpoint is in a disabled node. I've tried adding status="disabled"
> to endpoints or multiple port definitions with status="disabled" but
> I haven't figured out a solution.

...it seems like the issue here is that you're essentially trying to
define multiple cards at once in the same overlay.  TBH this feels like
you want two nested levels of overlay, with the extra layer patching the
CODEC compatible.  Or if this is mainly as an example for people you
could just pick one and use that?

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+JuccACgkQJNaLcl1U
h9AnaQf+LQ6dXnZyQXkJi780zdCEyQ12TcEOc3Mb5/WE51kiHuRDa4Luy5Xk97Gt
XI6V2WO9lJyYVgZt5BgLjAJJohah5WBPo+ShXgwgZI1bo4Y6N+6jctbqC6/DPtHe
yIKyeZMlemrwsqbuRJI937EZMfGRhdF5ba8JymF6N7K8xjjZyls0g/VE8KqOZjFr
7MUpgcSaWVeazF8LLRcQkhA8f4YT0mnMuFtvy07u4plMMyxRTtNdF2szMHNY9rTu
Lnhd8/OE6tNFNnoEeAzrREHbeuqtQ4NCSiTl3vEfO4yMR/cby7caXXdSqODGYhC9
gPAU+bIAOvQQV6vzj+AX9zbuVE/C2w==
=H9bK
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
