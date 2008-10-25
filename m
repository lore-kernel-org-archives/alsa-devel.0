From: Thomas Scheunemann <thomas.scheunemann@uni-duisburg-essen.de>
Subject: Re: Backported sbxfi driver, possible fix
Date: Sat, 25 Oct 2008 15:06:52 +0200
Message-ID: <20081025130652.GA27621@rzle423.uni-duisburg.de>
References: <s5hod1b436i.wl%tiwai@suse.de> <s5hljwf42x4.wl%tiwai@suse.de>
	<4900A4FA.7020300@jasonline.co.uk> <s5h63njw2c0.wl%tiwai@suse.de>
	<4900B523.3020801@jasonline.co.uk> <s5h8wsf3spl.wl%tiwai@suse.de>
	<4900DBBD.2020806@jasonline.co.uk> <s5hljwee68t.wl%tiwai@suse.de>
	<49017FBF.4030005@jasonline.co.uk> <s5hfxmm47kb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rzle423.uni-duisburg.de (rzle423.uni-duisburg.de [134.91.2.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EF942433A
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 15:07:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfxmm47kb.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

I think I found a bug in the driver, which at least for me was
responsible for the crashes with pulseaudio.

A little backstory:

I have a Fedora 8 System with an SB X-Fi installed and of course
no sound. I didn't want to replace the entire ALSA driver, so I
just took the files sbxfi.c and emu20k1-regs.h from the unstable
sources, wrote a small spec-file and am now at a point where I
can just "rpm -i" the driver as a dkms package and just modprobe
the driver.

After that "speaker-test -D hw -c 2 -r 96000 -t sine" works just
fine, but as soon as pulseaudio is started my System froze.

The bug I think I found is in the get_xfi_order function. As long
as pages actually is a power of two it works correctly. But if
pages isn't a power of two it should round up, but it rounds down.
As a result I believe this screws up sbxfi_alloc_tlb_pages.

After a small modification to get_xfi_order:

--- /tmp/sbxfi.c	2008-10-25 14:51:55.000000000 +0200
+++ sbxfi.c	2008-10-25 14:03:48.000000000 +0200
@@ -851,11 +851,12 @@
 /* get the order of pages (power-of-two) */
 static int get_xfi_order(unsigned int pages)
 {
-	int order = -1;
-	do {
+	int order = 0;
+	pages--;
+	while(pages){
 		pages >>= 1;
 		order++;
-	} while (pages);
+	}
 	return order;
 }
 
the driver started working with pulseaudio, it doesn't crash, and I
even get sound though it still is a bit distorted.
