From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Conexant test8 results for Toshiba owners.
Date: Sat, 04 Nov 2006 19:21:02 -0800
Message-ID: <1162696862.15901.1.camel@razman>
References: <1162674506.15262.18.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1162674506.15262.18.camel@razman>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

New update for Toshiba users.  Some are reporting that turning off acpi
at boot makes sound work.  Try adding "acpi=off" to your kernel boot
options.

Tobin

On Sat, 2006-11-04 at 13:08 -0800, Tobin Davis wrote:
> First, a note to all testers.  The Alsa-Configuration.txt patch may
> fail.  Ignore it, it's just documentation and the patch is against the
> alsa-driver tip.
> 
> I'm getting very different responses from Toshiba owners:
> 
> Toshiba Satellite P105-S9312:
>         alsamixer shows 8 elements: Master, PCM, PCM Capt, Mic Bypa,
>         IEC958, Capture, ExtMic, IntMic
>         In testing, using aplay with simple wav and au files, no sound
>         from speakers or headphones.  Mic's not tested at this time.
>         Tried loading using model=test, all results the same as above.
> Toshiba Satellite P100-114:
>         Here are the results of Patch 8 test:  ========>   No
>         sound   :-(
>     - Master:            ok
>     -  PCM:              ok
>     - Mic Bypass:     ok
>     - IEC958:           Just the mute/unmute case
>     - Capture:          ok
>     - ExtMic:           nothing
>     - IntMic:            nothing
> Toshiba P100-240:
>         Another Oops on loading under Toshiba P100
>         BUG: unable to handle kernel NULL pointer dereference at virtual
>         address 00000000
>         .
>         .
>         .
>         
> But on Toshiba Satellite P100-119:
>         Sound is working great now, it was working before but it was
>         very quiet. Now the sound is pretty loud. Alsamixer got a couple
>         of new mixers: IEC958, MicBypass, ExtMic and IntMic. 
>         An external Mic connected to the mic-jack is working with IntMic
>         selected. I tested it with arecord and it works great, sound is
>         loud and clear. But when I choose alsa as the input-plugin in
>         gstreamer-properties it still reports that it couldn't open the
>         ressource for writing, but I think it is an other problem ;-).
>         The external Mic is not working with ExtMic selected. The
>         Toshiba Satellite P100-119 has no internal mic. 
>         I don't really know what that IEC958 mixer is for. 
>         Couldn't test the Line-In-Jack jet, because i don't have an
>         external sound device around.
>         So I think the patch is working very well for me. Well done!
>         Excellent work!!!
>         
> Here is where it gets frustrating.  EVERY Toshiba model that has been
> reported has the same codec id:
>         # cat /proc/asound/card0/codec#0
>         
>         Codec: Conexant CXT5047
>         Address: 0
>         Vendor Id: 0x14f15047
>         Subsystem Id: 0x1179ff31
>         Revision Id: 0x100000
>         .
>         .
>         .
> 
> and the same pci subdevice id:
>         # lspci -s 0:1b -vn
>         00:1b.0 0403: 8086:27d8 (rev 02)
>                  Subsystem: 1179:ff31
>         
> Where do we go from here?  I really need everyone to send me
> their /proc/asound/card0/codec#0 output, this time both with, and
> without the patch (means recompiling the driver without applying my
> patch).  Hopefully there is something here that can be used to
> differentiate these systems.
> 
-- 
Tobin Davis <tdavis@dsl-only.net>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
