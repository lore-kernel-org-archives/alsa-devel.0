From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine
	driver	with soc-of-simple
Date: Sat, 26 Jul 2008 19:14:41 -0600
Message-ID: <20080727011441.GE12191@secretlab.ca>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080723105334.GC8377@sirena.org.uk>
	<9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
	<20080723151431.GA22926@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 27425244ED
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 06:04:47 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so5118650wfg.23
	for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2008 21:04:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080723151431.GA22926@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 04:14:32PM +0100, Mark Brown wrote:
> On Wed, Jul 23, 2008 at 10:09:01AM -0400, Jon Smirl wrote:
> > On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > > ...this doesn't just allow a custom machine driver, it requires that
> > >  something configures at least the machine name.  That's not a problem
> > >  from the ASoC point of view but possibly from the PowerPC side?
> 
> > You have to configure at least the name. Otherwise if the machine
> > driver is the last to register, how do you know to hold off the final
> > registration and wait for the machine driver to appear?
> 
> I understand why you have made this change but it's a substantial change
> which should at least be documented in the changelog (I'd expect to see
> some mention of how this is supposed to be configured, for example).
> I'd also expect something to handle the existing user.
> 
> Like I said, I'm not entirely sure that you're supposed to be using this
> driver if you want a machine driver: this is a machine driver and I'm
> not sure if it's supposed to cover all cases or not.  Grant?

As I replied to the patch itself, I'm not thrilled with it, but I don't
have an immediate solution.  I do want this behaviour to at least
trigger on something in the device tree; not to become a hard
requirement.

g.
