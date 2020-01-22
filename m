Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A710BC2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 20:26:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9EA24655
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 20:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F+f8uaM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9EA24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EFB11685;
	Wed, 22 Jan 2020 21:25:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EFB11685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579724788;
	bh=IfUeO+/KHJsvBdlfo5lHlHDa2IQ2q0b81rzI2EKwtsw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+f8uaM5j0lddJleNALZxbCfgLhEoHhE8QfQ2zQAjl9K6gwZ5ZeZdT37ClOujw0gH
	 9Wd2TkxMvTIjCYxaVgr4nQkubY0A/fbJk8VynDJSRoBKfms0gUlLT8hqVOAOzYs8rN
	 /t9bUVG46n4HVjMgjjK7HrhZTf9/e5AE77BHLQ3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C31FF801D8;
	Wed, 22 Jan 2020 21:25:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F06BF8020C; Wed, 22 Jan 2020 21:25:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id BA5F0F800BA
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 21:25:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA5F0F800BA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BBC031B;
 Wed, 22 Jan 2020 12:25:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07C7E3F52E;
 Wed, 22 Jan 2020 12:25:31 -0800 (PST)
Date: Wed, 22 Jan 2020 20:25:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20200122202530.GG3833@sirena.org.uk>
References: <20200122190752.3081016-1-perex@perex.cz>
 <26ae4dbd-b1b8-c640-0dc0-d8c2bbe666e2@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <26ae4dbd-b1b8-c640-0dc0-d8c2bbe666e2@linux.intel.com>
X-Cookie: Sorry.  Nice try.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Sasha Levin <sashal@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: topology: fix
 soc_tplg_fe_link_create() - link->dobj initialization order
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
Content-Type: multipart/mixed; boundary="===============7014029104770404780=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7014029104770404780==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2020 at 01:28:57PM -0600, Pierre-Louis Bossart wrote:
> On 1/22/20 1:07 PM, Jaroslav Kysela wrote:

> > The code which checks the return value for snd_soc_add_dai_link() call
> > in soc_tplg_fe_link_create() moved the snd_soc_add_dai_link() call before
> > link->dobj members initialization.

> > While it does not affect the latest kernels, the old soc-core.c code
> > in the stable kernels is affected. The snd_soc_add_dai_link() function uses
> > the link->dobj.type member to check, if the link structure is valid.

> > Reorder the link->dobj initialization to make things work again.
> > It's harmless for the recent code (and the structure should be properly
> > initialized before other calls anyway).

> > The problem is in stable linux-5.4.y since version 5.4.11 when the
> > upstream commit 76d270364932 was applied.

> I am not following. Is this a fix for linux-5.4-y only, or is it needed on
> Mark's tree? In the latter case, what is broken? We've been using Mark's
> tree without issues, wondering what we missed?

He's saying it's a fix for stable but it's just a cleanup and robustness
improvement in current kernels - when the patch 76d270364932 (ASoC:
topology: Check return value for snd_soc_add_dai_link()) was backported
by the bot the bot missed some other context which triggered bugs.

Copying in Sasha and Greg for stable (not sure if the list works by
itself).

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4or7kACgkQJNaLcl1U
h9AlFAf9GdHLtyqqHm/oAX8vYaBlzhtllzk3dKrVF51LCH5SfT4IjLbjo98Jwqry
DfJAww08q99muDghi/G0ZXEx9xDszoCztyW4qp7CHK0P059Y4GEGzP9N1Dvb1BfD
RQsnabaekuh0AD0TykUIvwG/a/NCAWLSRc033WL/iGFlQ46BOnXD2QwcaCI9KY3l
OBX3eXh692YUqFVuOuoA8udZGi0fTQyrHpzc6YmOsDpvxwenm7wh6R28UH7Pi4YR
r4ALhsV6opuUZXIzIbnNHne6Q7k2NfxGgWlaax+gaZpOoZs+vKMFRnm5E1hi8j4a
6ENoV1eW/T1irjGFmygmDVN6/VAS6g==
=aOM6
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--

--===============7014029104770404780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7014029104770404780==--
