From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] SOUND: Fix non-ISA_DMA_API build failure
Date: Fri, 24 Jun 2011 12:16:08 +0100
Message-ID: <20110624111608.GA6327@linux-mips.org>
References: <20110623144750.GA10180@linux-mips.org>
	<s5hzkl7zlcq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D1F3243BC
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 13:16:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzkl7zlcq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 24, 2011 at 10:26:13AM +0200, Takashi Iwai wrote:

> Hrm...  I still don't understand why ES18XX or others were selected at
> the first place.  Isn't it covered by the conditional in
> sound/isa/Kconfig like below?
> 
> ================================================================
> menuconfig SND_ISA
> 	bool "ISA sound devices"
> 	depends on ISA && ISA_DMA_API
> ...
> if SND_ISA
> ...
> config SND_ES18XX
> 	tristate "Generic ESS ES18xx driver"
> ...
> endif	# SND_ISA
> ================================================================
> 
> Isn't SND_ISA=n in your case although ISA_DMA_API=n?

The answer is hidden in this Kconfig warning:

warning: (RADIO_MIROPCM20) selects SND_ISA which has unmet direct dependencies (SOUND && !M68K && SND && ISA && ISA_DMA_API)

This is due to the following in drivers/media/radio/Kconfig:

config RADIO_MIROPCM20
        tristate "miroSOUND PCM20 radio"
        depends on ISA && VIDEO_V4L2 && SND
        select SND_ISA
        select SND_MIRO

So SND_ISA gets forced on even though the dependency on ISA_DMA_API is not
fulfilled.  That's solved by adding the dependency on ISA_DMA_API to
RADIO_MIROPCM20.

> Also, adlib driver is really only for ISA, so I see no big reason to
> allow this built for non-ISA.

With the patch applied:

[...]
menuconfig SND_ISA
        bool "ISA sound devices"
        depends on ISA
[...]

if SND_ISA

config SND_ADLIB
        tristate "AdLib FM card"
        select SND_OPL3_LIB
[...]

So the Adlib driver will still only be built with ISA enabled.  The only
thing that makes the Adlib driver different from all the others in the
ifdef SND_ISA ... endif bracket is that it does not directly or indirectly
use the ISA DMA API and that's in the end the reason why sound/isa/Kconfig
needs to be changed.

I originally approach this a different way but now that I'm explaining the
details I notice that it probably makes sense to split this patch into two:

 o The drivers/media/radio/Kconfig part should be applied for 3.0 and
   maybe -stable.
 o The sound/isa/Kconfig part is basically only fixing the dependency for
   the Adlib driver allowing it to be built on non-ISA_DMA_API system and
   is material for the next release after 3.0.

If you agree I'm going to repost the patch with aproprite log messages.

  Ralf
