From: Ludovic Drolez <ldrolez@free.fr>
Subject: Re: sb 16 pro + alsa 0.5.12a + k 2.4.17
Date: Sun, 10 Feb 2002 22:44:49 +0100
Message-ID: <3C66E9D1.1020302@free.fr>
References: <3C66C614.3000709@free.fr> <20020210204243.GA22208@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from red.localdomain (strasbourg-1-a7-9-7.dial.proxad.net [62.147.9.7])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA19247
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2002 22:45:26 +0100
Received: from localhost ([127.0.0.1] helo=free.fr)
	by red.localdomain with esmtp (Exim 3.12 #1 (Debian))
	id 16a1mD-0000oT-00
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2002 22:44:49 +0100
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



Erik Mouw wrote:

> On Sun, Feb 10, 2002 at 08:12:20PM +0100, Ludovic Drolez wrote:
> 
>>I trying to make my SB16Pro work (not pnp). I've compiled alsa with no isa 
>>pnp support but when I insert the module I get the following messages:
>>
>>/lib/modules/2.4.17-k6/misc/snd-card-sb16.o: init_module: No such device
>>Hint: insmod errors can be caused by incorrect module parameters, including 
>>invalid IO or IRQ parameters
>>
> 
> Very clear error message: please supply proper parameters for the
> snd-card-sb16 module. "modinfo snd-card-sb16" will tell you what
> parameters the module accepts.
> 

I have supplied all parameters you can imagine. And my launch script is the same for k 
2.2.19, and for 2.4.17...


> 
>>/lib/modules/2.4.17-k6/misc/snd-card-sb16.o: insmod 
>>/lib/modules/2.4.17-k6/misc/snd-card-sb16.o failed
>>/lib/modules/2.4.17-k6/misc/snd-card-sb16.o: insmod snd-card-sb16 failed
>>
>>and dmesg says:
>>
>>isapnp: Scanning for PnP cards...
>>isapnp: No Plug & Play device found
>>snd: Sound Blaster 16 soundcard #1 not found at 0x220 or device busy
>>snd: Sound Blaster 16 soundcard #2 not found or device busy
>>
>>BUT, If I switch to k 2.2.19 and recompile alsa 0.5.12 or 0.5.11 it works 
>>perfectly !!! So, Yet Another Kernel 2.4. bug ????
>>
> 
> I don't think so. I think you either forgot to specify the correct
> module parameters, or you somehow loaded the kernel Soundblaster
> driver.
> 

lsmod |grep sb
 > nothing


> Did you read the file Documentation/Changes in the kernel source tree?
> The linux-2.4 kernels need quite some new userland programs to work
> properly.
> 


Yes, I have upgraded dozen of packages (a Debian 2.2 with bunk's packages).
What I find strange is: the kernel is scanning for pnp card although I told alsa to ignore 
pnp card....


> 
> Erik
> 
> 


-- 
http://www.palmopensource.com       - The PalmOS Open Source Portal
http://www.drolez.com      - Personal site - Linux and PalmOS stuff


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
