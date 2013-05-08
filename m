From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH v2 2/6] ASoC: ux500: Do not clear state if already idle
Date: Wed, 8 May 2013 14:04:49 +0200
Message-ID: <20130508120449.GA18323@balto.lan>
References: <20130508080448.GG3102@gmail.com>
 <1368002354-15471-1-git-send-email-fabio.baltieri@linaro.org>
 <20130508103401.GX7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130508103401.GX7478@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 08, 2013 at 11:34:01AM +0100, Mark Brown wrote:
> On Wed, May 08, 2013 at 10:39:14AM +0200, Fabio Baltieri wrote:
> > As enable_msp gets called only after some audio data has been received,
> > if the userspace closes the device before sending any data it causes
> > ux500_msp_i2s_close to clear device state even if it was not previously
> > initialized.
> 
> Ugh, please don't do stuff like this - you're posting an individual
> revision of a patch buried in the middle of a thread.  This just makes
> things hard to follow and error prone.  Repost the patch series or wait
> until what can be applied is applied then repost.

Ok, I'll just repost all the not applied patches after the review.

Anything on the patch itself?

Fabio

-- 
Fabio Baltieri
