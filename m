From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ALSA: compress: Add
 SND_AUDIOCODEC_BESPOKE'
Date: Thu, 5 Nov 2015 09:50:23 +0000
Message-ID: <20151105095023.GF2549@ck-lbox>
References: <1445348358-23306-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <56267E4E.8010609@linux.intel.com>
 <20151020193711.GF32054@sirena.org.uk>
 <20151021153248.GE27370@localhost> <20151021153614.GD10520@ck-lbox>
 <20151105055739.GR12910@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D789626531B
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 11:05:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151105055739.GR12910@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2015 at 11:27:39AM +0530, Vinod Koul wrote:
> On Wed, Oct 21, 2015 at 04:36:14PM +0100, Charles Keepax wrote:
> > On Wed, Oct 21, 2015 at 09:02:49PM +0530, Vinod Koul wrote:
> > > On Tue, Oct 20, 2015 at 08:37:11PM +0100, Mark Brown wrote:
> > > > On Tue, Oct 20, 2015 at 12:47:58PM -0500, Pierre-Louis Bossart wrote:
> > > 
> > > > > If you need to set parameters maybe we should also change the definition of
> > > > > snd_enc_generic so that the reserved fields can be used for custom
> > > > > parameters, or document that their use is permitted for this sort of ID.
> > > > 
> > > > It does mean the core can't grab them but quite what the core is
> > > > supposed to usefully do for something like this is unclear to me so...
> > > 
> > > Well in case of compressed formats, core doesn't do anything, we just act as
> > > a transport and shove down data and information.
> > > 
> > > I do like Pierre's idea of giving some meaning to formats and use some
> > > reserved fields, but somehow I can't think of a clean solution for this!
> > 
> > Personally, I feel a bit like doing nothing at the moment might
> > be the best solution. If BESPOKE is for icky stuff that won't be
> > generic trying to pull out generic fields to go in snd_enc_generic
> > seems like a challenging exercise, and we can look submissions
> > that use it and keep an eye out for anything that might be
> > generic enough to go in there, rather than adding a bunch of
> > stuff that ends up never getting used.
> 
> So what is the conclusion here..? Are we all okay with this approach?

I was planning to send out a v2 shortly, just adding a comment by
the reserved fields in snd_enc_generic to say its ok to use them
if using BESPOKE and see where that gets us.

Thanks,
Charles
