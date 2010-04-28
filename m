From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Wed, 28 Apr 2010 15:58:34 -0600
Message-ID: <z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 081D424613
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 23:58:56 +0200 (CEST)
Received: by gyd10 with SMTP id 10so7069609gyd.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 14:58:55 -0700 (PDT)
In-Reply-To: <j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur.tabi@gmail.com>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linuxppc-dev@ozlabs.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 28, 2010 at 2:35 PM, Timur Tabi <timur.tabi@gmail.com> wrote:
> On Tue, Apr 27, 2010 at 5:09 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>
>> Keep in mind that it's perfectly kosher to create nodes for "virtual"
>> devices. IE. We could imagine a node for the "sound subsystem" that
>> doesn't actually correspond to any physical device but contain the
>> necessary properties that binds everything together. You could even have
>> multiple of these if you have separate set of sound HW that aren't
>> directly dependant.
>
> First, I want to officially retract this patch. =A0I've talked with
> Grant, and we've come up with a different approach to this problem.
>
> Second, how about this binding for the virtual sound node? =A0It would
> be a root-level node.
>
> =A0 =A0 =A0 =A0sound-devices {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sound0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssi =3D &ssi0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0playback-dma =3D &dma00;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0capture-dma =3D &dma01;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0codec =3D &cs4270;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0};

The sound0 node needs a compatible value, the sound-device node should
probably have one too.

The sound0 node should have something board specific like
"fsl,mpc8610hpcd-sound" to make it clear that the binding really only
applies to this particular board.  It would also be a good idea to
prefix all of the property names with 'fsl,' to avoid conflicting with
any future common bindings or conventions.  Other boards can use the
same binding, but they would get a different compatible value (the
driver could bind on both).

I'm not a huge fan of the name "sound-devices" for the parent node.
There are other sorts of things that we need 'virtual' device nodes to
describe.  It would be nice to have a single place for collecting
nodes for stuff like this.  Perhaps this:

system {
        compatible =3D "system-devices";
        sound0 {
                compatible =3D "fsl,mpc8610hpcd-sound";
                fsl,ssi =3D &ssi0;
                fsl,playback-dma =3D &dma00;
                fsl,capture-dma =3D &dma01;
                fsl,codec =3D &cs4270;
        };
};

But I really don't have any knowledge of what has been done previously
in this regard or if any conventions have been established.  Ben, any
thoughts?

g.
