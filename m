From: ian esten <deviant@custard.org>
Subject: Re: midisport 8x8
Date: Wed, 14 Apr 2004 13:00:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1081962042.31370.8.camel@ianhome.meee.net>
References: <Pine.HPX.4.33n.0404140834130.18694-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0404140834130.18694-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-04-14 at 10:00, Clemens Ladisch wrote:

> 
> 21 hexadecimal = 33 decimal

ah ok.

> 
> > Apr 13 14:49:33 [kernel] usb.c: USB disconnect on device 00:1f.4-1 address 9
> > Apr 13 14:49:34 [kernel] hub.c: new USB device 00:1f.4-1, assigned address 10
> > Apr 13 14:49:39 [kernel] usb_control/bulk_msg: timeout
> >                 - Last output repeated 4 times -
> > Apr 13 14:50:00 [kernel] hub.c: new USB device 00:1f.4-1, assigned address 11
> > Apr 13 14:50:05 [kernel] usb_control/bulk_msg: timeout
> >
> > the midisport never shows up in /proc/asound/cards.
> 
> I guess it doesn't shop up in /proc/bus/usb/devices or in the output
> of lsusb, either?

no, it doesn't

> 
> What version of the firmware loader do you use?

0.3

> 
> What happens when you exchange the two 8x8 files in
> /usr/share/usb/midisport?

i get a working midisport 8x8! i can send it midi, and it shows up in
/proc/asound/cards. thanks so much! so why is it incorrectly being
reported as hardware version 1.21?

> 
> > i also have a midisport 8x8 at work (hardware version 1.21)
> 
> What hexadecimal version number does this one have? (bcdDevice field
> of "lsusb -v")
> 
> > which i brought home to check i had everything set up ok. here is
> > what it reports to /var/log/messages:
> >
> > Apr 13 14:53:12 [kernel] hub.c: connect-debounce failed, port 1 disabled
> > Apr 13 14:53:14 [kernel] hub.c: new USB device 00:1f.4-1, assigned address 12
> > Apr 13 14:53:14 [kernel] devfs_register(unknown): could not append to parent, err: -17
> > Apr 13 14:53:17 [usb.agent] missing kernel or user mode driver snd-usb-audio
> 
> Are these all the messages for this device?  If yes, then this one
> already has the firmware in its ROM and doesn't need a firmware
> download.
> 

ok.

> 
> Regards,
> Clemens
> 

thanks very much for your help!
ian




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
