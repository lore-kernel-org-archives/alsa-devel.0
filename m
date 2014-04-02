From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Only kmemdup binary control
	buffer if	masking
Date: Wed, 2 Apr 2014 15:49:20 +0100
Message-ID: <20140402144920.GN1665@opensource.wolfsonmicro.com>
References: <1396448225-19936-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140402144103.GF2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0280E2654BA
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 16:49:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140402144103.GF2269@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 02, 2014 at 03:41:03PM +0100, Mark Brown wrote:
> On Wed, Apr 02, 2014 at 03:17:05PM +0100, Charles Keepax wrote:
> 
> > When writing a binary control we may apply a mask to the first register,
> > as this requires modifying the data the buffer is duplicated, currently
> > this is done for all binary control writes. As most binary controls
> > don't use the mask facility and thus can freely use the original buffer,
> > avoid the kmemdup for these cases.
> 
> No, that's not why we're duplicating...
> 
> > -	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
> 
> ...note the GFP_DMA there, it's about ensuring that the buffer is
> DMAable since the underlying APIs end up wanting that (or will for
> larger coefficient blocks anyway).  What would be slightly more
> efficient in the success case would be to do a kmalloc() then
> copy_from_user() into that block allowing us to bypass the copy.

Ah... thanks sorry about the noise.

Thanks,
Charles
