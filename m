From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] SOUND: Fix non-ISA_DMA_API build failure
Date: Fri, 24 Jun 2011 14:08:18 +0100
Message-ID: <20110624130818.GC6327@linux-mips.org>
References: <20110623144750.GA10180@linux-mips.org>
	<s5hzkl7zlcq.wl%tiwai@suse.de>
	<20110624111608.GA6327@linux-mips.org>
	<s5hzkl72zce.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FE74244DF
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 15:08:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzkl72zce.wl%tiwai@suse.de>
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

On Fri, Jun 24, 2011 at 02:22:41PM +0200, Takashi Iwai wrote:

> >  o The drivers/media/radio/Kconfig part should be applied for 3.0 and
> >    maybe -stable.
> 
> Yes, this will be good.

I just tested that segment only and it works as expected.  Will repost in
a minute.

> >  o The sound/isa/Kconfig part is basically only fixing the dependency for
> >    the Adlib driver allowing it to be built on non-ISA_DMA_API system and
> >    is material for the next release after 3.0.
> 
> Any serious reason that snd-adlib must be built even with ISA=n?

Definately not.

> As the device is really present only for ISA, it doesn't make much
> sense to build this even though the driver itself doesn't need
> ISA_DMA_API.

I'm not aware of any systems that could use the Adlib in a ISA=n
environment.  That's why my patch left the dependency on ISA untouched.

  Ralf
