From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: unresolved symbols, cvs, hammerfall
Date: Tue, 14 May 2002 18:18:19 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205150118.SAA20099@cmn29.stanford.edu>
References: <200205150001.g4F012T12698@post2.fast.net>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205150001.g4F012T12698@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: nando@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Just downloaded from cvs, I'm getting this unresolved symbols:

# depmod -a -e
depmod: *** Unresolved symbols in  
/lib/modules/2.4.18-2.ll/kernel/drivers/sound/pci/rme9652/snd-hammerfall-mem.o
depmod: 	pci_free_consistent
depmod: 	pci_alloc_consistent
depmod: 	pci_devices
depmod: 	mem_map
depmod: 	printk
depmod: *** Unresolved symbols in  
/lib/modules/2.4.18-2.ll/kernel/drivers/sound/pci/rme9652/snd-rme9652.o
depmod: 	snd_hammerfall_get_buffer_R511cb671
depmod: 	snd_hammerfall_free_buffer_R4a11134f

Maybe something's missing in the recent Hammerfall updates?
This is being compiled under 2.4.18 + 19-pre7 + low latency,
full sources for the kernel are properly installed.

-- Fernando

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
