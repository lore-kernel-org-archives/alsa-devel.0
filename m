From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 14 Apr 2010 18:36:37 +0200
Message-ID: <20100414163637.GV30807@buzzloop.caiaq.de>
References: <t2w74fd948d1004140347k3447bffapb73856eacddfde55@mail.gmail.com>
	<Pine.LNX.4.44L0.1004141003170.1716-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 12D302452E
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 18:36:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1004141003170.1716-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: alsa-devel@alsa-project.org, Greg KH <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 14, 2010 at 10:08:47AM -0400, Alan Stern wrote:
> On Wed, 14 Apr 2010, Pedro Ribeiro wrote:
> > On 14 April 2010 11:09, Daniel Mack <daniel@caiaq.de> wrote:
> > > Thanks! So the only thing I can do for now is submit exactly this patch.
> > > At least, it helps you and it shouldn't break anything. The question
> > > remains whether this type of memory should be used for all
> > > transfer_buffers.
> > >
> > 
> > Is there any chance you could push this to -stable? I don't care
> > because I always use the latest kernel, but the next Debian stable and
> > Ubuntu LTS are going to use 2.6.32.
> 
> No!  Please don't do it: Don't submit the patch and _certainly_ don't
> submit it to -stable.  It doesn't fix anything; it only works around a
> bug, and at the moment we don't even know if the bug is in the kernel
> or in Pedro's hardware (and even though it affects two different
> systems of his, nobody else has reported a similar problem).  Papering
> over it will only remove the incentive to fix it properly.

No worries - I agree. But unfortunately, I'm out of ideas now, and my
initial thoughts about what might cause the trouble were abviously not
able to explain the issue. Does anyone see further steps of tracking
this issue down?

Thanks,
Daniel
