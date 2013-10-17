From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v4] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Thu, 17 Oct 2013 09:54:32 +0800
Message-ID: <20131017015431.GD24805@MrMyself>
References: <1381920801-9187-1-git-send-email-b42378@freescale.com>
 <20131016115847.GK2443@sirena.org.uk> <525EBFF0.1080303@metafoo.de>
 <20131016174658.GO2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E16B261ADF
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 04:19:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131016174658.GO2443@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 16, 2013 at 06:46:58PM +0100, Mark Brown wrote:
> On Wed, Oct 16, 2013 at 06:33:52PM +0200, Lars-Peter Clausen wrote:
> > On 10/16/2013 01:58 PM, Mark Brown wrote:
> 
> > > Also is iram the best name?  It makes me think of the dedicated fast
> > > instruction RAM that some processors have.  sram perhaps (for static
> > > RAM)?
> 
> > Using IRAM (internal SRAM) for this seems to be quite popular (`grep IRAM
> > arch/arm -r`). Existing devicetree bindings also seem to use the 'iram'
> > property to refer to the on-chip SRAM
> > (Documentation/devicetree/bindings/media/coda.txt). It's probably a good
> > idea to stay consistent with the existing bindings.
> 
> Oh, I wonder when that changed - it always used to get called SRAM (or
> TCM when that was what was used).

Do I still need to change the name to SRAM? I think both name make sense to me.
I use IRAM just because using different name for phandle and macro/functions
might confuse people when reviewing the patch. But it looks like IRAM is still
not the perfect choice.

Looking forward to your reply,
Nicolin Chen
