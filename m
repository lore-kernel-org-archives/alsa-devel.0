From: Matthias Saou <matthias@rpmforge.net>
Subject: Re: RC5 driver make fail (usbaudio.c)
Date: Thu, 24 Oct 2002 16:24:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021024162427.73330e57.matthias@rpmforge.net>
References: <200210241501.08075.phil@plus24.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200210241501.08075.phil@plus24.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Once upon a time, Phil wrote :

> 100% stock RH 8.0 installed an hour before with a es1371 card.
> 
> It's failed at:
> 
> In file included from usbaudio.c:2:
> ../alsa-kernel/usb/usbaudio.c: In function `snd_usb_roland_ua100_hack':
> ../alsa-kernel/usb/usbaudio.c:1938: initializer element is not constant
> ../alsa-kernel/usb/usbaudio.c:1938: (near initialization for 
> `midi_quirk.data')
> make[1]: *** [usbaudio.o] Error 1
> make[1]: Leaving directory `/home/phil/installs/alsa-driver-0.9.0rc5/usb'
> make: *** [compile] Error 1

Strange, I've had no problems whatsoever on a fully updated vanilla Red Hat
Linux 8.0 system (kernel 2.4.18-17.8.0), compiling all drivers just like
you did.

Matthias

-- 
Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
Red Hat Linux release 7.3 (Valhalla) running Linux kernel 2.4.18-10acpi
Load : 0.09 0.14 0.21


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4729346;7592162;s?http://www.sun.com/javavote
