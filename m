From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Mixer control for signed gain value
Date: Thu, 23 Jun 2011 11:37:57 +0100
Message-ID: <20110623103757.GC21932@opensource.wolfsonmicro.com>
References: <4E02DDF3.2070509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B0AB24422
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 12:38:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E02DDF3.2070509@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 11:32:19PM -0700, Patrick Lai wrote:

> The CODEC I am working with takes byte-long gain value in two's
> complement form.
> In soc-core.c, the closest functions I see are
>  snd_soc_info_volsw_s8
> snd_soc_get_volsw_s8
> snd_soc_set_volsw_s8

> These functions are coded to work with two integer values. For my
> purpose, I suppose that I can always set 2nd integer input as zero.
> However, would I still be able to set volume like
> amixer sset "Codec Gain" 100 as percentage. If yes, how will amixer
> know to put upper 8 bits of 16 bit gain in 2nd integer value element?

Could you clarify what the control you're dealing with is?  You say
above that your gains are byte long but here you're talking about them
actually being 16 bit.  If they're 16 bit you probably need to write a
new control type.
