From: Frank Barknecht <fbar@footils.org>
Subject: Re: M-Audio USB Quattro on 2.6.x
Date: Mon, 16 Feb 2004 21:16:36 +0100
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <20040216201635.GB4810@fliwatut.scifi>
References: <1076950250.683.38.camel@puppeli> <Pine.LNX.4.44L0.0402161233140.1490-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0402161233140.1490-100000@ida.rowland.org>
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hallo,
Alan Stern hat gesagt: // Alan Stern wrote:

> You didn't say exactly what the Quattro is doing wrong.  I can guess that 
> it doesn't number its altsettings sequentially starting from 0.  Is that 
> right?

Maybe you remember that post by my last week or so on linux-usb-devel
asking for an explanation of "what does invalid alternate setting
mean" which you kindly answered with an explanation. That's the one, I
also posted a "cat /proc/bus/usb/devices  | grep Alt" for the Quattro. 

I did test a whole bunch of USB audio devices that week, 21 devices to
be exact. Tests were done on 2.4.22 and 2.6.2-rc3. I didn't have the
M-Audio Audiophile USB, but the Quattro which showed described
behaviour. 

*All* the 20 other devices got the alt numbering right, though. 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
