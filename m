From: Jan Depner <eviltwin69@cableone.net>
Subject: Re: TASCAM US-1641
Date: Wed, 24 Mar 2010 17:02:46 -0500
Message-ID: <1269468166.7429.7.camel@eviltwin>
References: <1269394483.6635.11.camel@eviltwin>
	<20100324055626.GH30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from S3.cableone.net (s3.cableone.net [24.116.0.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 5853B24343
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 23:02:48 +0100 (CET)
In-Reply-To: <20100324055626.GH30801@buzzloop.caiaq.de>
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
Cc: ALSA_DEVEL <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Wed, 2010-03-24 at 06:56 +0100, Daniel Mack wrote:
> On Tue, Mar 23, 2010 at 08:34:43PM -0500, Jan Depner wrote:
> > A couple of weeks ago I purchased a TASCAM US-1641 on the off chance
> > that I might be able to get the thing working on Linux (or give up and
> > use it in Windows ;-)  I have built the 2.6.33 kernel and started
> > playing around in Karsten Wiese's US-122L module to see what I could get
> > to happen.  I did this on the off chance that TASCAM just increased the
> > number of ports but used the same protocol for communication that they
> > used for the US-122L.  I added an entry for the US-1641 in us122l.h
> > (#define USB_ID_US1641 0x8017) and then added an entry to the
> > snd_us122l_usb_id_table in us122l.c.  After recompiling and installing
> > the modules I get the following in my dmesg output when I turn the
> > device on:
> > 
> > usb 1-2: new high speed USB device using ehci_hcd and address 3
> > couldn't __get_free_pages()
> > snd-usb-us122l: probe of 1-2:1.1 failed with error -22
> 
> I'm not familiar with this driver in particular, but looking at the
> code to produce this error message, I believe that something in the
> calculation of the number of pages to allocate goes wrong. Most
> probabably usb_stream_new() is invoked with bogus parameters and so the
> size variables overflow to some ridiculous value.
> 

    Yes, that was where it was.


> I suggest adding some printk()s to the driver and see what it actually
> does and which values it passes around. Most probably there is more
> differences in the data format, and descriptors and/or message blocks
> have different meanings for this hardware model.
> 

    I did as suggested and got back reasonable appearing numbers for
rate, use_packsize, and period_frames of 44100, 36, and 256 respectively
but am not sure how to relate this to my interface.  Is there some
documentation somewhere that would explain the output of lsusb -v with
respect to variable names in us122l.c.  My problem here is that I don't
know what would actually be reasonable for this interface nor how to
find out.


    Many thanks for your help with this.  Karsten had asked me to get
back with him if I got one of these but my email to him must have gone
to the spam filter as I haven't heard anything.



> HTH,
> Daniel
