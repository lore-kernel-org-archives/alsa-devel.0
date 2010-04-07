From: Daniel Mack <daniel@caiaq.de>
Subject: USB HID gadget driver (was: Re: USB transfer_buffer
 allocations on 64bit systems)
Date: Wed, 7 Apr 2010 11:26:36 +0200
Message-ID: <20100407092636.GF30801@buzzloop.caiaq.de>
References: <20100407090623.GN30807@buzzloop.caiaq.de>
	<p2g581ef6d61004070220z1153d40ez955b356e01220848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7254E1038B6
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 11:26:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <p2g581ef6d61004070220z1153d40ez955b356e01220848@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: suman <vijayendra.suman@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 07, 2010 at 06:20:53PM +0900, suman wrote:
> I am sorry if this is a lame question, I am in Ignorance. I have little time
> to make a USB driver.

1. Please do not hijack email threads for unrelated subjects. Your
question has nothing to do with the original topic and you copy the
wrong people for your question. Start a new thread for that.

2. Do not reply on top.

> I need to make a board work in device mode which acts as a keyboard and
> mouse device, So when my device is connected to a windows system it
> will recognize as a keyboard and a mouse device. I need a pointer for it. I
> do not find much documentation on it other than gadget driver which belongs
> to bulk class driver.
> I know my USB controller supports OTG and supports both device and host
> mode.

You need to write your own gadget driver for that. See the ones that
already exist in the tree and see which parts you can recycle for your
purpose. The protocol you want to talk is HID.

Daniel



> If you have any pointer can you please give. I'm all ears.
> 
> On Wed, Apr 7, 2010 at 6:06 PM, Daniel Mack <daniel@caiaq.de> wrote:
> 
> > Hi,
> >
> > I was pointed to https://bugzilla.kernel.org/show_bug.cgi?id=15580 by
> > Pedro Ribeiro, and unfortunately I'm pretty late in the game. I wasn't
> > aware of that thread until yesterday.
> >
> > While the report is quite confusing, the reason seams pretty clear to me
> > as I've been thru quite some time-demanding debugging of a very similar
> > issue on Mac OS X. But I'm not totally sure whether we really hit the
> > same issue here, so I'd like to have your opinions first.
> >
> > The problem is appearantly the way the transfer buffer is allocated in
> > the drivers. In the snd-usb-caiaq driver, I used kzalloc() to get memory
> > which works fine on 32bit systems. On x86_64, however, it seems that
> > kzalloc() hands out memory beyond the 32bit addressable boundary, which
> > the DMA controller of the 32bit PCI-connected EHCI controller is unable
> > to write to or read from. Am I correct on this conclusion?
> >
> > Depending on the condition of the memory management, things might work
> > or not, and especially right after a reboot, there's a better chance to
> > get lower memory.
> >
> > The fix is to use usb_buffer_alloc() for that purpose which ensures
> > memory that is suitable for DMA. And on x86_64, this also means that the
> > upper 32 bits of the address returned are all 0's.
> >
> > If what I've stated is true, there are quite some more drivers affected
> > by this issue. I collected a list of places where similar fixes are
> > needed, and I can send patches if I get a thumbs-up.
> >
> > Pedro is currently testing a patch I sent out yesterday.
> >
> > Thanks,
> > Daniel
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> 
> -- 
> Rgds
> Vijayendra Suman
> 
> The only basis for a true and lasting unity of all humanity is the religion
> of the heart. The religion of the heart is the religion of love. People can
> only be united if they are free from jealousy, hatred and petty-mindedness.
> Purify your heart first. Meet hatred with love and malice with goodwill. The
> purer you make your heart, the greater will be the power of your love.
