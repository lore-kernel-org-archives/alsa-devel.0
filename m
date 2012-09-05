From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [asoc:for-3.7 95/95]
 sound/soc/codecs/wm0010.c:850:7-27: ERROR: Threaded IRQ with no primary
 handler requested without IRQF_ONESHOT
Date: Wed, 5 Sep 2012 21:48:27 +0800
Message-ID: <20120905134827.GA8694@localhost>
References: <20120830151652.GB11964@localhost>
 <20120905054024.GA16276@sirena.org.uk>
 <20120905055609.GA7463@localhost>
 <20120905120546.GB16276@sirena.org.uk>
 <alpine.DEB.2.02.1209051533070.2122@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8046426535F
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 15:48:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1209051533070.2122@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 05, 2012 at 03:33:26PM +0200, Julia Lawall wrote:
> On Wed, 5 Sep 2012, Mark Brown wrote:
> 
> > On Wed, Sep 05, 2012 at 01:56:09PM +0800, Fengguang Wu wrote:
> > > On Wed, Sep 05, 2012 at 06:40:25AM +0100, Mark Brown wrote:
> > > > On Thu, Aug 30, 2012 at 08:16:52AM -0700, Fengguang Wu wrote:
> >
> > > > Julia generally does a pretty good job of formatting her mails, perhaps
> > > > there's some scripts she uses whcih would help?
> >
> > > Julia Lawall? Added CC to her.
> >
> > Yes.
> 
> I'm missing some context...

Julia, you've posted some pretty neat (coccinelle generated?) patches
to the list. So we wonder whether you have some scripts for formatting
patches based on the coccinelle output?

Thanks,
Fengguang
