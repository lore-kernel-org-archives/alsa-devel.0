From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm - introduce soc_delay
Date: Mon, 23 Jul 2012 21:05:12 +0100
Message-ID: <20120723200512.GB25707@sirena.org.uk>
References: <1343037997-16689-1-git-send-email-vinod.koul@linux.intel.com>
 <20120723101851.GG4435@opensource.wolfsonmicro.com>
 <1343039946.1726.4830.camel@vkoul-udesk3>
 <20120723104720.GK4435@opensource.wolfsonmicro.com>
 <500DAB54.20705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D516426031D
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 22:05:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <500DAB54.20705@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 23, 2012 at 02:51:48PM -0500, Pierre-Louis Bossart wrote:
> On 7/23/2012 5:47 AM, Mark Brown wrote:

Don't drop CCs from replies.

> >I'm having a hard time relating this to what I was saying.  The point
> >here is that if the device keeps marching on consuming data (as most
> >cyclic DMAs would) then there's still going to be an underrun even if
> >there's a buffer that causes a delay in the user hearing it

> Not necessarily. The DMA between system memory and DSP buffers need
> not work at a rate linked to the serial bit clock, they can be much
> faster, and actually they should to help put the system in a low
> power state rather than reading continuously from memory... what

I'm aware of this, thanks.

> Vinod is trying to explain is that due to the bursty nature of data
> transfers inside the soc, we need to modify how the accounting is
> done.

Right, but this depends on the ability of the device to pause reading
data when it reads up to the point where the application has written.
This is a separate capability to any latency that's been added by the
buffering, and most of the systems that have the buffering don't have
this capability but instead either don't report the buffer or rely on
the application being a full buffer ahead of the hardware.
