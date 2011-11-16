From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH] ARM: pxa: add support for Raumfeld DDX
Date: Wed, 16 Nov 2011 16:07:22 +0100
Message-ID: <20111116150722.GA15580@sig21.net>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
	<20111115141348.GG3077@opensource.wolfsonmicro.com>
	<4EC3B30F.60403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id CB22024536
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 16:07:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EC3B30F.60403@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 01:56:47PM +0100, Daniel Mack wrote:
> On 11/15/2011 03:13 PM, Mark Brown wrote:
> > On Mon, Nov 07, 2011 at 11:26:02AM +0100, Daniel Mack wrote:
> > 
> >> +	/* PXA DMA cannot do zero extend for 24bit samples,
> >> +	* thus only 16bit (two samples packet into 32bit word)
> >> +	* or 32bit samples are possible
> >> +	*/
> >> +	snd_pcm_hw_constraint_mask64(substream->runtime,
> >> +				    SNDRV_PCM_HW_PARAM_FORMAT,
> >> +				    SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE |
> >> +				    SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_S32_BE);
> > 
> > If the PXA DMA controller can't do 24 bit audio it should be imposing
> > this constraint.
> 
> Right. Will fix this in the CPU DAI.

IIRC the PXA can handle 24bit audio, and the STA32x can handle it, too.
However due to constraints in the clock ratios on the Raumfeld board
this mode cannot be used.  Thus this constraint is in sound/soc/pxa/raumfeld.c.

Does that make sense?  It's been a while since I worked on this code,
maybe I misremember.  And I failed to mention it in the code comment :-(


Johannes
