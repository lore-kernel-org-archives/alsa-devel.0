From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: dapm: Add new widget type for
 constructing DAPM graphs on DSPs.
Date: Thu, 15 Jun 2017 11:56:39 +0100
Message-ID: <1497524199.30929.378.camel@loki>
References: <1497021829-5680-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20170609175333.6ift3olr3thobopr@sirena.org.uk>
 <1497439735.30929.330.camel@loki>
 <20170615100124.vegs5xwkvbzqtq7z@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 696B1266A89
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 12:56:54 +0200 (CEST)
In-Reply-To: <20170615100124.vegs5xwkvbzqtq7z@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2017-06-15 at 11:01 +0100, Mark Brown wrote:
> On Wed, Jun 14, 2017 at 12:28:55PM +0100, Liam Girdwood wrote:
> > On Fri, 2017-06-09 at 18:53 +0100, Mark Brown wrote:
> 
> > > I'm still a bit unclear about how a pipeline and effect are different
> > > from an ASoC point of view - it matters on the DSP but from the kernel's
> > > point of view a pipeline just an effect that happens to have a more
> > > complicated implementation on the DSP?
> 
> > Yes, that's true, some of the objects will most likely be treated the
> > same by the kernel core but for the DSP and driver they will different.
> > i.e. they create different objects with different topology private data
> > (using the widget ID to differentiate).
> 
> Shouldn't that just be handled in the driver though?  Nothing outside
> the driver cares.  We're going to need to differentiate between
> different effects and pipelines in the driver anyway.

It can be, just a little more code in the driver that's all. I'll remove
the pipeline widget and resend.

Thanks

Liam
