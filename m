From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Thu, 15 Apr 2010 09:35:01 +0200
Message-ID: <20100415073501.GY30807@buzzloop.caiaq.de>
References: <t2w74fd948d1004140347k3447bffapb73856eacddfde55@mail.gmail.com>
	<Pine.LNX.4.44L0.1004141003170.1716-100000@iolanthe.rowland.org>
	<20100414163637.GV30807@buzzloop.caiaq.de>
	<n2k74fd948d1004141021r8815647cx2b74085fc37a27b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B36E24152
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Apr 2010 09:35:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <n2k74fd948d1004141021r8815647cx2b74085fc37a27b2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: alsa-devel@alsa-project.org, Greg KH <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Alan Stern <stern@rowland.harvard.edu>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 14, 2010 at 06:21:05PM +0100, Pedro Ribeiro wrote:
> On 14 April 2010 17:36, Daniel Mack <daniel@caiaq.de> wrote:
> > No worries - I agree. But unfortunately, I'm out of ideas now, and my
> > initial thoughts about what might cause the trouble were abviously not
> > able to explain the issue. Does anyone see further steps of tracking
> > this issue down?
> >
> > Thanks,
> > Daniel
> >
> 
> Well if this is a dirty / dangerous hack, what about your first patch?
> I've been testing it for days and has given me no problems.

[For those who haven't followed all the discussions - this patch used
 usb_buffer_alloc() instead of kmalloc() in the audio USB driver]

No, Alan is right. As long as we don't know what's going on, it
shouldn't be fixed that way.

There might be an update to all USB drivers to use a special allocation
function in order to avoid DMA bounce buffers for non-64-bit aware host
controllers, but that's certainly a second step. First, the bug that you
see needs attention, and the longer you can reproduce it, the better :)

Daniel
