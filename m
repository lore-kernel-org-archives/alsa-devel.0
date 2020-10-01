Return-Path: <SRS0=ZHdS=DI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D6C4727C
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:52:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B3D2075F
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u921nJMB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1/BVl4j/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B3D2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 061A8181B;
	Thu,  1 Oct 2020 14:51:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 061A8181B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601556760;
	bh=HYnEkxfGtzik3RLCQGgHiLXlZvC1A7OLoYjqo6TX3TY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u921nJMB9V9/72ZoRx/EsV+QiY/PUt8B9TATW2VlqUBppHLiPMbnZisJe/DHHo/h4
	 b6Ju1cmxDoAhr7FHoGRWeTcVgpWBJskPkrTr9kMB06bvjOXfCRxA/0eFPlemVqs5KM
	 XZn9YaqhkChs+s3rOZub5UKC8XoXFo5sRK5nq49Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 949A3F800AB;
	Thu,  1 Oct 2020 14:51:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D2EBF801F5; Thu,  1 Oct 2020 14:51:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1D5CF800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 14:51:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1D5CF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1/BVl4j/"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94CB12075F;
 Thu,  1 Oct 2020 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601556698;
 bh=HYnEkxfGtzik3RLCQGgHiLXlZvC1A7OLoYjqo6TX3TY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1/BVl4j/fqxCa/Pqx63ZxKO/UdyDUUXR6MivieG92tJ75lA3IvW1uumihPXCMH5Xq
 n/2vGdidt0pP8QUtNjvaGa0K7q15qp9XShHYV3bE+UT3sfZeoFw6QJHpTsE8VneNjw
 fAAK2m7CUEODs7mE2n/2PqYQ/50PjZ13WS8YN3ME=
Date: Thu, 1 Oct 2020 13:50:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
Message-ID: <20201001125038.GC6715@sirena.org.uk>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <20200930225051.889607-1-david.m.ertman@intel.com>
X-Cookie: Stay away from flying saucers today.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 ranjani.sridharan@intel.com, pierre-louis.bossart@linux.intel.com,
 parav@nvidia.com, jgg@nvidia.com
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


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2020 at 03:50:45PM -0700, Dave Ertman wrote:

> In some subsystems, the functionality of the core device
> (PCI/ACPI/other) may be too complex for a single device to be managed as
> a monolithic block or a part of the functionality might need to be
> exposed to a different subsystem.  Splitting the functionality into
> smaller orthogonal devices makes it easier to manage data, power
> management and domain-specific communication with the hardware.  Also,
> common ancillary_device functionality across primary devices can be
> handled by a common ancillary_device. A key requirement for such a split
> is that there is no dependency on a physical bus, device, register
> accesses or regmap support. These individual devices split from the core
> cannot live on the platform bus as they are not physical devices that

I have to say that I find the motivation behind this bus to be a bit
confusing.  In code terms it's essentially a stripped back copy of the
platform bus and we're basically assigning devices between the two based
on if they end up having a physical resource passed through to them.
That seems to result in some duplication, has some potential for devices
to need to churn between the two buses and for duplication in parent
devices if they need to create both platform and auxiliary devices.
What exactly is the problem we're trying to solve here beyond the
labelling one?  I can see that it's a bit messy but this whole area is a
bit messy and I'm not clear that we're not just pushing the mess around.

> are controlled by DT/ACPI. The same argument applies for not using MFD
> in this scenario as it relies on individual function devices being
> physical devices that are DT enumerated.

MFD has no reliance on devices being DT enumerated, it works on systems
that don't have DT and in many cases it's not clear that the split you'd
want for the way Linux describes devices is a sensible one for other
operating systems so we don't want to put it into DT.  Forcing things to
be DT enumerated would just create needless ABIs.

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl910J4ACgkQJNaLcl1U
h9CkIAf/QUPLNsfbtSFNqLP/NdqdTuTMDR/N7eZ0sSpWNsBhASPh5+O2gABQZXsp
cI6ahMoCWlA5joGnJ/TNKJ3RSMQDdL5N5E6xPac0M6JDgT/fYXZKvvGnmYLTSXTf
g6KvHOjnr2b2M0O+K714ycHo4tNUc8Lb0BX11VrpOI8GcHvGg5bKy1qGQZBNp6k9
ObbHJm/HxZHxYKd4lBcBVhsgZ7CxnH+jQ2NhrHKahDTn8KWQ9NQaXYprYytpwoV+
aXPSQzgTNdzGFytxjRHJ0sD1E2jl8evt5ytt50LN1/6DuG4gmeBMahch4snQeaa1
ka6x2eUGBsJ1ozcQ3qvv3Mv70PmrSQ==
=pJoC
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
