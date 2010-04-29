From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
Date: Thu, 29 Apr 2010 10:52:02 +1000
Message-ID: <1272502322.24542.135.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
	<z2xfa686aa41004281458u3a3048feh9d762e07f8052348@mail.gmail.com>
	<r2oed82fe3e1004281513k23b54b56v7904a4a34750c90b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

On Wed, 2010-04-28 at 17:13 -0500, Timur Tabi wrote:
> On Wed, Apr 28, 2010 at 4:58 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> 
> > The sound0 node needs a compatible value,
> 
> I knew I was forgetting something
> 
> > the sound-device node should
> > probably have one too.
> 
> The aliases, cpus, and memory node don't have a compatible property,
> and I was modeling the design after the aliases node.

aliases is a bad choice, it's very very special and is neither a device
nor a virtual device, like chosen.

cpus is more of a match in your case.

In any case, I agree, you may not really need a compatible prop for the
virtual device. In fact, Grant, do we really need an enclosing node like
that ? In any case, it's no big deal and shouldn't have much impact on
the design.

Cheers,
Ben.

> > The sound0 node should have something board specific like
> > "fsl,mpc8610hpcd-sound" to make it clear that the binding really only
> > applies to this particular board.  It would also be a good idea to
> > prefix all of the property names with 'fsl,' to avoid conflicting with
> > any future common bindings or conventions.  Other boards can use the
> > same binding, but they would get a different compatible value (the
> > driver could bind on both).
> 
> The aliases node doesn't have an fsl, prefix.  I understand the need
> for the prefix, but I wonder why we don't do that for the aliases
> node.
> 
> > I'm not a huge fan of the name "sound-devices" for the parent node.
> > There are other sorts of things that we need 'virtual' device nodes to
> > describe.  It would be nice to have a single place for collecting
> > nodes for stuff like this.  Perhaps this:
> >
> > system {
> >        compatible = "system-devices";
> >        sound0 {
> >                compatible = "fsl,mpc8610hpcd-sound";
> >                fsl,ssi = &ssi0;
> >                fsl,playback-dma = &dma00;
> >                fsl,capture-dma = &dma01;
> >                fsl,codec = &cs4270;
> >        };
> > };
> 
> I like that.
> 
