From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Wed, 28 Apr 2010 08:19:00 -0500
Message-ID: <r2oed82fe3e1004280619j29ba990fr9d0fc5b3ffa450f8@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<20100427222913.GE15083@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 596D7103851
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 15:19:34 +0200 (CEST)
Received: by pvh1 with SMTP id 1so223408pvh.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 06:19:33 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 5:29 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

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

If they're unused, how do I represent them?  Can you give me an example?

>> =A0 =A0 =A0 [...]
>> =A0 =A0 =A0 ssi1: ssi@16000 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8610-ssi";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [...]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,mode =3D "i2s-slave";
>
> I'd not include the master/slave decision; it's either implied by the
> fact that the CODEC has a standalone clock, a property of the link/card,
> or a policy decision that the running software can change on a whim.

I know it's redundant, but at the time, it seemed a lot simpler than
walking the device tree.

Frankly, I'd rather not consider minor device tree changes at this
point.  I'm hoping I don't need to change the device tree at all.

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

Yeah, I don't like it either.  It seems arbitrary.

> I think the ideal is something that's purely descriptive of the hardware
> and doesn't include any policy decisions.

I like to think that this is what we have today.

-- =

Timur Tabi
Linux kernel developer at Freescale
