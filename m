Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E957C072A2
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Nov 2023 20:41:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7801AA4B;
	Wed, 15 Nov 2023 21:40:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7801AA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700080877;
	bh=a4uLY3fIHjIzDckMdLNrHHH7XSdcsX+bPwoA2MErrtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fqvtX6argrMqM9kGGHjN96O3/C13BzNnMXf9sZLJ9gutkLc29bAcwUfqgmKfdnUap
	 xPqeXo/3xfcuUL+2Vk/Kcs6cg6dJyHFVp4NMILbuWW1GF8TF0oixH6JhsE7HT/pQNO
	 eCFJPZxdFjRfzqwiMykALv5qC58akc0XSw530olU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 039CCF80093; Wed, 15 Nov 2023 21:39:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 99D9FF80093;
	Wed, 15 Nov 2023 21:39:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D89FF801D5; Wed, 15 Nov 2023 21:39:49 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DEA63F80093
	for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2023 21:39:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEA63F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qoik11g4
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CADB6CE1F16;
	Wed, 15 Nov 2023 20:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B5AC433C7;
	Wed, 15 Nov 2023 20:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700080780;
	bh=a4uLY3fIHjIzDckMdLNrHHH7XSdcsX+bPwoA2MErrtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoik11g4gNU1aUqgSjzeEpuYyRrJKFcqy38dEg3ZYGo4cmT27NuU7nx/I6p53p5nH
	 57G4wRKv9JoRW57oi5UJBFVQNW5aEmmolLLRJ36sy3CG3VXKH01BrC5cicvQk8VYQt
	 5SEWrbdT1oZMi8RK4TAx73/5RDKHapkujQUzI5ydj4w3NatL0sAi7NgVY9D9BDBGD9
	 EDzv82RiFlkC0oUjSOYYm6cbchHjBTh3ElvzYd1EqIh+lCMIHlZzEysFckIBFmmbR0
	 H0O9bB0iRqh/I0H+kO6avWOzRBWZIFfhKeCjiGElcF7RjSGfovjMiuye5FiDBT8jWw
	 CMa76D7v1XgBg==
Date: Wed, 15 Nov 2023 20:39:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 00/16] ALSA/ASoC: hda: Address format selection
 limitations and ambiguity
Message-ID: <2306e2e1-b665-4dbc-91ce-a31e062f06bf@sirena.org.uk>
References: <20231114201317.1348066-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2eW1j2ZDPlKeZe5"
Content-Disposition: inline
In-Reply-To: <20231114201317.1348066-1-cezary.rojewski@intel.com>
X-Cookie: For internal use only.
Message-ID-Hash: IYRLNNZMTPYGTZMJ7FNNEGH7YN4NJOZ6
X-Message-ID-Hash: IYRLNNZMTPYGTZMJ7FNNEGH7YN4NJOZ6
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IYRLNNZMTPYGTZMJ7FNNEGH7YN4NJOZ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--t2eW1j2ZDPlKeZe5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 14, 2023 at 09:13:01PM +0100, Cezary Rojewski wrote:
> Patchset aims to address format selection restrictions present currently
> in the HDAudio library. Formats which we are concerned about are 20 and
> 24 valid bits per sample within 32 bit depth container. One may identify
> them as S20_LE and S24_LE except that those, according to comments found
> in include/uapi/sound/asound.h, are for LSB-aligned scenarios. HDAudio
> streams expect MSB-aligned data, no matter if we are speaking of HOST
> (SDxFMT) or LINK (PPLCxFMT) side - chapter 4.5.1 of the public HDAudio
> specification. In short, S20_LE and S24_LE are invalid options.

Acked-by: Mark Brown <broonie@kernel.org>

--t2eW1j2ZDPlKeZe5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVVLIYACgkQJNaLcl1U
h9AY/Qf/TN1EqWVx9qTD9pudDMK8HzSZoVKOW35AmAyge5R/pb7SZ/eXe1/1kh7t
/67MhOj9tUn95YiqmetoxJ7Ahc3Gij9mOpdz0ysRCToydnBqhW9z1Qeipz8NXKCX
vz3D6G7wWOhlDlPrzqN21lFhyFM2XaEiV+bMZBp8nDCpf39LizlC8tXbc9J/Wsuj
w6qP8AMQS8+M4lr+uJHOLz9tqzwGa8Db8ToOzOAW5K7xe6XijiXvkHIzlbvpMoln
JH7LrJHpbxmLfqfdke0vTXraHBAsb5fhY/ak0AijCY/REWjph/myNW7N2Ku1ofp9
J6Qx8abCQyNN0Ka4yVXtt/JVfL8UKw==
=1aO0
-----END PGP SIGNATURE-----

--t2eW1j2ZDPlKeZe5--
