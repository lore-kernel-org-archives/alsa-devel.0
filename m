From: Frank Barknecht <fbar@footils.org>
Subject: Re: [PATCH] UA-3FX support
Date: Thu, 12 Feb 2004 18:55:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040212175559.GD2553@fliwatut.scifi>
References: <Pine.HPX.4.33n.0402121210270.14784-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0402121210270.14784-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
Clemens Ladisch hat gesagt: // Clemens Ladisch wrote:

> Frank Barknecht wrote:
> > Now I discovered a teenytiny switch on the back if the UA-3 FX that
> > switches the "Advanced Driver"  features of the device on or off.
> > Setting this to OFF, I now got ALSA to recognize the device as a
> > simple 44100 Hz device. No higher samplerates, though.
> > Probably a quirk is needed?
> 
> The descriptors in "advanced" mode look like this:
> 
> > unknown descriptor type: 0b 24 02 01 02 03 18 01 44 ac 00
> 
> which is 24 bits at 44.1 kHz.  Probably there is another switch for
> the sample rate. :-)
> 
> The device has another interface (3) without any descriptors.  You
> wouldn't know, just by chance, if the Windows driver offers some MIDI
> port, or some device-specific control application for the effects?

No, I don't know this. Also this device is already sent back by me to
c't, too.  I didn't test it on MS-Windows because a lack of MS-Windows
here. Maybe the Edirol website has some manuals? I didn't check it
out. 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
