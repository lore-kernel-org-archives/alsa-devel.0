Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42DAC4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:42:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF3E20780
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mH3CA70g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWigEgYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF3E20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84D801885;
	Thu,  1 Oct 2020 16:41:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84D801885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601563338;
	bh=DERKtjHFmtLUf+QV696To4OPdUGGfeMFqxSispX9cms=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mH3CA70g+WrM9EkR9nfai0q5sLBgJgF0Cz04ZQSY8n6wpnoiuUso4ANxFzhh1bjIt
	 lBJyql8HogPPp8IwESSaWuryQDOVW1zNv1IVtVpF7ilU95x2F0Qze+8Hy+q1nxki3W
	 hoRVGQ3M+eXOs3refm9AefFy0b7ih6wkWqazvVQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23674F801D8;
	Thu,  1 Oct 2020 16:41:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DED6DF801DB; Thu,  1 Oct 2020 16:41:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56ED9F800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 16:41:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56ED9F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cWigEgYh"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 50251207FB;
 Thu,  1 Oct 2020 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601563278;
 bh=DERKtjHFmtLUf+QV696To4OPdUGGfeMFqxSispX9cms=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cWigEgYhv/LQDTjN+NK9cgTb/0UzIJKrXmoIS8EoPOIQjjqx8A8MHRLYKeWTM6e09
 vPOm9BPSpW8gT8K95LK/PbIx0fskC+DTHKLzuhEjs91zOxXcB3x/YQxDGL0YZHhK3r
 W4bbT4fJHgSUiP1O/VJ+yiqk31sfsG8J1GUUE2JQ=
Date: Thu, 1 Oct 2020 15:40:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201001144019.GJ6715@sirena.org.uk>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20201001125038.GC6715@sirena.org.uk>
 <20201001131252.GA2382269@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline
In-Reply-To: <20201001131252.GA2382269@kroah.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, ranjani.sridharan@intel.com,
 pierre-louis.bossart@linux.intel.com, parav@nvidia.com, jgg@nvidia.com,
 Dave Ertman <david.m.ertman@intel.com>
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


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2020 at 03:12:52PM +0200, Greg KH wrote:
> On Thu, Oct 01, 2020 at 01:50:38PM +0100, Mark Brown wrote:

> > That seems to result in some duplication, has some potential for devices
> > to need to churn between the two buses and for duplication in parent
> > devices if they need to create both platform and auxiliary devices.
> > What exactly is the problem we're trying to solve here beyond the
> > labelling one?  I can see that it's a bit messy but this whole area is a
> > bit messy and I'm not clear that we're not just pushing the mess around.

> This series doesn't really show how this is ment to be used, from what I
> can tell.

> The goal is to NOT need a platform device/bus as that's an
> overloaded/abused subsystem, and to just use a much lighter-weight
> subsystem that allows one "device" (PCI/USB/whatever) to have multiple
> child devices that then are bound to different subsystems (networking,
> tty, input, etc.)  Yes, there will be some core "sharing" needed, but
> that's up to the driver that implements this, not the generic code.

Right, so my concern is that as soon as we decide we want to pass some
resources or platform data through to one of the subdevices it needs to
move over into being a platform device and vice versa.  That feels like
something that's going to add to the mess for some of the uses.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl916lIACgkQJNaLcl1U
h9AysQf/dsBsbTR6CbrT+rj9Bo04paO3l/Ll4A92ovSKglRm9f2mRwQa3x8zVCgU
+8MdjTdYJXQsXf5VAKGA4tAMf59y94EHIJwRaRU91iIphOzXkaohlMV18vKchzX4
8kJK1gj8P5xjEFIQCbrnICaSsUW0GnztHz7ZuTcuHgiu8WJzb6FXK6HmJU1pChTl
/JGNywAXLaNkvcXjzqHYPgi+XPxHF8R77aJGRebc64/o9BOp++2NgTS7Epw+QqNf
GsPSqiYh4haTzi9/VNt87rO4zyfy1HnQpelV9h94ksi3GMLrgpH5wS41+FLPkKAD
Szsy1fQoA9JKSeLhoE41lZ3VM12lvA==
=w3r5
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
