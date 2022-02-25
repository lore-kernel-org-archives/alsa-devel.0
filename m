Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD750C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 18:08:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD7F91F0F;
	Fri, 25 Feb 2022 19:07:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD7F91F0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645812513;
	bh=s5EL6NPoAEimHFJ9W6qaf6XWSmF6Kno9CtqYY54k+nI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aEwczQEzh2pNEKm4I3+OctCt6dnoUEy/vMKo1Ivfqr7baVu/T6rTbLVqDqXderh2S
	 QMUNUU9Bw1ubTPzpLvpvBX51m/mdaKcYwCHFgp3A26SS8B4uCE9z3a7IAK9z/XFrol
	 yijk987Imzr8QwLFRWmyGfUGBAwfg50xCwkrdFqI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53CE6F80159;
	Fri, 25 Feb 2022 19:07:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16A7FF80132; Fri, 25 Feb 2022 19:07:42 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD58BF80132
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 19:07:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD58BF80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BUOazG4w"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5F79560CA0;
 Fri, 25 Feb 2022 18:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A2BC340F0;
 Fri, 25 Feb 2022 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645812456;
 bh=s5EL6NPoAEimHFJ9W6qaf6XWSmF6Kno9CtqYY54k+nI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BUOazG4wuRXzZaDxvyAkhLOFZTOCOX7wjNd5J8v286DcIDWaoTNU3NW/vc2Y+LUc5
 GvzoDJhCYfSOxuwXVZnmtyDuURdyDVXsy2Bo3rr+gnhm7txkRK57vljoU//aLVhcGa
 nOYfZvaHYDVSPavef9/qq18qEexpDfQgacLHC26jfcsIAtKxRwIup6qU77e5+emgNc
 Ec3Nl7Cj3+fwbA9oXL6Dc3JA9BjeWEQjryvdVXT8dlo6uwMcDdq/eWFumILrPFhO9u
 An6Ww4yCr8iM712rejsxqSHlcb9cPGGQvpZR/HqequYMzEdB3HxJ5STNWlc5EphWUK
 wrUfVoWL0fzIQ==
Date: Fri, 25 Feb 2022 18:07:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/17] ASoC: Intel: AVS - Audio DSP for cAVS
Message-ID: <Yhka40f/NBrK0/LE@sirena.org.uk>
References: <20220207122108.3780926-1-cezary.rojewski@intel.com>
 <702df428-e972-fcdc-c250-c0a73c4d2ba8@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ScvzxkveL9Ejdfa2"
Content-Disposition: inline
In-Reply-To: <702df428-e972-fcdc-c250-c0a73c4d2ba8@linux.intel.com>
X-Cookie: I smell a wumpus.
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, rad@semihalf.com,
 upstream@semihalf.com, harshapriya.n@intel.com, tiwai@suse.com,
 alsa-devel@alsa-project.org, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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


--ScvzxkveL9Ejdfa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 24, 2022 at 08:35:50PM -0600, Pierre-Louis Bossart wrote:

> leaves the next steps completely open. It's not quite clear to me how
> the previous feedback on trying to up-level the DSP management
> functionality might be handled, and if/when you are planning to submit
> follow-up patchsets that would implement the required functionality to
> at least match what the Skylake driver can do today.

I think it's fine that none of the complicated stuff is considered here,
one of the objectives with splitting things up into multiple serieses is
to ensure that the simpler stuff doesn't obscure the bits that need more
attention paying to them.

--ScvzxkveL9Ejdfa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIZGuIACgkQJNaLcl1U
h9BOqwf+PFurxwKU2FSoroY5j6az7ZL6rJm32f9dY4DuCk0F38qG+cMYiHvZQXha
+lzPyJ+ne7qsD1/174QxqrtqJ0bH3GmqD3EBvNPRzhgFTyLJiGVANPYshS8MX99L
Fr0CaaZozBp8iFI0KU2YugZzqSY2W296Gp3GUuelYjev+yUzgT0qyPa2ugfiZRUJ
JCgJkjgfqZE4XVsOWwSUhcM3jcrz5GWRB8hmydZymIger4lOtdhSH0jOeAzk/ay1
5E3yXULeMp/259WRhlO5Twmn1JBcPScapSrYdVZHM3VvYXQcQt47Rjas1RGeoD30
Nemr1QH3Yzzpdl6d8YVW4rHkIobtrA==
=XK2g
-----END PGP SIGNATURE-----

--ScvzxkveL9Ejdfa2--
