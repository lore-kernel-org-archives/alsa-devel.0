From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Wed, 2 Jan 2008 11:26:52 +1100
Message-ID: <20080102002652.GA4655@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa0.perex.cz (Postfix) with ESMTP id 04392103820
	for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2008 01:38:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 01, 2008 at 12:25:32PM -0500, Jon Smirl wrote:
> On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
> > +               ssi@16000 {
> > +                       compatible = "fsl,ssi";
> > +                       cell-index = <0>;
> > +                       reg = <16000 100>;
> > +                       interrupt-parent = <&mpic>;
> > +                       interrupts = <3e 2>;
> > +                       fsl,mode = "i2s-slave";
> > +                       codec {
> > +                               compatible = "cirrus,cs4270";
> > +                               /* MCLK source is a stand-alone oscillator */
> > +                               bus-frequency = <bb8000>;
> > +                       };
> > +               };
> 
> Does this need to be bus-frequency? It's always called MCLK in all of
> the literature.
> 
> In my case the MCLK comes from a chip on the i2c bus that is
> programmable How would that be encoded?.

Grah!  If there's one obvious frequency for a node, it should always
be "clock-frequency".  This bus-frequency nonsense seems to be a
disease that started as a secondary frequency in Freescale CPU nodes,
and has escaped to all sorts of other places.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
