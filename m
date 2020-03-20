Return-Path: <SRS0=JibJ=5F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79E0C4332B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:20:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9AC2072C
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bSQCZGLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9AC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF61317B2;
	Fri, 20 Mar 2020 13:20:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF61317B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584706853;
	bh=JP0Wynzh89rZt1JAstIjFy1I5AH6fMYbvZc07MELZHA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bSQCZGLoukhwvb2+oIOWMAiZ13Kq6y7FpmTj1U/A6zRli0SXvM9TvQU/d+OUnMhyf
	 Pezu+KAtI568E50aWBCDV/+hjGnvyke4g74s7Rr2IrHEc2bBZUaiVBlw1VfE9+5vPP
	 DAjx4sRoPZ+KR1L37io52yvDFGqHL/5OFz53nYls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EDCEF800C0;
	Fri, 20 Mar 2020 13:20:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9013F8015B; Fri, 20 Mar 2020 13:19:59 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 82B5CF800C0;
 Fri, 20 Mar 2020 13:19:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82B5CF800C0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CE3331B;
 Fri, 20 Mar 2020 05:19:54 -0700 (PDT)
Received: from localhost (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01EE93F85E;
 Fri, 20 Mar 2020 05:19:53 -0700 (PDT)
Date: Fri, 20 Mar 2020 12:19:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH 06/14] ASoC: SOF: add a power status IPC
Message-ID: <20200320121952.GC3961@sirena.org.uk>
References: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
 <20200312144429.17959-7-guennadi.liakhovetski@linux.intel.com>
 <20200313143956.GJ5528@sirena.org.uk>
 <20200320115203.GA2130@ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20200320115203.GA2130@ubuntu>
X-Cookie: Laugh when you can
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org
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


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 12:52:03PM +0100, Guennadi Liakhovetski wrote:
> On Fri, Mar 13, 2020 at 02:39:56PM +0000, Mark Brown wrote:
> > On Thu, Mar 12, 2020 at 03:44:21PM +0100, Guennadi Liakhovetski wrote:

> > >  #endif
> > > +	atomic_set(&sdev->reset_count, 0);
> > >  	dev_set_drvdata(dev, sdev);

> > Do we really need to use atomics for this?  They are hard to use
> > correctly.

> This variable is accessed from 2 contexts: it's incremented by the SOF=20
> driver, when the firmware has booted and it's read by the SOF
> VirtIO backend vhost-be.c when receiving a resume request from the guest.=
=20
> Timewise the variable will only be incremented during the DSP resume /=20
> power up, while the VirtIO back end is waiting for the resume to complete=
 in=20
> pm_runtime_get_sync(). And only after that it reads the variable. But tha=
t=20
> can happen on different CPUs. Whereas I think that runtime PM will sync=
=20
> caches somewhere during the process, I think it is better to access the=
=20
> variable in an SMP-safe way, e.g. using atomic operations.

That doesn't address my concern - to repeat, my concern is that atomics
are hard to use correctly.  Is there no other concurrency primitive (for
example this sounds like a completion) which can be used?

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl50tOcACgkQJNaLcl1U
h9Clxgf/TuSaiB+A2YdysduRHryPVrTF9qdkgGFux2O8/4ddyE2Rbtn6qNVoBebz
K1dH1Unb6Lgwt8yjwiE+q195f9XZbxUoXMiarb/bXLmUhzmsvjSaMK5Udrza+S2V
tIxaeX14r0FdpbFoF0AEUBrRfxuNIZiL9ozx/0VDxOFtETed7BnnwmgIEJ40qvkl
6eQYyml4xOfsupfnSwwTu5f3omvX+vl28Q7dNv1mVZhh2Ksk6kGByuzNkg87rTZR
PTY3OeEFXHb7X3sByZdriQaQLmsNHZkesnEScaU9Cw/96ufH2TdUPt1WqsMRE5K7
DCYJajK/2NGjUXqp+9bh34RlAuHzrw==
=PaZL
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
