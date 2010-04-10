From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Sat, 10 Apr 2010 10:34:53 +0200
Message-ID: <20100410083453.GN30801@buzzloop.caiaq.de>
References: <s5hhbnncflj.wl%tiwai@suse.de>
	<Pine.LNX.4.44L0.1004071452560.5760-100000@iolanthe.rowland.org>
	<20100408003313.GE4365@kroah.com> <4BBE6E57.6020600@gmail.com>
	<20100409165014.GC5184@xanatos>
	<g2u51f3faa71004091638nc383aa0ei899777c869273a22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A6ABD103826
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Apr 2010 10:34:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g2u51f3faa71004091638nc383aa0ei899777c869273a22@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 09, 2010 at 05:38:13PM -0600, Robert Hancock wrote:
> On Fri, Apr 9, 2010 at 10:50 AM, Sarah Sharp
> <sarah.a.sharp@linux.intel.com> wrote:
> > What makes you think that? =A0I've seen URB buffers with 64-bit DMA
> > addresses. =A0I can tell when the debug polling loop runs and I look at
> > the DMA addresses the xHCI driver is feeding to the hardware:
> >
> > Dev 1 endpoint ring 0:
> > xhci_hcd 0000:05:00.0: @71a49800 01000680 00080000 00000008 00000841
> >
> > So the TRB at address 71a49800 is pointing to a buffer at address
> > 0x0008000001000680.
> =

> I'm not sure why the address would be that huge, unless it's not
> actually a physical address, or there's some kind of remapping going
> on?
> =

> >
> > If I'm setting a DMA mask wrong somewhere, or doing something else to
> > limit the DMA to 32-bit, then please let me know.
> =

> The DMA mask for the controller isn't being set anywhere (in the
> version that's in Linus' current git anyway). In that case it'll
> default to 32-bit and any DMA mappings above 4GB will need to be
> remapped. The controller driver doesn't do the mapping itself but the
> USB core does, passing in the controller device as the one doing the
> DMA, so if the controller's DMA mask is set to 32-bit then the buffers
> passed in will get remapped/bounced accordingly.

So if we're seeing physical addresses in the log above, and the xHCI
driver does not explicitly allow the USB core to use addresses above
4GB, why shouldn't the same thing be true as well for EHCI?
(Which would then be exactly the case we're seeing)

Daniel
