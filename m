From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Wed, 28 Apr 2010 16:23:34 -0600
Message-ID: <s2wfa686aa41004281523x30650d0xf48cee0e72eea762@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
	<z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
	<r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Timur Tabi <timur.tabi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 28, 2010 at 4:13 PM, Timur Tabi <timur.tabi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Apr 28, 2010 at 4:58 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>=
 wrote:
>
>> The sound0 node needs a compatible value,
>
> I knew I was forgetting something

:-)

>
>> the sound-device node should
>> probably have one too.
>
> The aliases, cpus, and memory node don't have a compatible property,
> and I was modeling the design after the aliases node.

Well, there are typically three ways to find a node; by name, by
device_type and by compatible.  device_type is meaningless for the
flattened tree, so that's out.  Matching by name could potentially
have namespace collisions, but I'm not sure.  I'll defer to Ben &
Mitch's judgment here.

The difference with aliases, cpus and memory nodes is that the
conventions around them were defined and agreed on a very long time
ago.  We could get consensus to do the same here, but I cannot make
that call.

>> The sound0 node should have something board specific like
>> "fsl,mpc8610hpcd-sound" to make it clear that the binding really only
>> applies to this particular board. =A0It would also be a good idea to
>> prefix all of the property names with 'fsl,' to avoid conflicting with
>> any future common bindings or conventions. =A0Other boards can use the
>> same binding, but they would get a different compatible value (the
>> driver could bind on both).
>
> The aliases node doesn't have an fsl, prefix. =A0I understand the need
> for the prefix, but I wonder why we don't do that for the aliases
> node.

aliases is not a vendor-specific or limited scope convention.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
