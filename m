From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Tascam US-224 support: MIDI OK, Audio KO?
Date: Mon, 29 Mar 2004 22:00:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040329200027.GA576@tuba.home>
References: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 29, 2004 at 12:34:25PM +0100, Rui Nuno Capela wrote:
> 
> My first question goes whether us428control's not recognizing any USx2y
> hardware dependant stuff (hwdep) either on hw:0 or hw:1. I'm almost sure
> that it should be on hw:1 as the US-224 is configured as my second
> soundcard under the ALSA configuration (i.e. alias snd-usb-usx2y
> snd-card-1). But us428control does not find anything, at least after the
> firmware gets loaded.
> 

I remember a hint by Karsten:

try to get us428control running first. if us224 is very similar to 428,
you'll get a printout of lots of control numbers if you use the controls and 
have started us428control with option -v2.

> Strange enough, to me at least, us428control seems to work between the fw
> and fpga loading steps. Using lsusb, I've noticed that the USB ids do
> change from 1604:8004 to 1604:8005 while plugging in. Guess that's normal,
> and it marks the momemt when fw is loaded and fpga is about to.

It's normal. If the fw step is ok, a reset of the device will be executed.
Then it says hello with another new ID 8005.

> 
> The second one is about the LEDs on the control surface: besides the USB
> light, isn't that supposed to light up anything else? Everything else is
> dead dark. Touching the knobs, pushing the buttons or whatever doesn't
> make any visible difference. Is that supposed to be normal?

No control without us428control. 

> OK. I've tested on two different systems, a Compaq laptop w/Mandrake 10.0
> (P4 2.533GHz, OHCI) and on a custom desktop w/SUSE 9.0 (P4 3.333GHz
> SMP/HT, UHCI). On both, the firmware seems to get loaded and only visible
> thing to note is that the USB light gets lit.

BTW: The OHCI bug (pointed out by Clemens) is still in the code.
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11899.html

> Mar 28 23:33:39 gamma-suse1 kernel: usb 2-1: control timeout on ep0in

Looks like disconnecting the former ID hangs somehow. Or do I misunderstand
this message here.


bye,
martin


-- 
Living on earth may be expensive,
	but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
