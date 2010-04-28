From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Tue, 27 Apr 2010 20:31:18 -0600
Message-ID: <i2vfa686aa41004271931wc04b9c11l5f3ebda0acb14b9@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<20100427222913.GE15083@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f222.google.com (mail-gx0-f222.google.com
	[209.85.217.222])
	by alsa0.perex.cz (Postfix) with ESMTP id C26FF244A3
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 04:31:40 +0200 (CEST)
Received: by gxk22 with SMTP id 22so2646095gxk.4
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 19:31:39 -0700 (PDT)
In-Reply-To: <20100427222913.GE15083@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 4:29 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Apr 27, 2010 at 02:24:34PM -0600, Grant Likely wrote:
>
>> However, as you and Mark rightly point out, it completely fails to
>> represent complex sound devices with weird clocking and strange
>> routes. =A0Something like this is probably more appropriate:
>
>>
>> =A0 =A0 =A0 [...]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 codec1 :codec@4f {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "cirrus,cs427=
0";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x4f>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* MCLK source is a stand-al=
one oscillator */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <1228800=
0>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>
> You also want to be representing unused pins here.
>
>> =A0 =A0 =A0 [...]
>> =A0 =A0 =A0 ssi1: ssi@16000 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8610-ssi";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [...]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,mode =3D "i2s-slave";
>
> I'd not include the master/slave decision; it's either implied by the
> fact that the CODEC has a standalone clock, a property of the link/card,
> or a policy decision that the running software can change on a whim.
>
>> =A0 =A0 =A0 sound {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8610-hpcd-sound";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* maybe something like (totally off the top=
 of my head) */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dai-links =3D <&ssi1 0 &codec 0
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&ssi1 1 &codec 1>;
>
> I'm having a hard time loving this. =A0I'd be looking for a lot more
> semantics on the links (things like information about separate clocks
> for the two directions, for example) which makes me think that that
> simple list format is far too simple and you want a list of more complex
> objects.

Oh, absolutely.  This example is no where near complete.  Mostly I
just wanted to give a concrete example of a 'virtual' device like Ben
was talking about.  I'm not going to even attempt to draft a complete
binding until I've got time to properly go over the issues involved
and discuss them with you and Liam.

> There's also analogue interconnects to deal with, and jacks (including
> detection and accessories). =A0Jacks can be particularly entertaining
> here.
>
>> Or, in other words, the device tree should *not* be used to describe
>> every possible detail and permutation. =A0It is best used to describe
>> the permutations that are common so that they don't need to be hard
>> coded for each and every board.
>
> I think the ideal is something that's purely descriptive of the hardware
> and doesn't include any policy decisions. =A0Policy decisions covers an
> awful lot of the interesting issues, though - but they're the sort of
> things that can easily be changed with a new software load and therefore
> don't belong in the device tree.

Agreed.

> On the other hand from a pragmatic point of view it's just much less
> hassle to just only provide the mechanism for instantiating a machine
> with custom code and use that for everything.

Also true, but this approach carries with it an incremental cost that
distributions feel the pain of.  Ultimately I think we'll find a sweet
spot somewhere in between.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
