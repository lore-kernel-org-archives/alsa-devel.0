From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Device references for MIDI sub-devices
Date: Thu, 24 Feb 2005 13:28:42 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0502241311190.300-100000@studcom.urz.uni-halle.de>
References: <opsmo45hdan0kn27@linux.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <opsmo45hdan0kn27@linux.site>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Adair <adair@gotadsl.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bill Adair wrote:
> I'm nearly at the end of the development of my serial port driver
> for the Opcode 64X and am testing it with various applications. My
> current problem / question is - How do I refer to the different
> sub-devices shown below?
>
> linux:/home/billa # amidi -l
> Device    Name
> hw:1,0    uart16550 MIDI #0 (4 subdevices)
>
> JSynthLib will only make contact with /dev/snd/midiC1D0 which is 0
> 'uart16550 MIDI #0-0' or the first output port on the device. Are
> there ways of refering to the other ports using /dev/snd/XXXXXX?

The device nodes in /dev/snd/ are internal to ALSA and shouldn't be
used directly.  The ALSA device names would be "hw:1,0,0", "hw:1,0,1"
etc.

If a program doesn't support ALSA, use the OSS device file /dev/midi0x
and /dev/amidi0x.  However, the OSS emulation doesn't support
selecting subdevices.  As a workaround, load the snd-virmidi driver
and connect its ports to the device's ports.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
