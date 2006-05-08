From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SB Live! 24-Bit External: remote control support : more details
Date: Mon, 08 May 2006 13:48:41 +0200
Message-ID: <20060508114841.GA23340@turing.informatik.uni-halle.de>
References: <44512925.30803@vardes.lv>
 <20060428084200.GA26640@turing.informatik.uni-halle.de>
 <4451E5C2.7050104@vardes.lv>
 <20060505075159.GA2171@turing.informatik.uni-halle.de>
 <pan.2006.05.07.23.29.22.651163@free.fr>
 <20060508071454.GC11272@turing.informatik.uni-halle.de>
 <445F052D.5020102@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <445F052D.5020102@free.fr>
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
To: "vitton.laforest" <vitton.laforest@free.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(please don't top-post)

vitton.laforest wrote:
> Clemens Ladisch a e'crit:
> >jpv wrote:
> >>Impossible to get the remote control working with my Live 24 external even
> >>with the patch.
> >>
> >>No device corresponding to the remote control.
> >>and nothing in /proc/asound/hwdep 
> >
> >What are the contents of /proc/asound/cards?
> 
>  0 [External       ]: USB-Audio - SB Live! 24-bit External
>                       Creative Technology SB Live! 24-bit External at usb-0000:00:02.3-3, full speed
>  1 [SI7012         ]: ICH - SiS SI7012
>                       SiS SI7012 with CMI9738 at 0xdc00, irq 10
>  2 [ALS4000        ]: ALS4000 - Avance Logic ALS4000
>                       Avance Logic ALS4000 at 0xd400, irq 11

So the driver is loaded correctly.

What is the output of lsusb?

Did you unload and reload all sound modules after patching and
recompiling the driver?


Regards,
Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
