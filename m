From: Frank Barknecht <fbar@footils.org>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Wed, 11 Feb 2004 19:00:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040211180013.GF6493@fliwatut.scifi>
References: <20040210213617.GH10941@fliwatut.scifi> <Pine.HPX.4.33n.0402111036160.24733-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0402111036160.24733-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hallo,
Clemens Ladisch hat gesagt: // Clemens Ladisch wrote:

> Frank Barknecht wrote:
> > The main reason for my assumption is the value for bInterfaceNumber
> > which is "3" or 0x03 as it should be according to the USB spec which
> > requires for a "MIDI Adapter Standard MIDIStreaming Interface
> > Descriptor" to have this field set as follows:
> >
> > Offset Field                Size  Value   Description
> > ...
> > 6      bInterfaceSubclass   1     0x03   MIDISTREAMING.
> > ...
> 
> The bInterfaceNumber field simply specifies the number (i.e., the
> index) of the interface.  Interfaces must be numbered 0, 1, 2, etc.

Ah, my fault: I intended to write "bInterfaceSubclass" as in the
spec quote... 

> The problem is that bInterfaceClass isn't set to 1 (Audio).
> 
> The class-specific descriptors are there (lsusb shows them as
> "unknown" because it doesn't try to parse vendor-specific things), so
> it should be possible to use the MIDI_STANDARD_INTERFACE quirk (see
> below).

I'd love to test it, but I had to send back the device already. :(
Could you test it? 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
