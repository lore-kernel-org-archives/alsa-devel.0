From: "u2@whoplays.asia" <u2@whoplays.asia>
Subject: [snd-hdsp] module mapping missing
Date: Tue, 30 Jun 2009 05:21:41 +0900
Message-ID: <4A492255.5050201@whoplays.asia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by alsa0.perex.cz (Postfix) with ESMTP id A7A0C103814
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 22:24:55 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so930623wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2009 13:24:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Module-hdsp maintainers

Hi,

Thanks for your great sound system, but I found a missing or
invalid map of the soundcard and module for "RME HDSPe AIO".

  [RME HDSPe AIO]
   http://www.rme-audio.de/en_products_hdspe_aio.php


However the soundcard shoud be recognized as the product
"HDSPe ExpressCard" as in soundcard matrix I think,
but was recognized as the product "Hammerfall DSP Madi".

  [Matrix:Vendor-RME]
   http://www.alsa-project.org/main/index.php/Matrix:Vendor-RME

  [RME HDSP MADI]
   http://www.rme-audio.de/en_products_hdsp_madi.php


Because product-id looks categorized as "HDSP MADI", the module
snd-hdspm for "HDSP MADI" was installed for "HDSPe AIO".

$ uname -srvmo
Linux 2.6.26-2-amd64 #1 SMP Sun Jun 21 04:47:08 UTC 2009 x86_64 GNU/Linux

$ lspci -nn | grep RME
02:00.0 Multimedia audio controller [0401]: Xilinx Corporation RME 
Hammerfall DSP MADI [10ee:3fc6] (rev d4)

$ cat /proc/asound/modules
0 snd_hdspm

$ pcimodules | grep hdsp
snd-hdspm

$ cat /lib/modules/2.6.26-2-amd64/modules.pcimap | grep hdsp
snd-hdsp 0x000010ee 0x00003fc5 0xffffffff 0xffffffff 0x00000000 
0x00000000 0x0
snd-hdspm 0x000010ee 0x00003fc6 0xffffffff 0xffffffff 0x00000000 
0x00000000 0x0

$ setpci -d 10ee:3fc6 vendor_id device_id subsystem_vendor_id subsystem_id
10ee
3fc6
00000000
0000


How can I help for it ?

----
Toshiya Miyagi
