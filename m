From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 7 Apr 2010 17:35:51 +0200
Message-ID: <20100407153551.GK30801@buzzloop.caiaq.de>
References: <20100407090623.GN30807@buzzloop.caiaq.de>
	<Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org>
	<20100407151125.GJ30801@buzzloop.caiaq.de>
	<20100407153154.GC13425@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8335324390
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 17:35:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100407153154.GC13425@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg KH <greg@kroah.com>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 07, 2010 at 08:31:54AM -0700, Greg KH wrote:
> On Wed, Apr 07, 2010 at 05:11:25PM +0200, Daniel Mack wrote:
> > I vote for a clean solution, a fixup of existing implementations and
> > a clear note about how to allocate buffers for USB drivers. I believe
> > faulty allocations of this kind can explain quite a lot of problems on
> > x86_64 machines.
> 
> Yeah, I really don't want to have to change every driver in different
> ways just depending on if someone thinks it is going to need to run on
> this wierd hardware.
> 
> Alan, any objection to just using usb_buffer_alloc() for every driver?
> Or is that too much overhead?

FWIW, most drivers I've seen in the past hours use a wild mix of
kmalloc(), kzalloc(), kcalloc() and usb_buffer_alloc(). That should
really be unified.

Daniel
