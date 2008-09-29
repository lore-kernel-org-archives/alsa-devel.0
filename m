From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ALSA: ASoC: Fix wrong param when call
	snd_soc_test_bits
Date: Mon, 29 Sep 2008 11:11:00 +0100
Message-ID: <20080929101058.GA27647@sirena.org.uk>
References: <1222519396-6916-1-git-send-email-linuxzsc@gmail.com>
	<20080927163300.GA3225@sirena.org.uk>
	<4e090d470809271627t587270a0x3724b5b08b89a247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <4e090d470809271627t587270a0x3724b5b08b89a247@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 28, 2008 at 07:27:27AM +0800, Richard Zhao wrote:

Please don't top post.

> Without the patch, value of val is the value of the enumerated control
> (mux), so dapm_mux_update_power didn't go wrong. But snd_soc_test_bits

This appears to suggest that this is a pure coding style change but that
doesn't tie in with any of the rest of your message or the content of
the actual patch - what do you mean when you say that it "didn't go
wrong"?

> need the bitmask value, so I changed the original variable name "val"
> to "mux" and add a new variable "val" which means bitmask value. So
> the meaning of val and mux is unified with that in
> dapm_mux_update_power.

I think that what you mean to say here is that dapm_mux_update_power()
is using val as both the index into the options for the mux and as the
shifted value of the relevant bits in the register and these won't be
the same unless the bits aren't shifted in the register?  If so could
you please resubmit with a changelog entry saying so?

> Though you can't find "if (!snd_soc_test_bits(widget->codec, e->reg,
> mask, val))" in the patch, it's what I want to fix.

There is no reference at all to snd_soc_test_bits() in your patch since
you didn't change that line or anything near enough to it to include it
in the patch and it's not immediately obvious that you've changed the
meaning of the val argument.

For future reference the main problem here is that your changelog simply
says that you "Fix wrong param" but doesn't go into any detail on what's
incorrect about which parameter or what's incorrect about the parameter.
