Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F86C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:59:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B16820795
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NkD/VqYo";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="oDhWeNe+";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fu8+KmVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B16820795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DB531800;
	Mon,  5 Oct 2020 11:58:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DB531800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601891959;
	bh=j7Hb1wf+e5XjEJLlP3xxbR10RaE/X6Xn+BPDC4KLb4A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NkD/VqYo/SENZ/0zpoE9EHJKLAtitXsKgN0pv4E/M0cyhJ+nyPqdkleqx1gOCaoj+
	 c9tgIOY6v1m7IDEmYSrPs40bph+rwBB+122D2c2UAjeuRYbWFCFoVpUaeMnaz8mKAU
	 7TVjDMTSiBDzpUeG5G85qEE7+fRUynNPhdecWDS0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9747F80269;
	Mon,  5 Oct 2020 11:58:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DAEBF8026A; Mon,  5 Oct 2020 11:58:07 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7644CF800EF
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 11:58:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7644CF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="oDhWeNe+"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="fu8+KmVy"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id CB9F55C00E3;
 Mon,  5 Oct 2020 05:57:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 05 Oct 2020 05:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=j7Hb1wf+e5XjEJLlP3xxbR10RaE
 /X6Xn+BPDC4KLb4A=; b=oDhWeNe+V1p85nICHNZPjUEgFbmHgTjAn1JqLfMnqbJ
 Nb9gb/OjwZimkvQkOnIzq3VvLYQLImMGRvngcnp7gsfQrRBbDSjvPsLmoG9cxj2v
 7MjFXd28Yg+sMmi+u4AtoIxKp8+YdcivdAFV/cV3fAdhWOGf+2gzx2a9jEsZRdso
 C1GFXn2WwDuJ2dceq5R/osb2JQvMTtaklCy5LdG/EQTaOyKPO7bCsbcZt/x5dCGj
 mkMTBe/Ym4pydFg4FwgJykU8ZBE46wOW3jVjxdPeM+ztOnXArLRcenZlKWOLp05V
 meuJW9jwbnJPLjDmDLevKViNfmNlGHOLyazdcw472+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=j7Hb1w
 f+e5XjEJLlP3xxbR10RaE/X6Xn+BPDC4KLb4A=; b=fu8+KmVyRjXapYgMzwSA2/
 xOQOgz36o7cwei1LZ+5zCUAV7BuhLku2NlBR7/j6AL0162hJ6IJxs11d4qPQbwC7
 aBivzEgsBgiRXIE0/G4gBF/aKARQeJEpO5RpksRwwwvkBNIPo3X51wZzIJPhJA3s
 0DSayrLrDcoLFybFMix3i9mUJEZ/QNGNYo3HpgAeyNd/8d0wCnNwYPLnVERmjPgh
 a1F3Mx92Q0k5MVRY/yzpuGILGL3YFe5bMjfXeaX9SpvJB1HcQWpMIfIn5CHZxp93
 oxZGvGP8XfzBCroeKNVueExFEyFLk+xhPuZe796lSFbyCUSdvzQjEyJeB0cBSgag
 ==
X-ME-Sender: <xms:Ju56XzqDx-kQHhmGroWAiGAesDbZKCI5jnV8UHja5B21ulCSaRyMAg>
 <xme:Ju56X9oXR1fgOiamlVxDDEjbDLC7RQqEPsxO_THphoNuxT9bqGITGGNyHebzV_6qK
 omvXhF55fx-cPtT2vM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgddvfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Ju56XwNcCwlQmbJGX05FrHdpj3hq5NjMw4_JAxW5CRzOtEo9fzZBTw>
 <xmx:Ju56X25LKMA0ODq_WoqbTnMvegB8GoWy7kxnTmc9ql9h8bJa-ZL9CA>
 <xmx:Ju56Xy62mC7Omi7c8jFSCpkXGw1uc8MbN0OFeTP6zzCEVz-Yoj5Xtg>
 <xmx:Ju56X5ZMbjixJ5dJRzvtHjedzE4JrL10FY3MeHZIAUyPTqHwkviiPw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 46FB03280063;
 Mon,  5 Oct 2020 05:57:58 -0400 (EDT)
Date: Mon, 5 Oct 2020 11:57:57 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 05/25] ASoC: sun8i-codec: Correct DAPM widget types
Message-ID: <20201005095757.ddu77zku3qgvteqw@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wxerx6zzkh5xrucc"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-6-samuel@sholland.org>
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
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


--wxerx6zzkh5xrucc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:28PM -0500, Samuel Holland wrote:
> Whie the aif_in and aif_out widget types are handled exactly the same in
> the core DAPM code, a future widget event hook will need the correct
> widget type to derive the associated substream. Clean up the widget type
> for that reason, and so these widgets will match newly-added widgets for
> the other AIFs.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--wxerx6zzkh5xrucc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3ruJQAKCRDj7w1vZxhR
xb0IAQDeWgRLx9mDjKVNJCLUkFj/IKyXKEUtH3jABqwczUj0QwEAy981d8ABWYw0
6QNUDXOb/Ijb1sIGwFNv3ImMCOhd+g0=
=OvNO
-----END PGP SIGNATURE-----

--wxerx6zzkh5xrucc--
