Return-Path: <SRS0=Eq0+=FZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FADC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Dec 2020 18:53:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0E222AAB
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Dec 2020 18:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0E222AAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABBE81703;
	Mon, 21 Dec 2020 19:52:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABBE81703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608576775;
	bh=YkdUJqE0UIpHET+IcPL1+UgnebkbGvIwmn1cUuRAHqw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gp3VzuVa69l9iquczxMK3iIYs+r64YGlwxq4W30zRqgKdn0YmmHn+9o0XLJMcDRZo
	 1rYwekBcEbVT8Hv9GulbCYbexU71fIxFu5yzUd4rysRcTSRDGUcWRKRHKslWKRzNCw
	 aoWL5gKpP7RHuTdZeWRWN2ji99w5WY1QUqOSiyKw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AE48F80168;
	Mon, 21 Dec 2020 19:52:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F562F801D5; Mon, 21 Dec 2020 19:52:03 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F820F800EC
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2020 19:51:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F820F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PPuUblpL"
Date: Mon, 21 Dec 2020 18:51:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608576716;
 bh=YkdUJqE0UIpHET+IcPL1+UgnebkbGvIwmn1cUuRAHqw=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=PPuUblpLuOc1RSKrGcqCxeAYBiCDVP04QbB2xwERZ46f97Dbr4rG2NHcPg2eWhh+s
 25fc68oQk+EkXqjdRNXf8d+7OlRu8O0Ba0QIsPur/VgL0jHbF9/lljutpft9IQdqPG
 9zWT54tu8QKq3QSCLp0RfdMFSG5xj58AXFRDxyiN++cCxXswTLTbBf9rFK1RHMia1Z
 9ILGRXgag4/cVkVuIAqUcbp4Ahk9FBNyWjrQOhh8YO7oVyaNWMzigv1ZlzIqByTZ+z
 +KiIelx9q3Rrjz6T9L9whT8X1q/f4MN3iPOYx13C+wfBLu2sUzTbU/WoHXHqNiJNfF
 0o+63uGLtoe/A==
From: Mark Brown <broonie@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <20201221185140.GD4521@sirena.org.uk>
References: <20201217211937.GA3177478@piout.net> <X9xV+8Mujo4dhfU4@kroah.com>
 <20201218131709.GA5333@sirena.org.uk>
 <20201218140854.GW552508@nvidia.com>
 <20201218155204.GC5333@sirena.org.uk>
 <20201218162817.GX552508@nvidia.com>
 <20201218180310.GD5333@sirena.org.uk>
 <20201218184150.GY552508@nvidia.com>
 <20201218203211.GE5333@sirena.org.uk>
 <20201218205856.GZ552508@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <20201218205856.GZ552508@nvidia.com>
X-Cookie: Remember: use logout to logout.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, lee.jones@linaro.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kiran Patil <kiran.patil@intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-rdma <linux-rdma@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Martin Habets <mhabets@solarflare.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Netdev <netdev@vger.kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, David Miller <davem@davemloft.net>,
 Leon Romanovsky <leonro@nvidia.com>, Parav Pandit <parav@mellanox.com>
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


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2020 at 04:58:56PM -0400, Jason Gunthorpe wrote:
> On Fri, Dec 18, 2020 at 08:32:11PM +0000, Mark Brown wrote:
>=20
> > Historically people did try to create custom bus types, as I have
> > pointed out before there was then pushback that these were duplicating
> > the platform bus so everything uses platform bus.

> Yes, I vaugely remember..

> I don't know what to say, it seems Greg doesn't share this view of
> platform devices as a universal device.

He did at the time, he seems to have changed his mind at some point for
unclear reasons=20

> Reading between the lines, I suppose things would have been happier
> with some kind of inheritance scheme where platform device remained as
> only instantiated directly in board files, while drivers could bind to
> OF/DT/ACPI/FPGA/etc device instantiations with minimal duplication &
> boilerplate.

Like I said in my previous message that is essentially what we have now.
It's not worded in quite that way but it's how all the non-enumerable
buses work. =20

BTW I did have a bit of a scan through some of the ACPI devices and for
a good proportion of them it seems fairly clear that they are not
platform devices at all - they were mostly interacting with ACPI
firmware functionality rather than hardware, something you can't really
do with FDT at all.

> > I can't tell the difference between what it's doing and what SOF is
> > doing, the code I've seen is just looking at the system it's running
> > on and registering a fixed set of client devices.  It looks slightly
> > different because it's registering a device at a time with some wrapper
> > functions involved but that's what the code actually does.

> SOF's aux bus usage in general seems weird to me, but if you think
> it fits the mfd scheme of primarily describing HW to partition vs
> describing a SW API then maybe it should use mfd.

> The only problem with mfd as far as SOF is concerned was Greg was not
> happy when he saw PCI stuff in the MFD subsystem.

This is a huge part of the problem here - there's no clearly articulated
logic, it's all coming back to these sorts of opinion statements about
specific cases which aren't really something you can base anything on.
Personally I'm even struggling to identify a practical problem that
we're trying to solve here.  Like Alexandre says what would an
mfd_driver actually buy us?

> MFD still doesn't fit what mlx5 and others in the netdev area are
> trying to do. Though it could have been soe-horned it would have been
> really weird to create a platform device with an empty HW resource
> list. At a certain point the bus type has to mean *something*!

I have some bad news for you about the hardware description problem
space.  Among other things we have a bunch of platform devices that
don't have any resources exposed through the resource API but are still
things like chips on a board, doing some combination of exposing
resources for other devices (eg, a fixed voltage regulator) and
consuming things like clocks or GPIOs that don't appear in the resource
API.  We *could* make a new bus type and move all these things over to
that but it is not clear what the upside of doing that would be,
especially given the amount of upheval it would generate and the
classification issues that will inevitably result.

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/g7rsACgkQJNaLcl1U
h9DSKggAhfCDV1DtqQcqFWmEf71EctSZmBw/wFXh4jJLz2YiDQfdfb47IE0G77QQ
mVgjLvUJc8cnyNASB6688PiDZAs9dbuZtQXSFNHfZ9xUAlLJrBzTln5F2zIb2Al9
9KdOuFf8ba1yQbSYM0//mj9QOzGqYKijeENExwvY68n8MyZRK1OkZoY450GPkzo2
A2x7daMtTh7jXg7sSVedM2UYENxmoR9SCZLQWH7iR4rXD7sDGRR2CqT5x6Br45/3
VPJvjJAn/EkCpIj9EDwICvC5ux6aXTG9yQVB4NfiQ2V7vR5Bm0MjfgHoF3mVdOPH
p6HNRk3s5haMLHRwy/HCxJkyKJQ4qA==
=A+iW
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
