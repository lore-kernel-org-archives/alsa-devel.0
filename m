From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Grant hw_params()
 permission to reprogram FLL
Date: Fri, 10 Jan 2014 18:19:08 +0800
Message-ID: <20140110101907.GA17106@MrMyself>
References: <1387967835-15423-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109182551.GO12858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 by alsa0.perex.cz (Postfix) with ESMTP id 746902654B4
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 11:30:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140109182551.GO12858@sirena.org.uk>
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

On Thu, Jan 09, 2014 at 06:25:51PM +0000, Mark Brown wrote:
> > +	mask = WM8962_MIXINL_TO_HPMIXL_MASK | WM8962_MIXINR_TO_HPMIXL_MASK |
> > +		WM8962_IN4L_TO_HPMIXL_MASK | WM8962_IN4R_TO_HPMIXL_MASK;
> > +	ret |= snd_soc_read(codec, WM8962_HEADPHONE_MIXER_1) & mask;
> > +	ret |= snd_soc_read(codec, WM8962_HEADPHONE_MIXER_2) & mask;
> > +	ret |= snd_soc_read(codec, WM8962_SPEAKER_MIXER_1) & mask;
> > +	ret |= snd_soc_read(codec, WM8962_SPEAKER_MIXER_2) & mask;
> 
> Peering inside the CODEC register map isn't great and given that we

Hmm..It looks like it'd be safer to give up the bypass checking here.

> implement bias level changes for non-CPU paths immediately I'm not sure
> what that's giving you over just using the bias level (which is the way
> you're supposed to check if the CODEC is active)?

Aha, I also feel myself a bit obsessed to this modification while knowing
so well that you're not very into it. But it might be just because, at
least to me and according to our SRS of Linux BSP, the flexibility and
capability here is more important than the extra function - bypass paths.
(No offense taken, just my own feeling from the angle of a common user.)

I'll still try to refine this patch to a new version. And meanwhile, I
will listen your reply to this mail and see if I should send it or not.

Thank you,
Nicolin Chen
