From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
Subject: Re: sb 16 pro + alsa 0.5.12a + k 2.4.17
Date: Sun, 10 Feb 2002 21:42:43 +0100
Message-ID: <20020210204243.GA22208@arthur.ubicom.tudelft.nl>
References: <3C66C614.3000709@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from duteinh.et.tudelft.nl (root@duteinh.et.tudelft.nl [130.161.42.1])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA18261
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2002 21:42:53 +0100
Content-Disposition: inline
In-Reply-To: <3C66C614.3000709@free.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ludovic Drolez <ldrolez@free.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 10, 2002 at 08:12:20PM +0100, Ludovic Drolez wrote:
> I trying to make my SB16Pro work (not pnp). I've compiled alsa with no isa 
> pnp support but when I insert the module I get the following messages:
> 
> /lib/modules/2.4.17-k6/misc/snd-card-sb16.o: init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters, including 
> invalid IO or IRQ parameters

Very clear error message: please supply proper parameters for the
snd-card-sb16 module. "modinfo snd-card-sb16" will tell you what
parameters the module accepts.

> /lib/modules/2.4.17-k6/misc/snd-card-sb16.o: insmod 
> /lib/modules/2.4.17-k6/misc/snd-card-sb16.o failed
> /lib/modules/2.4.17-k6/misc/snd-card-sb16.o: insmod snd-card-sb16 failed
> 
> and dmesg says:
> 
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> snd: Sound Blaster 16 soundcard #1 not found at 0x220 or device busy
> snd: Sound Blaster 16 soundcard #2 not found or device busy
> 
> BUT, If I switch to k 2.2.19 and recompile alsa 0.5.12 or 0.5.11 it works 
> perfectly !!! So, Yet Another Kernel 2.4. bug ????

I don't think so. I think you either forgot to specify the correct
module parameters, or you somehow loaded the kernel Soundblaster
driver.

Did you read the file Documentation/Changes in the kernel source tree?
The linux-2.4 kernels need quite some new userland programs to work
properly.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
