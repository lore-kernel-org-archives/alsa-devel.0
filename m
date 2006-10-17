From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Problems with Realtek ALC260 codec (snd_hda_intel
	driver)
Date: Wed, 18 Oct 2006 08:43:55 +0930 (CST)
Message-ID: <200610172313.k9HNDt82025158@turbo.physics.adelaide.edu.au>
References: <mailman.5635.1161096490.22397.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.5635.1161096490.22397.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Oct 17,
	2006 07:48:10 AM
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

> It seems that I have a laptop with ALC260 codec that is absolutely
> silent either with alsa-driver-1.0.13 or with Realtek's
> alsa-driver-1.0.12-4.05b.
> 
> Playing with "model=" parameter does not help.
>
> lspci -nv:
> ...
> 00:1b.0 Class 0403: 8086:27d8 (rev 02)
>         Subsystem: 161f:2057
>         Flags: bus master, fast devsel, latency 0, IRQ 3
> :
> cat /proc/asound/card0/codec#0 (from 1.0.13) :
> 
> Codec: Realtek ALC260
> Address: 0
> Vendor Id: 0x10ec0260
> Subsystem Id: 0x161f0000
> Revision Id: 0x100400

Could you please try compiling alsa-driver-1.0.13 after configuring it
using
  ./configure --enable-debug

Then use model=test.  Turn every control up, unmute every control, change
all "pin mode" controls to "headphone" and see if you get any sound then
from anywhere.  If not, try turning all the GPIO controls ON (they default
to OFF).

Once you get sound happening we can use the "test" model to work out the
details of precisely how your laptop uses the ALC260 and add the necessary
support to ALSA.

Could you please let us know the make and model of the laptop?

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
