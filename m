From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Grant hw_params()
 permission to reprogram FLL
Date: Fri, 10 Jan 2014 21:15:50 +0800
Message-ID: <20140110131549.GB17392@MrMyself>
References: <1387967835-15423-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109182551.GO12858@sirena.org.uk>
 <20140110101907.GA17106@MrMyself>
 <20140110114251.GE29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 by alsa0.perex.cz (Postfix) with ESMTP id DD76C260857
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 14:19:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140110114251.GE29039@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 10, 2014 at 11:42:51AM +0000, Mark Brown wrote:
> On Fri, Jan 10, 2014 at 06:19:08PM +0800, Nicolin Chen wrote:
> > On Thu, Jan 09, 2014 at 06:25:51PM +0000, Mark Brown wrote:
> 
> > > implement bias level changes for non-CPU paths immediately I'm not sure
> > > what that's giving you over just using the bias level (which is the way
> > > you're supposed to check if the CODEC is active)?
> 
> > Aha, I also feel myself a bit obsessed to this modification while knowing
> > so well that you're not very into it. But it might be just because, at
> > least to me and according to our SRS of Linux BSP, the flexibility and
> > capability here is more important than the extra function - bypass paths.
> > (No offense taken, just my own feeling from the angle of a common user.)
> 
> Well, the common thing here is to use a sound server like PulseAudio -
> from an end user point of view only being able to play one thing at once
> isn't great either.  It feels like what you may be trying to do here is
> tune down the delay that gets applied after playback stops.  That's
> runtime tunable with pmdown_time.

Like ignoring pmdown_time? (Just did some searching and found the patch.)
Looks like this is going to be a reasonable one to fit my obsession here :)

Thank you for the idea. I'll try it first.
Nicolin Chen
