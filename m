From: Felix Homann <fexpop@web.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 08 Jul 2010 17:14:34 +0200
Message-ID: <4C35EB5A.50304@web.de>
References: <4C32E3B2.5080707@web.de>	<4C344340.8060804@web.de>	<4C3476BD.4090702@ladisch.de>	<4C347EF7.2030401@web.de>	<4C348DC6.7070602@ladisch.de>	<4C34B177.1090500@web.de>	<4C356F56.6010804@ladisch.de>
	<4C358DC5.4010403@web.de> <4C35CE2A.50806@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id F33B724350
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 17:14:36 +0200 (CEST)
In-Reply-To: <4C35CE2A.50806@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Felix Homann <fexpop@web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hmm,

I guess  there's still something wrong with your debug patch (or me 
applying it...). Doesn't look like any valuable information in syslog 
this time (no fixed_endpoint quirk):

Jul  8 17:04:16 yerbouti kernel: [19340.109648] usb 2-3: config 1 
interface 3 altsetting 0 bulk endpoint 0x7 has invalid maxpacket 8
Jul  8 17:04:16 yerbouti kernel: [19340.109653] usb 2-3: config 1 
interface 3 altsetting 0 bulk endpoint 0x87 has invalid maxpacket 8
Jul  8 17:04:16 yerbouti kernel: [19340.110762] usb 2-3: New USB device 
found, idVendor=0763, idProduct=2081
Jul  8 17:04:16 yerbouti kernel: [19340.110765] usb 2-3: New USB device 
strings: Mfr=1, Product=2, SerialNumber=0
Jul  8 17:04:16 yerbouti kernel: [19340.110769] usb 2-3: Product: Fast 
Track Ultra 8R
Jul  8 17:04:16 yerbouti kernel: [19340.110771] usb 2-3: Manufacturer: 
M-Audio
Jul  8 17:04:16 yerbouti kernel: [19340.110916] usb 2-3: configuration 
#1 chosen from 1 choice


Regards,

Felix

Am 08.07.2010 15:10, schrieb Clemens Ladisch:
> BUG: unable to handle kernel NULL pointer dereference
>    
> Sorry, the call for the case without the fixed quirk is buggy.
> In line 199 of format.c, please change "fp->rates" to "fp->rate_table".
>
>
>    
