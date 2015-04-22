From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC 1/4] ASoC: topology: Add topology UAPI header.
Date: Wed, 22 Apr 2015 12:30:37 +0100
Message-ID: <1429702237.2695.24.camel@loki>
References: <1429217295.7100.19.camel@loki>
 <20150420213048.GT14892@sirena.org.uk> <1429609673.3793.14.camel@loki>
 <s5hlhhlztnr.wl-tiwai@suse.de> <1429620227.3793.31.camel@loki>
 <20150421150342.GJ22845@sirena.org.uk> <s5hy4llmrnr.wl-tiwai@suse.de>
 <20150421163502.GL22845@sirena.org.uk> <55367EE4.5030201@metafoo.de>
 <20150422112405.GW22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E55E226585C
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 13:30:42 +0200 (CEST)
In-Reply-To: <20150422112405.GW22845@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-04-22 at 12:24 +0100, Mark Brown wrote:
> On Tue, Apr 21, 2015 at 06:46:28PM +0200, Lars-Peter Clausen wrote:
> > On 04/21/2015 06:35 PM, Mark Brown wrote:
> 
> > >The trouble with the ABI version information is that it tells new
> > >kernels how to handle old tables but old kernels will have no idea what
> > >to do with new firmwares.
> 
> > What I did for the SigmaDSP firmware format (which can hopefully be
> > superseded by this) is to have a header which a block type and the block
> > length for each block for exactly this reason. It allows fully backward and
> > forward compatibility between kernel versions and does not require a change
> > in the ABI each time a new type of block is added. It also keeps the parser
> > simple since it does not have to know the size and also makes support for
> > vendor blocks quite easy, since the processing of those can be offloaded to
> > some vendor callbacks without the core having to be informed what the
> > content or size of those vendor blocks is.
> 
> Yes, that's what the ex-Wolfson stuff does too (it also has ABI
> versioning but most things shouldn't need it).

Ok, I'll add in the block length for V2. Travelling atm so V2 will
probably arrive sometime next week.

Liam
