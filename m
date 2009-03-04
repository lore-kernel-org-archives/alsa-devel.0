From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] soc-dai: add bitfields for
	hardware	I2S formats
Date: Wed, 4 Mar 2009 22:30:58 +0000
Message-ID: <20090304223057.GD10731@sirena.org.uk>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E54E9243AD
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 23:31:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236197820-21022-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 09:16:58PM +0100, Daniel Mack wrote:
> This patch adds bitfields for I2S serial formats that differ from the
> amount of data actually sent on the line. Some codecs (namely the
> cs4270) require 64 sysclks being sent during each frame period, even
> though the number of acutal data bits might be less.

Hrm.  This is normally handled via the clock divider interface - it's
often much more straightforward to work with when dealing with devices
with very flexible clocking, especially if there are more than two
devices on the link.  Have you considered handling this through that,
perhaps through adding a virtual thing to configure (eg, a
PXA_SSP_FRAME_CLOCKS)?  Normally this would be a network mode but it
seems clear that that has some issues on this hardware and an
alternative solution is required.

The other downside of this approach is that it makes all existing
drivers theoretically instabuggy in that they don't reject invalid
configurations, although that's not such a big issue since it really
only makes life easier when writing board drivers.

I guess cs4270.c ought to be enforcing this if it's added...

> +#define SND_SOC_DAIFMT_FF_SAMPLE	(0 << 16)
> +#define SND_SOC_DAIFMT_FF_I2S_16	(1 << 16)
> +#define SND_SOC_DAIFMT_FF_I2S_32	(2 << 16)

FF_SAMPLE should probably be FF_UNSPEC or something to preserve the
existing semantics.

FF_I2S should probably be something else since something might need this
for non-I2S devices - _BIT, perhaps?
