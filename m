From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver
	with soc-of-simple
Date: Wed, 23 Jul 2008 16:14:32 +0100
Message-ID: <20080723151431.GA22926@sirena.org.uk>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080723105334.GC8377@sirena.org.uk>
	<9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2575A103897
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 17:14:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 10:09:01AM -0400, Jon Smirl wrote:
> On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > ...this doesn't just allow a custom machine driver, it requires that
> >  something configures at least the machine name.  That's not a problem
> >  from the ASoC point of view but possibly from the PowerPC side?

> You have to configure at least the name. Otherwise if the machine
> driver is the last to register, how do you know to hold off the final
> registration and wait for the machine driver to appear?

I understand why you have made this change but it's a substantial change
which should at least be documented in the changelog (I'd expect to see
some mention of how this is supposed to be configured, for example).
I'd also expect something to handle the existing user.

Like I said, I'm not entirely sure that you're supposed to be using this
driver if you want a machine driver: this is a machine driver and I'm
not sure if it's supposed to cover all cases or not.  Grant?

> Or is it ok for me to change these after the platform device has been created?
> 		of_soc->dai_link.ops = machine_ops;
> 		of_soc->machine.name = machine_name;

No.
