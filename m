From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Add delay for output disable
Date: Mon, 19 Jan 2015 17:13:30 +0000
Message-ID: <20150119171330.GZ14516@opensource.wolfsonmicro.com>
References: <1421682586-6303-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150119162432.GF2809@sirena.org.uk>
 <20150119165850.GY14516@opensource.wolfsonmicro.com>
 <20150119170706.GG2809@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7AE1B2612D1
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 18:13:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150119170706.GG2809@sirena.org.uk>
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

On Mon, Jan 19, 2015 at 05:07:06PM +0000, Mark Brown wrote:
> On Mon, Jan 19, 2015 at 04:58:50PM +0000, Charles Keepax wrote:
> 
> > Similar to the power up the delay needs to be cumulative as the
> > write sequences will queue themselves up if the last one is still
> > running when the next one is started. It is fairly long for a
> > udelay I will replace with an msleep(1) instead.
> 
> Given that you are needing to delay per output it's probably going to be
> better to do the coalescing of the delays - record how much delay is
> going to be needed when stopping the clock then do that at once when
> doing that.  It's going to be more friendly for the rest of the system
> to see a single delay than to delay, schedule the thread again and then
> almost immediately enter another delay.

That makes sense I will look at adding that.

Thanks,
Charles
