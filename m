From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: (no subject)
Date: Wed, 10 May 2006 19:26:46 +0200
Message-ID: <20060510172646.GD6013@turing.informatik.uni-halle.de>
References: <1429.61.5.113.68.1146793047.squirrel@mail.mumufarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1429.61.5.113.68.1146793047.squirrel@mail.mumufarm.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: OcHe <oche@mumufarm.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OcHe wrote:
> I'm working for my final thesis project, it's something about MIDI over
> IP, i'm planning to use aseqnet for the demonstration purpose, my main
> focus is about performance, how to calculate elapsed time (event data
> traveled between Yamaha PSRA to Host A to Host B to Yamaha PSRB) (vice
> versa). I'm running Fedora Core 4 (ALSA seems to work great with my
> device) and C as the programming language.
> 
> Host A - Local LAN - Host B
>   |                  |
> Yamaha             Yamaha
> Keyboard           Keyboard
> 
> My questions are:
> 
> 1. How to calculate elapsed time data traverse from Yamaha to Computer ?

The time for the actual transmission of MIDI commands is easily
calculated, knowing that the bit rate is 31250 Hz and each byte (plus
start and stop bits) needs 10 bits.

More interesting might be the times from the key press to the actual
transmission of the command, and from the arrival of the command at the
computer until the software actually deals with it.  But these are not
related to the IP transmission.

> 2. How to calculate elapsed time  data traverse from Host A to Host B (i'm
> just guessing maybe i could use ping to show RTT?? is this the correct
> answer?)

Different network protocols might have different latencies (ping uses
ICMP, aseqnet uses TCP).

You might want to send the data back to host A and divide the time by
two.

Another approach would be to run some soft synth (or better some
hardware synth) on both computers, and record the output of both on the
left/right channels of a stereo sound card, so that the delay between
them can easily be measured.

> 5. How long (in millisecond / second ??) should the total elapsed time be,
> to make the realtime playing feasible?

A value usually mentioned is ten milliseconds.
(Real organists deal with latencies of about one second.)


HTH
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
