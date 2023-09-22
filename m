Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269ABCE7AB8
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Sep 2023 19:47:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADDCEDF0;
	Fri, 22 Sep 2023 21:46:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADDCEDF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695412064;
	bh=Z73INrp+tUCDrn3nt/IznNU60OcEzvbVv581pkRDXlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BV8QBJLQVFYhVYhVUA9eMBf6OU/Kja83NWk9yeghXl3lmpamXhz6nDbCb7hJdhm2m
	 tSrSlNOpIVdGUsPprblBowMhe0vsKBCkmD2t+p9fvB75lsW9k40i/NDiyxp7RWGKbf
	 LGBFNxP7BEnAD9Md3iNdqDssc2qshlsZJ7oyTXao=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C21FFF80558; Fri, 22 Sep 2023 21:46:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16CF7F80005;
	Fri, 22 Sep 2023 21:46:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA478F80125; Fri, 22 Sep 2023 21:46:11 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 89EB7F800F4
	for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2023 21:46:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89EB7F800F4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P4ZZPqOm
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A9C72CE2455
	for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2023 19:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1C4C433CB
	for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2023 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695411957;
	bh=Z73INrp+tUCDrn3nt/IznNU60OcEzvbVv581pkRDXlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P4ZZPqOmhipnrgdjc5Cicuv4gwGoR5ahpSW6RraPJhB2FOCevSoVAq7M03SUqbiJq
	 K7C83A8rvE9vTWF2PZ5kYCMKgg3G1IVvpRh+NW3hqCEKgBE5APzZ0p6is/9D0IzpXy
	 L4KFq+qRrX7Nsl9X/FVhceTOut8PENgISZ7V9Hgc0n17gQFch+sOZHm06uwoEbBMFg
	 bdQku4DZghgBK/X1clycJXNjGfpUaVv8cK0r9G/b2uMU+jMiHYfIm/lqjl9v/3n8cS
	 tduJT5OdwlLHx5IjPVmN9jiMNIWgStlkcTXysI9oJM3ogbUGEUzRoqqQuRZPSge2DG
	 XwBXMnxxa/mIQ==
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5043120ffbcso3505960e87.2
        for <alsa-devel@alsa-project.org>;
 Fri, 22 Sep 2023 12:45:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhF/oypPDRvIXqo21+CnueGICWDd7LHtzW6pkMC/fhEz7f9e+S
	Yiv7z9syyIu5hewLOWuKbfmJ+PxYowpxtpAqMA==
X-Google-Smtp-Source: 
 AGHT+IEyL15UWPDOOifALHGXr9zT3PFp6EFjcQQ6N5sRMKjOVNVOEvEhKETlB6KYvfp58mdiyeysUyZjSt5CkUaQLB8=
X-Received: by 2002:a19:651e:0:b0:503:18c5:6833 with SMTP id
 z30-20020a19651e000000b0050318c56833mr310830lfb.61.1695411955742; Fri, 22 Sep
 2023 12:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230922075913.422435-1-herve.codina@bootlin.com>
 <20230922075913.422435-26-herve.codina@bootlin.com>
 <169538601225.2919383.2942072541503354871.robh@kernel.org>
 <20230922154546.4ca18b6f@bootlin.com>
In-Reply-To: <20230922154546.4ca18b6f@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Sep 2023 14:45:43 -0500
X-Gmail-Original-Message-ID: 
 <CAL_JsqJTruTExc=uHCPCp3q-fo+fB-wAJ-ggPpHpWcHSoGALdw@mail.gmail.com>
Message-ID: 
 <CAL_JsqJTruTExc=uHCPCp3q-fo+fB-wAJ-ggPpHpWcHSoGALdw@mail.gmail.com>
Subject: Re: [PATCH v6 25/30] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
To: Herve Codina <herve.codina@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Randy Dunlap <rdunlap@infradead.org>,
	Takashi Iwai <tiwai@suse.com>, Simon Horman <horms@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 netdev@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org,
	Paolo Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
	Shengjiu Wan g <shengjiu.wang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
	Qiang Zhao <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: YPQIFJMK5IXEBLL2LCRYZO7IU4U5WO6M
X-Message-ID-Hash: YPQIFJMK5IXEBLL2LCRYZO7IU4U5WO6M
X-MailFrom: robh@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YPQIFJMK5IXEBLL2LCRYZO7IU4U5WO6M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Sep 22, 2023 at 8:46=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi Rob,
>
> On Fri, 22 Sep 2023 07:33:32 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Fri, 22 Sep 2023 09:59:00 +0200, Herve Codina wrote:
> > > The Lantiq PEF2256 is a framer and line interface component designed =
to
> > > fulfill all required interfacing between an analog E1/T1/J1 line and =
the
> > > digital PCM system highway/H.100 bus.
> > >
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > >  .../bindings/net/lantiq,pef2256.yaml          | 214 ++++++++++++++++=
++
> > >  1 file changed, 214 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2=
256.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/net/lantiq,pef2256.yaml: properties:lantiq,data-rate-bps: '$ref' should no=
t be valid under {'const': '$ref'}
> >       hint: Standard unit suffix properties don't need a type $ref
> >       from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> >
>
> The '-bps' suffix was added recently in
> https://github.com/devicetree-org/dt-schema/
> commit 033d0b1 ("Add '-bps' as a standard unit suffix for bits per second=
")
>
> This commit is not yet present in any dt-schema release.
>
> Should I update my patch (ie. removing $ref) right now even if this updat=
e will
> make the last dt-schema release not happy ?

Yes. I will spin a release soon as well.

Rob
