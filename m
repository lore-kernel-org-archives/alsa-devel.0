From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA problems with 2.6.18-rc3
Date: Wed, 09 Aug 2006 18:11:37 -0400
Message-ID: <1155161498.26338.216.camel@mindpipe>
References: <44D8F3E5.5020508@ukonline.co.uk>
	 <200608092222.05993.s0348365@sms.ed.ac.uk>
	 <1155159278.26338.208.camel@mindpipe>
	 <200608092307.27615.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751398AbWHIWLe@vger.kernel.org>
In-Reply-To: <200608092307.27615.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org, Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-08-09 at 23:07 +0100, Alistair John Strachan wrote:
> > It's impossible to predict the effect of some mixer controls across
> the
> > wide range of hardware that ALSA supports.  What makes sound work on
> one
> > machine is likely to break it on another.
> 
> However, ALSA _has_ defaults for these controls, which I believe are 
> usually "off" or "zero". All I'm suggesting is that these defaults are
> plainly suboptimal for emu10k1, and probably other cards to which this
> statement simply does not apply. Shipping defaults is one thing, but
> shipping useless defaults is quite another. We have policy all over
> the kernel for providing "sane defaults" e.g. filesystem mount
> options. 

I think muted is a sane default - the only sane default.  Otherwise you
could damage speakers or hearing.  Also many devices will be noisier if
unused inputs are enabled.  Is it really that hard for users to unmute
the mixer or for distros to create their own config?

Also, analog output on my emu10k1 works perfectly with "External
Amplifier" disabled.

Lee
