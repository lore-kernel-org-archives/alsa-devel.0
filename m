From: Matteo Sasso <matteo.sasso@gmail.com>
Subject: Problem with intel-hda integrated audio
Date: Thu, 22 May 2008 21:38:35 +0200
Message-ID: <200805222138.35409.matteo.sasso@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 3536D1037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 21:38:42 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so223019fka.0
	for <alsa-devel@alsa-project.org>; Thu, 22 May 2008 12:38:41 -0700 (PDT)
Content-Disposition: inline
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

Hello, I'm having a problem with a soundcard under ubuntu. I tried nearly 
every workaround I could find on the Internet but I have not been successful 
so far.

The computer in question is a Toshiba Satellite Pro U200 series. The soundcard 
seems to be correctly identified by ALSA but it seems muted, nothing I tried 
seems to work. I followed the instructions given at
http://www.mjmwired.net/kernel/Documentation/sound/alsa/ALSA-Configuration.txt
I determined that my card uses a AD1981 codec, so I added the following 
to /etc/modprobe.d/alsa-base:

options snd-hda-intel model=toshiba

I tried many other combinations (3stack, basic, laptop), with and 
without "position_fix=1". I also tried using underscores instead of hypens 
("snd_hda_intel"). I run update-initramfs -u after every try.

lspci -vn has to say the following:
00:1b.0 0403: 8086:27d8 (rev 02)
        Sybsystem: 1179:0001
        Flags: bus master, fast devsel, latency 0, IRQ 23
        Memory at 50080000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

I'll keep tabs on this mailing list, so feel free to ask for more info.
Any help is appreciated.
Thanks.
