From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: usbaudio won't do 24-bit or 32-bit i/o, and won't
 do 96000 frames per second
Date: Fri, 6 Dec 2002 11:09:55 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212061107050.527-100000@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0212060935510.27122-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0212060935510.27122-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "John S. Denker" <jsd@monmouth.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Patrick Shirkey <pshirkey@boosthardware.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 6 Dec 2002, Clemens Ladisch wrote:

> John S. Denker wrote:
> > As requested:
> >
> > 1)    lsusb
> > Unknown line at line 1809
> > Duplicate HUT Usage Spec at line 2650
> > Bus 001 Device 001: ID 0000:0000 Virtual Hub
> > Bus 001 Device 003: ID 041e:3000 Creative Labs
> 
> Oops. I forgot to tell you to use "lsusb -vv". But don't bother, the od
> output suffices for now.
> 
> > 2) The od is attached as a .txt file.
> 
> The descriptors announce the following capabilities:
> 
> interface 0: various (mixer) controls
> interface 1: output 16 bits at 48 kHz, 2 channels
> interface 2: input 16 bits at 8/16/24/32/48 kHz, 2 channels
> interface 3: output AC-3 at 44.1/48 kHz
> 
> ... and that's it.
> 
> Now when I look at the specifications at
> <http://www.soundblaster.com/products/extigy/specs.asp> it turns out that
> Creative isn't outright lying, only being _extremely_ misleading: the page
> says that the ADC and DAC are capable of converting 24 bit data at 96kHz,
> but it does _not_ say that this bit depth and/or samping rate can be used
> to playback or record data from/to the computer. (It says the SPDIF input
> can do 24@96, but that's of no use if this format cannot be sent over the
> USB bus.)
> 
> 6-channel output is supported with AC-3 only, but the driver currently
> doesn't support AC-3.
> 
> 
> To summarize: Where it matters, the Extigy does neither 24 bits nor 96kHz.
> For professional audio, you have to go elsewhere.

Another big joke from the Creative PR staff ;-((
Patrick, could you add this info to USB device web pages?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
