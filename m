From: Ludovic Drolez <ldrolez@free.fr>
Subject: sb 16 pro + alsa 0.5.12a + k 2.4.17
Date: Sun, 10 Feb 2002 20:12:20 +0100
Message-ID: <3C66C614.3000709@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from red.localdomain (strasbourg-1-a7-9-96.dial.proxad.net [62.147.9.96])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA16839
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2002 20:12:51 +0100
Received: from localhost ([127.0.0.1] helo=free.fr)
	by red.localdomain with esmtp (Exim 3.12 #1 (Debian))
	id 16ZzOe-0000gJ-00
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2002 20:12:20 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi !

I trying to make my SB16Pro work (not pnp). I've compiled alsa with no isa pnp support but 
when I insert the module I get the following messages:

/lib/modules/2.4.17-k6/misc/snd-card-sb16.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or 
IRQ parameters
/lib/modules/2.4.17-k6/misc/snd-card-sb16.o: insmod 
/lib/modules/2.4.17-k6/misc/snd-card-sb16.o failed
/lib/modules/2.4.17-k6/misc/snd-card-sb16.o: insmod snd-card-sb16 failed

and dmesg says:

isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
snd: Sound Blaster 16 soundcard #1 not found at 0x220 or device busy
snd: Sound Blaster 16 soundcard #2 not found or device busy

BUT, If I switch to k 2.2.19 and recompile alsa 0.5.12 or 0.5.11 it works perfectly !!! 
So, Yet Another Kernel 2.4. bug ????

Cheers,

   Ludovic Drolez.


-- 
http://www.palmopensource.com       - The PalmOS Open Source Portal
http://www.drolez.com      - Personal site - Linux and PalmOS stuff


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
