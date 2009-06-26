From: Ludwig Maes <ludwig.maes@gmail.com>
Subject: Laptop speakers nonfunctional, jacks functional
Date: Fri, 26 Jun 2009 23:34:27 +0200
Message-ID: <10c3cb270906261434l65c0bf8dp3aa44ba5f2c2201d@mail.gmail.com>
References: <10c3cb270906261405n3987a549x67cdf298176f6db7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id BF82F244A2
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 23:34:28 +0200 (CEST)
Received: by fxm26 with SMTP id 26so2684319fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2009 14:34:27 -0700 (PDT)
In-Reply-To: <10c3cb270906261405n3987a549x67cdf298176f6db7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-audio-user@lists.linuxaudio.org
List-Id: alsa-devel@alsa-project.org

---------- Forwarded message ----------
From: Ludwig Maes <ludwig.maes@gmail.com>
Date: 2009/6/26
Subject: Laptop speakers nonfunctional, jacks functional
To: alsa-user@lists.sourceforge.net


Realtek ALC888S (according to preinstalled Realtek HD audio manager on
windows) visible jacks working, builtin laptop speakers and subwoofer
silent.
Running Ubuntu 9.04 compiled and installed alsa 1.0.20.

http://www.alsa-project.org/db/?f=fb64ba9a8ab28d8c16532ece21e3adba7219e4b9

Notice it thinks it is ALC1200. I searched this and found it in
patch_realtek.c, I changed the equality test so we would end up in ALC888
section... result was I got an extra volume control on mixer for BEEP.
previously did not hear beeps when hitting down in terminal. BEEP is in
headphones or line out. still not on speakers. aplay -l listed ALC888 too
but codec#0 still showed ALC1200... I dont know the flow of information
changes in ALSA to change this codec... I undid the equality test change and
now its back to original realtek patch, recompiled reinstalled...

added model=generic, to asound.state, this gave me more controls IIRC..

downloaded codecgraph utility, result:
http://img20.imageshack.us/img20/8692/codec0.png
I dont know how these codecgraphs work, but 4 jacks are right! the internal
speakers appear twice?? how can one rewire these, or enable assuming dotted
is disabled, does every amplifier triangle correspond to a volume control?
is there a direct way to make changes?

dmesg |grep hda:
[   16.172695] hda_codec: Unknown model for ALC883, trying auto-probe from
BIOS...
[   18.037866] ALSA
/usr/src/alsa/alsa-driver-1.0.20/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:636:
hda_intel: azx_get_response timeout, switching to polling mode: last
cmd=0x00bb0000


Realtek datasheet for ALC888S, reference design, if helpful:
http://www.realtek.com.tw/products/productsView.aspx?Langid=1&PFid=28&Level=5&Conn=4&ProdID=141

I am very willing to test proposals...

friendly greetings,
Ludwig
