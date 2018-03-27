From: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] ASoC: max98357a: Fix speaker pop when
 starting playback
Date: Tue, 27 Mar 2018 15:11:57 -0300
Message-ID: <1522174317.2289.8.camel@collabora.com>
References: <20180321223015.32173-1-ezequiel@vanguardiasur.com.ar>
 <20180322015456.GZ2186@sirena.org.uk>
 <1521723692.1890.1.camel@collabora.com>
 <20180327113631.GB29239@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 59B6F267063
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 20:12:57 +0200 (CEST)
In-Reply-To: <20180327113631.GB29239@sirena.org.uk>
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

On Tue, 2018-03-27 at 19:36 +0800, Mark Brown wrote:
> On Thu, Mar 22, 2018 at 10:01:32AM -0300, Ezequiel Garcia wrote:
> > On Thu, 2018-03-22 at 09:54 +0800, Mark Brown wrote:
> > > On Wed, Mar 21, 2018 at 07:30:15PM -0300, Ezequiel Garcia wrote:
> > > > +- sdmode-delay : specify a delay time for SD_MODE pin.
> > > > According
> > > > +        to the DAC datasheet, if LRCLK is removed while BCLK
> > > > is
> > > > present,
> > > > +        the DAC output can cause loud pop/crack noises. This
> > > > property
> > > > +        specifies a delay for the SD_MODE pin assert, required
> > > > to
> > > > +        eliminate the noise.
> > > Why is this configurable?  This sounds like something entirely
> > > within
> > > the digital domain of the device rather than something that
> > > depends
> > > on
> > > board configuration and it's hard to see how someone would
> > > configure
> > > this.
> > The amount of delay needed seems specific to the CPU DAI,
> > not specific to the DAC. The CPU DAIs or the machine 
> > could specify this as a parameter, but I can't don't see how.
> 
> This sounds like it's just trying to reimplement the digital mute
> feature we already have, it sounds more like what you're seeing is
> noise
> playing out of the SoC at the start of playback due to startup issues
> or non-flushed FIFOs.  Can you try implementing there please?
> 

OK, I'll see how it goes using digital mute.
Please discard v2 then.

Thanks,
Eze
