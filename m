From: Felix Homann <fexpop@web.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 08 Jul 2010 17:54:22 +0200
Message-ID: <4C35F4AE.2010704@web.de>
References: <4C32E3B2.5080707@web.de>	<4C344340.8060804@web.de>	<4C3476BD.4090702@ladisch.de>	<4C347EF7.2030401@web.de>	<4C348DC6.7070602@ladisch.de>	<4C34B177.1090500@web.de>	<4C356F56.6010804@ladisch.de>	<4C358DC5.4010403@web.de>
	<4C35CE2A.50806@ladisch.de>	<4C35EB5A.50304@web.de>
	<4C35EC8F.3000401@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id C0C1B1038C4
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 17:54:23 +0200 (CEST)
In-Reply-To: <4C35EC8F.3000401@ladisch.de>
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

Sorry, I really thought I had double checked.

Here you go (without fixed endpoint quirk):

Jul  8 17:49:04 yerbouti kernel: [22027.924017] usb 2-3: new high speed 
USB device using ehci_hcd and address 6
Jul  8 17:49:04 yerbouti kernel: [22028.057581] usb 2-3: config 1 
interface 3 altsetting 0 bulk endpoint 0x7 has invalid maxpacket 8
Jul  8 17:49:04 yerbouti kernel: [22028.057586] usb 2-3: config 1 
interface 3 altsetting 0 bulk endpoint 0x87 has invalid maxpacket 8
Jul  8 17:49:04 yerbouti kernel: [22028.058445] usb 2-3: New USB device 
found, idVendor=0763, idProduct=2081
Jul  8 17:49:04 yerbouti kernel: [22028.058449] usb 2-3: New USB device 
strings: Mfr=1, Product=2, SerialNumber=0
Jul  8 17:49:04 yerbouti kernel: [22028.058452] usb 2-3: Product: Fast 
Track Ultra 8R
Jul  8 17:49:04 yerbouti kernel: [22028.058454] usb 2-3: Manufacturer: 
M-Audio
Jul  8 17:49:04 yerbouti kernel: [22028.058594] usb 2-3: configuration 
#1 chosen from 1 choice
Jul  8 17:49:04 yerbouti kernel: [22028.149465] rates 00000000: 44 ac 00 
00 80 bb 00 00 88 58 01 00 00 77 01 00  D........X...w..
Jul  8 17:49:04 yerbouti kernel: [22028.149471] format 00000000: 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.149474] format 00000010: 00 00 
00 00 01 00 00 00 08 00 00 00 01 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.149477] format 00000020: 00 00 
00 00 01 00 00 00 01 01 01 01 05 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.149480] format 00000030: 38 01 
00 00 c0 06 00 00 44 ac 00 00 00 77 01 00  8.......D....w..
Jul  8 17:49:04 yerbouti kernel: [22028.149483] format 00000040: 04 00 
00 00 00 00 00 00 e8 87 61 50 00 88 ff ff  ..........aP....
Jul  8 17:49:04 yerbouti kernel: [22028.149486] format 00000050: 00 00 
00 00 00 00 00 00                          ........
Jul  8 17:49:04 yerbouti kernel: [22028.152636] rates 00000000: 44 ac 00 
00 80 bb 00 00 88 58 01 00 00 77 01 00  D........X...w..
Jul  8 17:49:04 yerbouti kernel: [22028.152640] format 00000000: 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.152644] format 00000010: 00 00 
00 00 01 00 00 00 08 00 00 00 01 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.152646] format 00000020: 00 00 
00 00 02 00 00 00 01 01 01 81 05 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.152649] format 00000030: 38 01 
00 00 c0 06 00 00 44 ac 00 00 00 77 01 00  8.......D....w..
Jul  8 17:49:04 yerbouti kernel: [22028.152652] format 00000040: 04 00 
00 00 00 00 00 00 28 84 61 50 00 88 ff ff  ........(.aP....
Jul  8 17:49:04 yerbouti kernel: [22028.152655] format 00000050: 00 00 
00 00 00 00 00 00                          ........
Jul  8 17:49:04 yerbouti kernel: [22028.154451] rates 00000000: 44 ac 00 
00 80 bb 00 00 88 58 01 00 00 77 01 00  D........X...w..
Jul  8 17:49:04 yerbouti kernel: [22028.154455] format 00000000: 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.154459] format 00000010: 00 00 
00 00 01 00 00 00 08 00 00 00 01 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.154462] format 00000020: 00 00 
00 00 02 00 00 00 02 02 01 81 05 00 00 00  ................
Jul  8 17:49:04 yerbouti kernel: [22028.154465] format 00000030: 38 01 
00 00 c0 06 00 00 44 ac 00 00 00 77 01 00  8.......D....w..
Jul  8 17:49:04 yerbouti kernel: [22028.154468] format 00000040: 04 00 
00 00 00 00 00 00 28 8d 61 50 00 88 ff ff  ........(.aP....
Jul  8 17:49:04 yerbouti kernel: [22028.154472] format 00000050: 00 00 
00 00 00 00 00 00                          ........
Jul  8 17:49:04 yerbouti kernel: [22028.155656] ALSA clock.c:236: 
current rate 48000 is different from the runtime rate 96000
Jul  8 17:49:04 yerbouti kernel: [22028.157664] usbcore: registered new 
interface driver snd-usb-audio


Am 08.07.2010 17:19, schrieb Clemens Ladisch:
> Felix Homann wrote:
>    
>> I guess  there's still something wrong with your debug patch (or me
>> applying it...). Doesn't look like any valuable information in syslog
>> this time (no fixed_endpoint quirk):
>
