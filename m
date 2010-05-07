From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 07 May 2010 11:47:37 +0200
Message-ID: <4BE3E1B9.5020602@ladisch.de>
References: <g2h74fd948d1004141820ladc1941eo732d059dd678df0a@mail.gmail.com>	<Pine.LNX.4.44L0.1004151114490.1562-100000@iolanthe.rowland.org>	<t2r74fd948d1004191716l49dedc2p25a27da39bcc614a@mail.gmail.com>
	<20100507074855.GF30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D1F93244E1
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 11:47:46 +0200 (CEST)
In-Reply-To: <20100507074855.GF30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, USB list <linux-usb@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, iommu@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> The problem is again (summarized):
> 
> On 64bit machines, with 4GB or more, the allocated buffers for USB
> transfers might be beyond the 32bit boundary. In this case, the IOMMU
> should take care and install DMA bounce buffer to copy over the buffer
> before the transfer actually happens. The problem is, however, that this
> copy mechanism takes place when the URB with its associated buffer is
> submitted, not when the EHCI will actually do the transfer.
> 
> In the particular case of audio drivers, though, the contents of the
> buffers are likely to change after the submission. What we do here
> is that we map the audio stream buffers which are used by ALSA to
> the output URBs, so they're filled asychronously. Once the buffer is
> actually sent out on the bus, it is believed to contain proper audio
> date. If it doesn't, that's due to too tight audio timing or other
> problems. This breaks once buffers are magically bounced in the
> background.

At least the audio class and ua101 drivers don't do this and fill the
buffers before they are submitted.

> So - long story short: these audio buffers need to be DMA coherent.

Does the USB API actually guarantee that all controllers use DMA, i.e.,
that the buffers can be filled after submission?


Regards,
Clemens
