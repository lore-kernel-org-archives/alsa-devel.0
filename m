From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RC5 driver make fail (usbaudio.c)
Date: Thu, 24 Oct 2002 17:44:17 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210241742120.20299-100000@studcom.urz.uni-halle.de>
References: <200210241501.08075.phil@plus24.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200210241501.08075.phil@plus24.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Phil Kerr <phil@plus24.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Phil Kerr wrote:
> Attached is the configure and make dump of alsa-drivers-rc5 (webserver
> timestamp 10/24/2002  02:47:00 PM).
>
> 100% stock RH 8.0 installed an hour before with a es1371 card.
>
> ../alsa-kernel/usb/usbaudio.c: In function `snd_usb_roland_ua100_hack':
> ../alsa-kernel/usb/usbaudio.c:1938: initializer element is not constant
> ../alsa-kernel/usb/usbaudio.c:1938: (near initialization for `midi_quirk.data')

What is your compiler version?
That code is valid C99 (I think :) and compiles with my gcc 2.95.3.


Clemens



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4729346;7592162;s?http://www.sun.com/javavote
