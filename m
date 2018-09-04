From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 07/12] ASoC: SOF: Add DSP firmware trace
	event support
Date: Tue, 04 Sep 2018 16:28:49 +0100
Message-ID: <fe9e199c8e9c3f688cc84393b85e1a390ace3c7b.camel@linux.intel.com>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-8-liam.r.girdwood@linux.intel.com>
 <20180903162503.GS10302@sirena.org.uk>
 <579fc5f7d26a8cba21fe36eb4ff6bb4a1a0d8496.camel@linux.intel.com>
 <20180904150333.GF12993@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A04B2676C6
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 17:28:53 +0200 (CEST)
In-Reply-To: <20180904150333.GF12993@sirena.org.uk>
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

On Tue, 2018-09-04 at 16:03 +0100, Mark Brown wrote:
> On Tue, Sep 04, 2018 at 02:21:20PM +0100, Liam Girdwood wrote:
> > On Mon, 2018-09-03 at 17:25 +0100, Mark Brown wrote:
> > > Should this be integrated into the Linux trace event mechanism rather
> > > than open coded?  It would at least be nice to not call this a trace
> > > event buffer - when I initially read this I was expecting it to be for
> > > the standard Linux stuff which obviously it isn't.
> > Your right, I'll rename. The eventual aim is to make it more like Linux
> > trace
> > but we are constrained somewhat as some DSPs only 96kB or instruction RAM,
> > hence
> > it's a simple and raw trace infrastructure.
> 
> I was thinking the code could read it like it's doing now and then just
> have a trace event to dump it into the core trace infrastructure as it
> reads things in.

Most of the data is binary atm, so we were decoding in userspace. Any objection
to decoding in the kernel as different trace events ?

Thanks

Liam
