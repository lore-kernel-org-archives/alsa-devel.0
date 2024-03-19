Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B67C54E5D
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Mar 2024 11:40:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EA542B9E;
	Tue, 19 Mar 2024 12:39:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EA542B9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710848407;
	bh=a9LABPO+CYbvx/7Gpe94EEwFR13WLKPOt1b2pIlrC+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GmvhHf3KfO5P09I4cP+KiyHhT7MdrHfr9TAvRBC1BHDhwx3gHsqLpTbgvKsy9yVMs
	 4ndqsNMePoM5ar3nAixi5kyKcxcI59mJqQLlykKxCP9flHzbtwFNVXfonMlLjYK5zL
	 EpHxZYVimvC8qCzqh62bIIikBtcza2JnozL4xuoc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EA14F80580; Tue, 19 Mar 2024 12:39:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 014E9F805A8;
	Tue, 19 Mar 2024 12:39:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5176CF804E7; Tue, 19 Mar 2024 12:39:28 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1669DF8025F
	for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2024 12:39:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1669DF8025F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=InWGZqKl
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5701660DED;
	Tue, 19 Mar 2024 11:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C734C433F1;
	Tue, 19 Mar 2024 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848354;
	bh=a9LABPO+CYbvx/7Gpe94EEwFR13WLKPOt1b2pIlrC+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InWGZqKl48G5b0FZUSH2IqMWUTzWU0KBtWuy6phWp9Up4Db3+R3ofr77YImPuuwCG
	 Xwwszz3eXUNn7IQteZ/ceyrUoief2Zy64qzlVavUKpUurK/gJ/RBOMxel/ayeK6xy+
	 hnU0/5dYnw9UxE9wtI4CxV7KVx2q+OoZqFvC9+5gLa0ffc3jrTFCYUknbdk0lVSbZm
	 xwI7hXvkqWON8S71sipY2TW3rirFnbrB5Wjn2fGpt4GttTNe6AyWwjMiweDc7GJyJg
	 gQ7wzxp1X6XkvhLrDhzCtWWqNXUPT3CHngbvEcNnxgqSkkt260g2DgrBt2g4bkKsRT
	 0oS4lNXpkiFxw==
Date: Tue, 19 Mar 2024 11:39:06 +0000
From: Mark Brown <broonie@kernel.org>
To: cujomalainey@chromium.org
Cc: alsa-devel@alsa-project.org, Wojciech Macek <wmacek@google.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rander Wang <rander.wang@intel.com>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: SOF: Remove libraries from topology lookups
Message-ID: <88bee4a5-f374-4b96-93c7-0402a95725b3@sirena.org.uk>
References: <20240318183004.3976923-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/mYLy7erHPd9NeG0"
Content-Disposition: inline
In-Reply-To: <20240318183004.3976923-1-cujomalainey@chromium.org>
X-Cookie: You were s'posed to laugh!
Message-ID-Hash: CT4EMLVFYXG6ZSXA3BR5ARXKSKSB3PLZ
X-Message-ID-Hash: CT4EMLVFYXG6ZSXA3BR5ARXKSKSB3PLZ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CT4EMLVFYXG6ZSXA3BR5ARXKSKSB3PLZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--/mYLy7erHPd9NeG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 11:29:54AM -0700, cujomalainey@chromium.org wrote:

> If a OS wants to use 3P (that they have licensed) then they should use
> the appropriate topology override mechanisms.

A user who's bisected a problem to this commit might welcome some
pointer to what the appropriate topology override mechanism is.

--/mYLy7erHPd9NeG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX5eVkACgkQJNaLcl1U
h9DjlAf+Kp4Sjcep+eR5OaV2GwkpCx4pha/8lkH+q8Y6PPCXsuWilFl1akA9cbBw
u3NsIu6y8FiZRIw4jVNhgZNE1CddrM+qF3Ieqbsz5J/wz6SbT36CNnNfMea4aKCG
UKD9eVMZRl76wwV8foVvs0FuToYgph5skRbnFEaULoAYBmRoNDFJpFsOikvER3U6
nsqAVdAYbMk5Ys3nPd3XmHinQtt83uD56JII5K31Rnd/L3WMz0oHJMQ6LyVdw44y
8jW8K3aQjFMjKmo8/4jXz9g2UwWlyyBkDl1QzLrkezlEsWa+qYbVOJicjMRBchTL
fTXsC0qhux4Bxp7sfJO6xNimXydqpA==
=7i87
-----END PGP SIGNATURE-----

--/mYLy7erHPd9NeG0--
