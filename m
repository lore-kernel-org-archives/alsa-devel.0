Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E6AC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Mar 2022 17:51:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A24AA175D;
	Fri, 18 Mar 2022 18:50:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A24AA175D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647625858;
	bh=50PBucF3zO+C3He1MByP3a6uyE/52lCZgw6JQS8sX4A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fU0f0OQlR9vmUecTplIKI6ImawmtmLGAoGo35IJedS0N1HV2EUx28t8jwT/WlCJL9
	 oRUPa8C/Ym0QWwjA24KPT+1IPXkfPQbRF6sfgW6xkK8DV5r95pDizKOgHH0geUV9JE
	 H27BpGwroNPv2xNj2cGjEdCL8nC2YTzL52tfTi3U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EAB6F80125;
	Fri, 18 Mar 2022 18:50:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD111F8026A; Fri, 18 Mar 2022 18:50:06 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EC39F80124;
 Fri, 18 Mar 2022 18:50:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EC39F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JO8UvdXr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D716BB824F5;
 Fri, 18 Mar 2022 17:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC4BC340E8;
 Fri, 18 Mar 2022 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647625801;
 bh=50PBucF3zO+C3He1MByP3a6uyE/52lCZgw6JQS8sX4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JO8UvdXrx/8XikzNeZ+pN54l4wv2y7djZxlnhZIpaPqx6kj8TNRbkbyIWWeXJn/i8
 kWce4J3jhFEAW7jql5Kf3LyoBvkhNRlULRG8vqFIakfn+gW8NpeoN7WiREF7YvQgRm
 1Gfte7MltB9uzADqRjERDHkKTzvITfKh/iFV+var+Rq6zad0ciZH97vL9q4JrUWaPX
 PfSuwZD5mHT0YXFbQF5zlWgcozimU6vxtRGQcNhXpUXE8jj7cm75FJ+AwpPCDzAszA
 LKCMMYVBipb3VoVF/uceUBY5xC3ZrVz+hol3CCXHtj90hMnx9T/OW534TDnYJtCrmP
 dX0BdSVovhFRw==
Date: Fri, 18 Mar 2022 17:49:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: Prevent NULL dereference in
 sof_pcm_dai_link_fixup()
Message-ID: <YjTGQ7IAcoGKQDul@sirena.org.uk>
References: <20220318071233.GB29472@kili>
 <cf4c4a84-335d-8799-7a5b-afe298881342@linux.intel.com>
 <1049c2410500a3a9ed97f83b5e41e89a74102c96.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SQ2FmoRmZfuAitaO"
Content-Disposition: inline
In-Reply-To: <1049c2410500a3a9ed97f83b5e41e89a74102c96.camel@linux.intel.com>
X-Cookie: laser, n.:
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 kernel-janitors@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, sound-open-firmware@alsa-project.org
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


--SQ2FmoRmZfuAitaO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2022 at 09:14:55AM -0700, Ranjani Sridharan wrote:
> On Fri, 2022-03-18 at 09:42 -0500, Pierre-Louis Bossart wrote:

> > This part will be removed in follow-up patches, likely the reason
> > why=20
> > this problem was missed.

> Both these problems are address in the series I posted yesterday.
> Particularly patches 16 and 18.

OK, I've got that patch series queued already so I'll skip these for
now.

--SQ2FmoRmZfuAitaO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI0xkIACgkQJNaLcl1U
h9CCewf/WRBGQBF9JWbnRaHy34OpciHnqfuv18kO2kRjPVrteLbR+XxXlsRrtLCL
TXbdI+ICdc0pRtNoLO5dC4RQN2iAPhJ/mxlYa+uzuHBis/qO2Twd1hYNasdDG8VJ
Qx/9TtAkILApwH2YdV5grYvwe1+6EAEIHM8+Cg1lpyf6DZfhUtTiJwfKSso9k6/h
FlgdGYN3SHFva49ydIsCLjaMUa35Tw1egt4zJf7T9xMBYviAj2hTf2b4UShrbWVW
0k96nOTC5w0GNxnb8eA1JMtv2tXb3HjwsiC0R7muMwtn+ezHJfyAHj8cxvLBHPRL
nIN8QH3JeaivDCpaCQSTaR97W44COg==
=+Qia
-----END PGP SIGNATURE-----

--SQ2FmoRmZfuAitaO--
