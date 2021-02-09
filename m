Return-Path: <SRS0=Hwo1=HL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C614C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Feb 2021 19:20:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E08964ECC
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Feb 2021 19:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E08964ECC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A7E916B4;
	Tue,  9 Feb 2021 20:19:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A7E916B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612898435;
	bh=jj4QbWaDC37oQBwKNqpfm9PEozOMfXe8JShYYskzF60=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CnMeBpnS9FSlfZjhg0KWFYooZG+B14JFYPKvgUyyVEXs9heWtsxny3Lfk8Z3wZtfm
	 dGavADH4yXodO5u90X8S2sKIgnuodrLJaPOnIO0EfGNqxFR4rXjN24Fu/ck/zAM9X7
	 6+dlJyMbbN4o59Yaz5AfYKhQqkqT2wSKNdBn0PTE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C3F3F8016B;
	Tue,  9 Feb 2021 20:19:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E2FBF801D5; Tue,  9 Feb 2021 20:19:41 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EA56F80107
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 20:19:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EA56F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="F9+10W24"
Received: by mail-wr1-x432.google.com with SMTP id g10so23477489wrx.1
 for <alsa-devel@alsa-project.org>; Tue, 09 Feb 2021 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LdU37lNhDGvGGmXAMcE5ydz9bMREEufjvwEN8UDTB/4=;
 b=F9+10W24LAFXpvtC9BL+mfIHewjZBcP0gr3jPY+B3GxCXvErXX9JiZ89eAeRvVT88j
 MSdIvVacH6Ey24JDVhh3g9VuZo0GK3Lej8iw9VhCrbulPcbn8CWXkHcSfkpkAEWrV/5c
 p6yuTREOGZZEXrDWVcBaZ3lzq4WZ+S/M6MCTnvsSUosBLYMi5/3UWYKuQTntOrmdDdRT
 V89lpTsbryFNMclIBLuvR1xLKQoV7+fl1IduR6MrvMcZZVI7Sf42DP7nce3EplemuuYR
 WIkB3D8WmWOd4woXFuOGQe3iaOvl6w8e9eEJfCMfFeZQmG29G2ji9ols/F1SsmLc2swk
 uKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LdU37lNhDGvGGmXAMcE5ydz9bMREEufjvwEN8UDTB/4=;
 b=FkEme9feHfnZGpcZ//+vaTiMaWz5BhV2QrlgoPNwD3kakdlL5pTqgqDA45dU4yxHZ1
 nGtNYKtH/lCuYnGs7e5Zrmu1JE1LR2oJkkK5lIYAXDrOaCTD/ZkvSxPwBlRt0Wk5qMuO
 qaUFjTWxgSwragCHqLR+68KC+Lv+sMOVKn5uNRYY5GsTGGMZY6HrcfeIgaJq554UoyU+
 ui3cpgISYfVMrRu0pltFm92e76vCUn4Yz5Ndsgu9KPcM2zXIuqaTrrHWTOGH2E4YIT33
 6VLwXGBHTiRZQUMqGzcCdmdPZCYxecKZOJRdzlfrJzZ4wOVY79bhi9j2QYwV8vyJtUKv
 bcQg==
X-Gm-Message-State: AOAM531Z12B4Q3FbMqVNDn9tAR+Jx2z0KT2y+Y/0JHbv/m+BvenC6T96
 XOXfP4g6bow3dAPZsKTuZRRlhWFRLvE=
X-Google-Smtp-Source: ABdhPJzy2FifsRzBzoPISrOA7c9EjqQOP4MTXtKqAd6gCGSsmhvjzZRRGtnkgeiObYjQeDD5t2IZlA==
X-Received: by 2002:a5d:6b87:: with SMTP id n7mr14503619wrx.222.1612898369075; 
 Tue, 09 Feb 2021 11:19:29 -0800 (PST)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id l2sm5622864wmq.17.2021.02.09.11.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 11:19:27 -0800 (PST)
Date: Tue, 9 Feb 2021 20:19:24 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v2 1/9] ASoC: dt-bindings: rt5659: Update binding doc
Message-ID: <YCLgPKtLyT9PL1/6@ulmo.localdomain>
References: <1611944866-29373-1-git-send-email-spujar@nvidia.com>
 <1611944866-29373-2-git-send-email-spujar@nvidia.com>
 <20210205152933.GA3089668@robh.at.kernel.org>
 <eb490eb1-d7e2-a188-8e62-496f9a1d99bc@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fE2lUxibOs/cNBX0"
Content-Disposition: inline
In-Reply-To: <eb490eb1-d7e2-a188-8e62-496f9a1d99bc@nvidia.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Cc: Oder Chiou <oder_chiou@realtek.com>, Rob Herring <robh@kernel.org>,
 alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 devicetree@vger.kernel.org, lgirdwood@gmail.com, jonathanh@nvidia.com,
 sharadg@nvidia.com, broonie@kernel.org, linux-tegra@vger.kernel.org,
 Bard Liao <bardliao@realtek.com>
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


--fE2lUxibOs/cNBX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 06:51:58PM +0530, Sameer Pujar wrote:
> Hi Rob,
>=20
> On 2/5/2021 8:59 PM, Rob Herring wrote:
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > On Fri, Jan 29, 2021 at 11:57:38PM +0530, Sameer Pujar wrote:
> > > Update following in rt5659.txt binding doc
> > >    - Add JD source for Intel HDA header: Commit 041e74b71491
> > >      ("ASoC: rt5659: Add the support of Intel HDA Header")
> > >      added driver support. Add missing info here.
> > >=20
> > >    - sound-name-prefix: Used to prefix component widgets/kcontrols
> > >      with given prefix.
> > >=20
> > >    - ports: Helps to use the Codec with audio graph card
> > >=20
> > > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > > Cc: Oder Chiou <oder_chiou@realtek.com>
> > > Cc: Bard Liao <bardliao@realtek.com>
> > > ---
> > >   Documentation/devicetree/bindings/sound/rt5659.txt | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Doc=
umentation/devicetree/bindings/sound/rt5659.txt
> > > index 56788f5..c473df5 100644
> > > --- a/Documentation/devicetree/bindings/sound/rt5659.txt
> > > +++ b/Documentation/devicetree/bindings/sound/rt5659.txt
> > > @@ -37,10 +37,21 @@ Optional properties:
> > >   - realtek,jd-src
> > >     0: No JD is used
> > >     1: using JD3 as JD source
> > > +  2: JD source for Intel HDA header
> > >=20
> > >   - realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_E=
N pin.
> > >   - realtek,reset-gpios : The GPIO that controls the CODEC's RESET pi=
n.
> > >=20
> > > +- sound-name-prefix: Please refer to name-prefix.txt
> > > +
> > > +- ports: A Codec may have a single or multiple I2S interfaces. These
> > > +  interfaces on Codec side can be described under 'ports' or 'port'.
> > > +  When the SoC or host device is connected to multiple interfaces of
> > > +  the Codec, the connectivity can be described using 'ports' propert=
y.
> > > +  If a single interface is used, then 'port' can be used. The usage
> > > +  depends on the platform or board design.
> > > +  Please refer to Documentation/devicetree/bindings/graph.txt
> > Please read what that file says now.
>=20
> Sorry, I did not understand above comment. Can you please elaborate a bit
> more?

I think what Rob meant to point out is that graph.txt now contains a
mention that the file has been moved to a more central location, which
is the dt-schema repository. So instead of referencing the graph.txt,
which then redirects to the graph.yaml in dt-schema, it'd be better to
directly reference graph.yaml from dt-schema.

That said, I'm not aware of a good or standard way to make such a
reference. Perhaps in this case, given that the rt5659 binding is not
very large, you can convert the file to json-schema first and then use
standard json-schema references for this.

Thierry

--fE2lUxibOs/cNBX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAi4DkACgkQ3SOs138+
s6EVCQ/8CB7rS0lCIaO/YUrcXFEY2TLSIUnu3FGjHYkt5fALU7w9Rt8uYVlfcoCF
Htg0LXUqYXUd/zXjE+x1ymwx3Azrb9z7DVAnAcXrB2Nq4x5QkvKmjJN90P6K+Jw4
wI30K01fotkcbybxSX9wIIrRhhcSOd/JN0eExv/llHDz2jonCidB43TGd3p+hl71
aJ0MMMmew8mK5hD+hxOL/3eYbmiPVtgJCstonPWTDUOaq7+Mc7Sdk+Rt2XAHw+5D
z1oZTbfjo7QQ9UN4JeXQPwv7PEWoAqCV5vEOFTdfljV7s88VhxkBmUWDP76ITJCH
NL1fU9xRMwVtkN7CrS5/NUBQaOPVsXFYb2cqxHsosakvB/rpDDkWeFrUustar6n3
P4IspAPdOaeCTL+NzjxhL4Ij+W8xiialaTd1MGZsxdYPkX97+2onmXgUoQ10i8d+
F0gFWrSM7dMSigKgHId1hRKm2ZJrQXNQONDg+NwN5cX6AOFy9At8RFaFNBbzWRu1
Sq1n63PDPrHmcWpxy8H53n4Ce1UBNG4ZXDxzc1E91eNXMbdDe3ge/iomFIT1TiQr
QWArTZk333ic4CuPH67hQFLhe83jWFJZRMLjAeGBJYq6Ff6Q6IcQbKh66CZ75/nV
LfNAwaVzddpbaG0wMNxF1xCUDcQypRwkgQ2vgSFHjxua+65X6H0=
=kZ90
-----END PGP SIGNATURE-----

--fE2lUxibOs/cNBX0--
