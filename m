From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dpcm: prevent error for paths
 including static links
Date: Wed, 30 Mar 2016 18:13:14 +0100
Message-ID: <20160330171314.GF31814@localhost.localdomain>
References: <1458056089-885-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
 <20160329212224.GM2350@sirena.org.uk>
 <20160330085812.GE31814@localhost.localdomain>
 <20160330163650.GG2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id BF193265C96
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 19:13:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160330163650.GG2350@sirena.org.uk>
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

On Wed, Mar 30, 2016 at 09:36:50AM -0700, Mark Brown wrote:
> On Wed, Mar 30, 2016 at 09:58:12AM +0100, Charles Keepax wrote:
> > On Tue, Mar 29, 2016 at 02:22:24PM -0700, Mark Brown wrote:
> 
> > > Is this not just a normal CODEC connected to a back end on a DPCM
> > > system?  What are a "dynamic DAI" and "static DAI"?  Your changelog is
> > > very unclear, I really can't tell from your changelog what this is
> > > aiming to do or how it proposes to do it.
> 
> > The issue is basically if you have a path with a DPCM DAI at the
> > front, but then a regular CODEC to CODEC DAI link later in the
> > path. Say for example a CODEC attached to a CPU that uses DPCM
> > but then the path goes through a CODEC to CODEC link to a speaker
> > AMP after the CODEC.
> 
> Doesn't this mean that the appropriate fix is to terminate the DPCM
> routing at the first back end DAI so we're not trying to DPCM outside
> the SoC?

I think (not 100% certain) you can have multiple backends
connected to a single front end, which makes it hard to know when
to stop or even if it is assured that all the backends will be
before any other spurious DAIs in the widget list.

Thanks,
Charles
