From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Null suspend/resume functions
Date: Mon, 16 Nov 2009 20:07:11 +0100
Message-ID: <200911162007.11963.rjw@sisk.pl>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com> <20091109133136.GC1245@sirena.org.uk> <20091116153000.GB29479@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753860AbZKPTFg@vger.kernel.org>
In-Reply-To: <20091116153000.GB29479@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-pm@lists.linux-foundation.org, Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Monday 16 November 2009, Mark Brown wrote:
> On Mon, Nov 09, 2009 at 01:31:36PM +0000, Mark Brown wrote:
> > On Mon, Nov 09, 2009 at 10:58:58AM +0000, Mark Brown wrote:
> > > On Mon, Nov 09, 2009 at 11:54:47AM +0900, Kuninori Morimoto wrote:
> 
> Any chance someone from the PM side could comment on the issue below?

There is.  I haven't had a chance to look at it yet, will do shortly.

> > > > +static int fsi_runtime_nop(struct device *dev)
> > > > +{
> > > > +	/* Runtime PM callback shared between ->runtime_suspend()
> > > > +	 * and ->runtime_resume(). Simply returns success.
> > > > +	 *
> > > > +	 * This driver re-initializes all registers after
> > > > +	 * pm_runtime_get_sync() anyway so there is no need
> > > > +	 * to save and restore registers here.
> > > > +	 */
> > > > +	return 0;
> > > > +}
> > > 
> > > This sets off alarm bells but it's perfectly reasonable, especially with
> > > platforms able to put things into a low power state with no explicit
> > > driver code now they can do power domain style things like SH.  I've
> > > CCed in the PM folks since this seems like a perfectly reasonable use
> > > case which ought to be handled more nicely.

Thanks,
Rafael
