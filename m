From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Wed, 28 Apr 2010 17:13:35 -0500
Message-ID: <r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
	<z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C2EE103844
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 00:14:06 +0200 (CEST)
Received: by pxi13 with SMTP id 13so2542384pxi.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 15:14:05 -0700 (PDT)
In-Reply-To: <z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linuxppc-dev@ozlabs.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 28, 2010 at 4:58 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:

> The sound0 node needs a compatible value,

I knew I was forgetting something

> the sound-device node should
> probably have one too.

The aliases, cpus, and memory node don't have a compatible property,
and I was modeling the design after the aliases node.

> The sound0 node should have something board specific like
> "fsl,mpc8610hpcd-sound" to make it clear that the binding really only
> applies to this particular board. =A0It would also be a good idea to
> prefix all of the property names with 'fsl,' to avoid conflicting with
> any future common bindings or conventions. =A0Other boards can use the
> same binding, but they would get a different compatible value (the
> driver could bind on both).

The aliases node doesn't have an fsl, prefix.  I understand the need
for the prefix, but I wonder why we don't do that for the aliases
node.

> I'm not a huge fan of the name "sound-devices" for the parent node.
> There are other sorts of things that we need 'virtual' device nodes to
> describe. =A0It would be nice to have a single place for collecting
> nodes for stuff like this. =A0Perhaps this:
>
> system {
> =A0 =A0 =A0 =A0compatible =3D "system-devices";
> =A0 =A0 =A0 =A0sound0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8610hpcd-sound";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,ssi =3D &ssi0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,playback-dma =3D &dma00;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,capture-dma =3D &dma01;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,codec =3D &cs4270;
> =A0 =A0 =A0 =A0};
> };

I like that.

-- =

Timur Tabi
Linux kernel developer at Freescale
