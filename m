From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 16:03:38 +0100
Message-ID: <20080616150337.GB22229@sirena.org.uk>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D41A22432F
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:03:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 16, 2008 at 10:32:37AM -0400, Jon Smirl wrote:
> On 6/16/08, Timur Tabi <timur@freescale.com> wrote:
> > Jon Smirl wrote:

> > > I'd like for the fabric driver to be dynamically loaded by the device
> > tree.

> >  You have a PPC problem, not an ASoC problem.  You're trying to use the
> > device tree to load a device without specifying a specific node.  This is

...

> I think I've come up with a solution. Push all of that generic setup
> code in mpc8610_hpcd into fsl_ssi. Leave only the platform specific
> support in mpc8610_hpcd. Now turn mpc8610_hpcd into a loadable module
> but leave it as a platform_driver. During the fsl_ssi probe function
> extract the platform name from the device tree and use it to
> dynamically load the mpc8610_hpcd driver.

That should work from an ASoC point of view.

As Timur says, this is a PowerPC-specific problem - ASoC v2 itself
doesn't care how the various devices get instantiated.  The fabric,
codec and SoC drivers can all come up in any order and the core will
sort things out.

OOI, I guess that if there were some visible control on the board (eg, a
few controls via GPIO) then this would be less of an issue since there
would be real hardware for the machine/fabric driver to control?
