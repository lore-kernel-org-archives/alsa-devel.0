From: auspicious@inventati.org
Subject: ASUS STRIX sound card quiet microphone (like,
	really quiet ...)
Date: Sun, 03 Jul 2016 04:30:00 +0000
Message-ID: <f538e10ebefb9bcf292087e30a46d563@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from contumacia.investici.org (contumacia.investici.org
 [178.255.144.35])
 by alsa0.perex.cz (Postfix) with ESMTP id D6EAE26061B
 for <alsa-devel@alsa-project.org>; Sun,  3 Jul 2016 06:30:01 +0200 (CEST)
Received: from opposizione.investici.org (opposizione-vpn.investici.org
 [172.16.1.6])
 by contumacia.investici.org (Postfix) with ESMTP id 9046D2010C6
 for <alsa-devel@alsa-project.org>; Sun,  3 Jul 2016 04:30:00 +0000 (UTC)
Received: from [46.4.106.116] (opposizione [46.4.106.116]) (Authenticated
 sender: auspicious@inventati.org) by localhost (Postfix) with ESMTPA id
 4E54A2205D7
 for <alsa-devel@alsa-project.org>; Sun,  3 Jul 2016 04:30:00 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear mailing list individuals,

I currently am using an ASUS STRIX RAID DLX sound card. It contains the 
following processor:
C-Media USB2.0 6632AX High-Definition Sound Processor (Max. 384KHz / 
24bit)

More information:
https://www.asus.com/Sound-Cards/STRIX-RAID-DLX/specifications

It gets detected as so on Debian testing with Linux kernel 4.6:
card 1: DLX [STRIX RAID DLX], device 0: USB Audio [USB Audio]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: DLX [STRIX RAID DLX], device 1: USB Audio [USB Audio #1]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: DLX [STRIX RAID DLX], device 2: USB Audio [USB Audio #2]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

The output of the card has been wonderfully fine ever since I have had 
it, but the microphone bit has always been troublesome. On Linux Mint 
17.3 it would not work (kernel 4.1 I believe).

On Linux Mint 18 (kernel 4.4) it started working but it is incredibly 
quiet. On the loudest setting, I have to put the microphone against my 
mouth for anyone to hear.

On the same system using on-board Intel audio, this issue does not 
occur. I am using Debian testing to have more recent software, but 
nothing made a difference.

What can I do about this? I do not really know whether I need to contact 
the Linux kernel guys or ALSA. I am rather inexperienced with Linux 
driver things.

Sincerely yours,
Desperate Individual
