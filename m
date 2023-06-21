Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CAFEB64DC
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 14:40:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 703A782C;
	Wed, 21 Jun 2023 16:39:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 703A782C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687358440;
	bh=VXBvW08YHCjFJUo8Y3I1beTInLzEQKnsdmhPOK4bYIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nI/zmL0mvUxIqt/Uj/fXqX7lTi0tWywwIc9rNcyLxpRFf6PpBAvfDx+HOV89YWo7T
	 BUIHZrlVZvyxegsk/RDDdVfd/duk38A2sW2JXTRpVLboWY+Xo/4/zk+DiQzsSTRNGg
	 /XEqseCvr466kihMu9foiBy59SKr7rVvaD5EeLBE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8EF01F80169; Wed, 21 Jun 2023 16:39:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 26DAAF80169;
	Wed, 21 Jun 2023 16:39:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28492F80141; Wed, 21 Jun 2023 16:39:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B5F1F80022
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 16:39:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B5F1F80022
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tZl1k1F0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DACDC61576;
	Wed, 21 Jun 2023 14:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C34C433C8;
	Wed, 21 Jun 2023 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687358358;
	bh=VXBvW08YHCjFJUo8Y3I1beTInLzEQKnsdmhPOK4bYIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZl1k1F0ZcAed6cyywzNyeNFbJ7D6LC6xDLfFbVBm2LiVc0WmmIBNSjNUlr6y4Q6c
	 rJpTjq0rjslE8kERMZNeE2zcPY3jxdT9ITE+Pz7qR78CSkCef7gSlpSVKVJiPXtMtq
	 hmdokXAc3JVSVmgu5FhkQ1pzAjoIF1f7E6t42PDhxgPHYycyqhX2rcVAsZQNz24xKh
	 es6lnaa0+8Xq6joKOvOZr0nHG6PvKgVnojHtrULUOYyRhvTgmKPN8D56nB9aEa+bMi
	 5KqpBXJ4p19QxRnGye8BhGeFJRMBjIcxvq1/75EWokHyNOoRUhTPwcGb8cTK/e1z9i
	 PxmFblnHkgLcQ==
Date: Wed, 21 Jun 2023 15:39:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
Message-ID: <9069ad0c-d166-4620-a3de-a36ab233cab0@sirena.org.uk>
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-3-nfraprado@collabora.com>
 <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
 <443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lN6DZShoSnw04Qtm"
Content-Disposition: inline
In-Reply-To: <443f697b-fecf-6e8e-0b76-65257aff7da8@perex.cz>
X-Cookie: When among apes, one must play the ape.
Message-ID-Hash: JBKDGEXFJTWGT7HRKAHVFHKYDINQDPFI
X-Message-ID-Hash: JBKDGEXFJTWGT7HRKAHVFHKYDINQDPFI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JBKDGEXFJTWGT7HRKAHVFHKYDINQDPFI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--lN6DZShoSnw04Qtm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 04:08:47PM +0200, Jaroslav Kysela wrote:

> I think that the problem is somewhere else here. The overall test timeout
> should be calculated dynamically. All tests may be queried for the maximal
> expected interval based on the hardware/software capabilities. It's a bit
> pitfall to have a fixed time limit where the realtime tests depend on the
> number of devices.

I tend to agree here, unfortunately Shuah hasn't responded to queries
=66rom N=EDcolas about this which I imagine is what inspired this patch.  We
also have problems with mixer-test on one of the Dialog CODECs with a
couple of 64k value controls and no cache only mode.

--lN6DZShoSnw04Qtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSTC48ACgkQJNaLcl1U
h9BGbwf/Tdjkixv5SETg00LJp+l4cOfv6sRpMFmm0MjvB7B8F7D8D4fFtu8vwLCk
1pVCzZ2Z6WSbnPBMlVDSWV9ns+VBPoXD/W9R1OBx+IgQLyqr/FXUvQFed3MvQSrt
uOHg5udSeoLyfhpGMgbHRUEy2yFjt+jJNvlPn5GPk0W9gDQ540afmJStnKzyOXrW
8eL8q14TSSzn41yRaOZSN5K6Qx5vu/qDOxk2qKr9pUAkVABHVd1BBqzoysINKWEk
++RHedjGxb4PrspUa5io2mzmDkd3VzoQu+ReCxSbLerIa45KG2oev+o9kSFK2Lbu
juIvTAHQ21sYmy6eHgoLaxAshfYtyg==
=GpWQ
-----END PGP SIGNATURE-----

--lN6DZShoSnw04Qtm--
