From: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] ASoC: max98357a: Fix speaker pop when
	starting playback
Date: Thu, 22 Mar 2018 10:01:32 -0300
Message-ID: <1521723692.1890.1.camel@collabora.com>
References: <20180321223015.32173-1-ezequiel@vanguardiasur.com.ar>
 <20180322015456.GZ2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 7195B26738C
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 14:02:27 +0100 (CET)
In-Reply-To: <20180322015456.GZ2186@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Barber <smbarber@chromium.org>, Mac Chiang <mac.chiang@intel.com>, Ezequiel Garcia <ezequiel@collabora.co.uk>, kernel@collabora.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for reviewing this so quickly.

On Thu, 2018-03-22 at 09:54 +0800, Mark Brown wrote:
> On Wed, Mar 21, 2018 at 07:30:15PM -0300, Ezequiel Garcia wrote:
> 
> > +- sdmode-delay : specify a delay time for SD_MODE pin. According
> > +        to the DAC datasheet, if LRCLK is removed while BCLK is
> > present,
> > +        the DAC output can cause loud pop/crack noises. This
> > property
> > +        specifies a delay for the SD_MODE pin assert, required to
> > +        eliminate the noise.
> 
> Why is this configurable?  This sounds like something entirely within
> the digital domain of the device rather than something that depends
> on
> board configuration and it's hard to see how someone would configure
> this.
> 

The amount of delay needed seems specific to the CPU DAI,
not specific to the DAC. The CPU DAIs or the machine 
could specify this as a parameter, but I can't don't see how.

Perhaps it could be a driver parameter?

> > +static void max98357a_enable_sdmode_work(struct work_struct *work)
> > +{
> > +   struct max98357a_priv *max98357a = container_of(work,
> > +           struct max98357a_priv, enable_sdmode_work.work);
> > +   unsigned long flags;
> > +
> > +   spin_lock_irqsave(&max98357a->sdmode_lock, flags);
> > +   gpiod_set_value(max98357a->sdmode, max98357a-
> > >sdmode_enabled);
> > +   spin_unlock_irqrestore(&max98357a->sdmode_lock, flags);
> > +}
> 
> What is this lock supposed to accomplish?  We perform a single action
> under the lock which itself has internal locking, it's not going to
> have
> any meaningful effect.

I am under the impression it removes the race condition
between the gpiod_set_value() happening in the different
contexts.

Thanks,
Eze
