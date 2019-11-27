Return-Path: <SRS0=87PQ=ZU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA9C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 06:22:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F92215E5
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Nov 2019 06:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rggBXQSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F92215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C634C16D6;
	Thu, 28 Nov 2019 07:22:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C634C16D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574922175;
	bh=gv0vp0YSd7GJ2JyI8y5vBm+LDsFz6Fy/pfLkTRYkLXY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rggBXQSwX9Q8TJ9aPdtLEWh2WpPelApbn8P+mYdLDSGCfGyG55pQmYdB/VeWpiZ1u
	 rLMAZnYRdyDrAwQMXSVx2EMzzmIRYvESBi/BVN0kZfMi2dvR3QuhazV4DlhyeMV+Y9
	 Ysfz5ZDONWCd73OrR24jrOVkPVyen7YrAL4kAXFM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E246F801F2;
	Thu, 28 Nov 2019 07:21:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA30AF8014D; Wed, 27 Nov 2019 22:30:42 +0100 (CET)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF401F80109
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2019 22:30:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF401F80109
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 6ECFA1C228B; Wed, 27 Nov 2019 22:30:38 +0100 (CET)
Date: Wed, 27 Nov 2019 22:30:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Sean Christopherson <sean.j.christopherson@intel.com>
Message-ID: <20191127213037.GB20612@amd>
References: <20191126165417.22423-1-sean.j.christopherson@intel.com>
 <20191126165417.22423-12-sean.j.christopherson@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191126165417.22423-12-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Thu, 28 Nov 2019 07:21:07 +0100
Cc: Mark Rutland <mark.rutland@arm.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-efi@vger.kernel.org,
 linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, "VMware,
 Inc." <pv-drivers@vmware.com>, Jie Yang <yang.jie@linux.intel.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <nadav.amit@gmail.com>,
 linux-acpi@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, x86@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Len Brown <len.brown@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Steven Rostedt <rostedt@goodmis.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 platform-driver-x86@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>
Subject: Re: [alsa-devel] [PATCH v2 11/12] ACPI/sleep: Convert
 acpi_wakeup_address into a function
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
Content-Type: multipart/mixed; boundary="===============6739124504538289529=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6739124504538289529==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-11-26 08:54:16, Sean Christopherson wrote:
> Convert acpi_wakeup_address from a raw variable into a function so that
> x86 can wrap its dereference of the real mode boot header in a function
> instead of broadcasting it to the world via a #define.  This sets the
> stage for a future patch to move x86's definition of the new function,
> acpi_get_wakeup_address(), out of asm/acpi.h and thus break acpi.h's
> dependency on asm/realmode.h.
>=20
> No functional change intended.
>=20
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Thanks!

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3e6v0ACgkQMOfwapXb+vIvKgCgj+csmgRVJU3LjSgRtQ9xs4OL
1n8An0cFCD4JerAugYVERVISU8Tw+N8s
=cvdZ
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

--===============6739124504538289529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6739124504538289529==--
