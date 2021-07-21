Return-Path: <SRS0=DIBW=MN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2241C12002
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jul 2021 13:00:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2D86121F
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jul 2021 13:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2D86121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A63A16DA;
	Wed, 21 Jul 2021 14:59:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A63A16DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626872417;
	bh=bPx0RAOvqG2V51PSqVvLYqrpRgZ/GNWQlBdocKw4EY8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvenfq6jkPctMrQvAd+kRTWPURrifuZdExIUxNvxKvk0LoQwHj73rE0qakMiZM2w7
	 xkdkuD7hvad2nnKlq6+U0S6E8uRazT5smnrUPmMll2AIh/+CDuydGPgNql8Czi7O4d
	 37je7+ZVdvnJtZlUTQZmDOAPcVyJ/r+VEj7O6lKU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70EE9F804AB;
	Wed, 21 Jul 2021 14:59:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F689F804AC; Wed, 21 Jul 2021 14:59:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52647F800DA
 for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2021 14:59:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52647F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i3Skps0n"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D980060FE7;
 Wed, 21 Jul 2021 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626872357;
 bh=bPx0RAOvqG2V51PSqVvLYqrpRgZ/GNWQlBdocKw4EY8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i3Skps0nqx3kwVYJZQiIecCdTbqvHIYkUvpo9OaGrPjgAvT8UOB72JUq23AFRqkIX
 LrtLCGRdochrsAmsYS/XsBIRdQZ9swcdV9zKsAZsBeuVqhIrVIyDlNDzucCsKJFaCn
 KH9f7gP10SwLIHgc35OxsZGkg7J1Kw7xYURLxnQwPe6KaA9yVquNTT++GbC+QmnVHg
 j4oN/aVVquNW0JM9a3HXZ3Hpd0NeVd4mAHo+SNWJBkd6P9cK7YCXmJ3eJgybxZplvv
 x5wuyZHMhSuNMejpOLsLHebx+3Wm16c30PFcOjqscTNZnig92azTHiePbNpfrgGpd/
 lH4VcNBF4uNjQ==
Date: Wed, 21 Jul 2021 13:59:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
Message-ID: <20210721125912.GE4259@sirena.org.uk>
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com>
 <20210715143906.GD4590@sirena.org.uk>
 <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
 <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
 <bd85ea7c-e9b5-de67-07ce-7104a1e19805@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <bd85ea7c-e9b5-de67-07ce-7104a1e19805@linux.intel.com>
X-Cookie: Many pages make a thick book.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Daniel Baluta <daniel.baluta@oss.nxp.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Daniel Baluta <daniel.baluta@nxp.com>
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


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 20, 2021 at 10:28:57AM -0500, Pierre-Louis Bossart wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> - we currently don't support 'shipping the topology and firmware
> bundled up in a single image to avoid them getting out of sync'. No
> idea how that might work.

Seems like it'd be trivial to arrange in the kernel, or with userspace
firmware loading the loader could do the unpacking.

> - if the machine driver is specified in DeviceTree, then the topology
> used is *required* to be aligned with the machine driver. The rules
> are that a topology may not make references to a BE dailink exposed in
> the machine driver, but conversely if the topology makes a reference
> to a BE dailink that is not exposed in the machine driver the topology
> parsing will fail. It's one of the current weaknesses of
> topology-based solutions, we have non-configurable hardware-related
> things that are described in topology but should really be described
> in platform firmware, be it ACPI or DT, and provided to the topology.

That seems like an orthogonal issue here?  The requirement for a
firmware that's joined up with the hardware (and system description)
that it's being used with exists regardless of how we rename things.

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD4Gh8ACgkQJNaLcl1U
h9AEtwf+M4F9zXszQKCGjEhLkfF89T99hn0KNEo1eSDdfDW87K02IGExMcgDP3fE
+6NDVnHafyIeJf3AOwQhnuV7/3O9FBnhl2GFrLLENQCZS9lAUmD/eYthE6zNB6Sd
bA+8c0mIIA+ET2VEKzCOWEPK1E9ZKXFp9nN3EPPIdUEOiV/H1NlBV9V3IBTyKIQl
HnKC80MfJRrKEYEeNwZtRq56v9sGxAfVfhUVobthcJbfA7nGHqmEnlNp8O8Kc25G
yOKTXknjkzCH4hSTmkWILd2/O6cM7Qdz4viIi1g+u+aH9qDm8hldPePsM3ME89jf
FKEI2FjObAjR2wc+SudofZkK3BgutA==
=UblC
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
