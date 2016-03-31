From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dpcm: prevent error for paths
 including static links
Date: Thu, 31 Mar 2016 09:17:33 +0100
Message-ID: <20160331081733.GG31814@localhost.localdomain>
References: <1458056089-885-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
 <20160329212224.GM2350@sirena.org.uk>
 <20160330085812.GE31814@localhost.localdomain>
 <20160330163650.GG2350@sirena.org.uk>
 <20160330171314.GF31814@localhost.localdomain>
 <20160330172702.GM2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D6696261299
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 10:17:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160330172702.GM2350@sirena.org.uk>
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
Cc: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 30, 2016 at 10:27:02AM -0700, Mark Brown wrote:
> On Wed, Mar 30, 2016 at 06:13:14PM +0100, Charles Keepax wrote:
> > On Wed, Mar 30, 2016 at 09:36:50AM -0700, Mark Brown wrote:
> 
> > > Doesn't this mean that the appropriate fix is to terminate the DPCM
> > > routing at the first back end DAI so we're not trying to DPCM outside
> > > the SoC?
> 
> > I think (not 100% certain) you can have multiple backends
> > connected to a single front end, which makes it hard to know when
> > to stop or even if it is assured that all the backends will be
> > before any other spurious DAIs in the widget list.
> 
> You can have multiple backends connected but they shouldn't be chained
> together, they should be connected in parallel.  We can tell if we're
> walking a node that's a backend, why would we walk the graph beyond
> that?

Ah ok apologies, I misunderstood your suggestion. I
thought you meant aborting the widget list search in
dpcm_add_paths, but you actually mean aborting the graph walk in
snd_soc_dapm_dai_get_connnected_widgets. That looks totally like
it would work, although it needs a bit of thought as I guess the
original intention was for get_connected_widgets to be pretty
generic, but it does only have the single user.

I will get Piotr to have a look at respinning the patch, when he
returns.

Thanks,
Charles
