From: Daniel Mack <daniel@caiaq.de>
Subject: Re: TASCAM US-1641
Date: Wed, 24 Mar 2010 06:56:26 +0100
Message-ID: <20100324055626.GH30801@buzzloop.caiaq.de>
References: <1269394483.6635.11.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D84F1037FF
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 06:57:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269394483.6635.11.camel@eviltwin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jan Depner <eviltwin69@cableone.net>
Cc: ALSA_DEVEL <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 23, 2010 at 08:34:43PM -0500, Jan Depner wrote:
> A couple of weeks ago I purchased a TASCAM US-1641 on the off chance
> that I might be able to get the thing working on Linux (or give up and
> use it in Windows ;-)  I have built the 2.6.33 kernel and started
> playing around in Karsten Wiese's US-122L module to see what I could get
> to happen.  I did this on the off chance that TASCAM just increased the
> number of ports but used the same protocol for communication that they
> used for the US-122L.  I added an entry for the US-1641 in us122l.h
> (#define USB_ID_US1641 0x8017) and then added an entry to the
> snd_us122l_usb_id_table in us122l.c.  After recompiling and installing
> the modules I get the following in my dmesg output when I turn the
> device on:
> 
> usb 1-2: new high speed USB device using ehci_hcd and address 3
> couldn't __get_free_pages()
> snd-usb-us122l: probe of 1-2:1.1 failed with error -22

I'm not familiar with this driver in particular, but looking at the
code to produce this error message, I believe that something in the
calculation of the number of pages to allocate goes wrong. Most
probabably usb_stream_new() is invoked with bogus parameters and so the
size variables overflow to some ridiculous value.

I suggest adding some printk()s to the driver and see what it actually
does and which values it passes around. Most probably there is more
differences in the data format, and descriptors and/or message blocks
have different meanings for this hardware model.

HTH,
Daniel
