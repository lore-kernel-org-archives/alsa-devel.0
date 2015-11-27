From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Add 32uS delay after
 putting FLL into freerun
Date: Fri, 27 Nov 2015 13:05:44 +0000
Message-ID: <20151127130544.GN18889@ck-lbox>
References: <1448546600-15596-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151127122627.GN1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id DAE122610A7
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2015 14:21:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151127122627.GN1929@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 27, 2015 at 12:26:27PM +0000, Mark Brown wrote:
> On Thu, Nov 26, 2015 at 02:03:20PM +0000, Charles Keepax wrote:
> > When switching between two clock sources using the FLL freerun to smooth
> > the transition we should wait 32uS after putting the FLL into freerun
> > before we proceed. In practice we appear to be getting enough delay from
> > the surrounding code, but better to make it explicit.
> 
> You'll almost certainly get 32us from just setting up the I/O and
> also...
> 
> > +++ b/sound/soc/codecs/arizona.c
> > @@ -2215,6 +2215,7 @@ static int arizona_enable_fll(struct arizona_fll *fll)
> >  		regmap_update_bits_async(fll->arizona->regmap, fll->base + 1,
> >  					 ARIZONA_FLL1_FREERUN,
> >  					 ARIZONA_FLL1_FREERUN);
> > +		udelay(32);
> 
> ...this won't do what you say it will - the I/O is asynchronous so what
> this will do is add a delay immediately after scheduling the I/O while
> the I/O is at best in progress and most likely before it is ever begun.
> You'd need to make the I/O synchronous to actually introduce the delay.

Oops.. missed that, apologies I will respin.

Thanks,
Charles
