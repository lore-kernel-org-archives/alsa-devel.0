From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Sat, 10 Apr 2010 14:49:12 +0200
Message-ID: <20100410124912.GP30801@buzzloop.caiaq.de>
References: <m2n74fd948d1004081613n90408827s7c51ef572848fb1d@mail.gmail.com>
	<Pine.LNX.4.44L0.1004091155570.1852-100000@iolanthe.rowland.org>
	<20100409180942.GK30801@buzzloop.caiaq.de>
	<w2r74fd948d1004091119j9f33d8a6kc1824d9243abf38b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BFC2F243F0
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Apr 2010 14:49:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w2r74fd948d1004091119j9f33d8a6kc1824d9243abf38b@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, akpm@linux-foundation.org, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 09, 2010 at 07:19:22PM +0100, Pedro Ribeiro wrote:
> On 9 April 2010 19:09, Daniel Mack <daniel@caiaq.de> wrote:
> > On Fri, Apr 09, 2010 at 12:01:27PM -0400, Alan Stern wrote:
> >> I don't see anything suspicious. =A0The transfer_buffer addresses repe=
at
> >> every 32 URBs, and the DMA addresses cycle almost entirely uniformly
> >> from 0x20000000 to 0x23ffffff in units of 0x2000 (there are a few gaps
> >> where the interval is a little bigger).
> >
> > The DMA pointers do indeed look sane. I wanted to take a deeper look at
> > this and set up a 64bit system today. However, I fail to see the problem
> > here. Pedro, how much RAM does your machine have installed?
> >
> > Daniel
> >
> >
> =

> It has 4 GB.

Upgraded my machine now to 4GB, but I still can't reproduce this bug.
Pedro, can you send your config, please?

Daniel
