From: "Vladimir Chernyshov" <greengrass@writeme.com> (by way of Gustavo Guillermo Perez <gustavo@compunauta.com>)
Subject: [2.6.8 bugreport] using mmap with via82cxxx_audio causes GPF
Date: Sat, 6 Nov 2004 06:14:52 +0600
Message-ID: <200411060614.52265.greengrass@writeme.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Setting up mmap before setting up speed/format/channels causes shortly
 afterwards a general protection fault in via82cxxx_audio:

===========================================================================
CPU 0
Modules linked in: snd_via82xx snd_ac97_codec snd_pcm snd_timer
 snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd
 ehci_hcd uhci_hcd eth1394 via82cxxx_audio uart401 sound soundcore ac97_codec
 via82cxxx ide_core r8169 crc32 ohci1394 nls_iso8859_1 nls_cp437 capability
 commoncap sr_mod cdrom sbp2 ieee1394 rtc vfat fat ext2 ext3 jbd mbcache
 sd_mod sata_via libata scsi_mod unix font vesafb cfbcopyarea cfbimgblt
 cfbfill rect
Pid: 2023, comm: quake-x11 Not tainted 2.6.8-9-amd64-k8
RIP: 0010:[<ffffffffa019666e>]
 <ffffffffa019666e>{:via82cxxx_audio:via_mm_nopage+350} RSP:
 0000:000001001e987d78  EFLAGS: 00010206
RAX: 038000fc81000000 RBX: 000001001e873858 RCX: 0000000000000020
RDX: 006fffff90000000 RSI: 0000000055fbd000 RDI: 000001001e72a290
RBP: 000001001e873800 R08: 000001001f528de8 R09: 000001001e98f578
R10: 0000000000000000 R11: 0000000000000000 R12: 000001001e873858
R13: 0000000000000000 R14: 000001001e987dcc R15: 000001001e4fb480
FS:  0000000000000000(0000) GS:ffffffff80387980(005b) knlGS:00000000557aa080
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000055fbd000 CR3: 0000000000101000 CR4: 00000000000006e0
Process quake-x11 (pid: 2023, threadinfo 000001001e986000, task
 000001001ec1d350) Stack: 0000000000000000 0000000000000001 0000010012e41240
 000001001e72a290 0000000055fbd000 ffffffff80159508 0000000000000246
 ffffffff80158eb9 0000000000000000 000001001e98f578
Call Trace:<ffffffff80159508>{-2146069240} <ffffffff80158eb9>{-2146070855}
       <ffffffff801598e0>{-2146068256} <ffffffff8011f79a>{-2146306150}
       <ffffffffa0198004>{:via82cxxx_audio:via_dsp_ioctl+2340}
       <ffffffff80166dad>{-2146013779} <ffffffff80110a61>{-2146366879}


Code: ff 40 04 4d 85 f6 74 07 41 c7 06 01 00 00 00 48 8b 1c 24 48
============================================================================

Changing the order of setup to opposite fixes the problem.

Tested with 2.6.7 (compiled for K7) and 2.6.8 (compiled for AMD-64). Testing
 tool - QuakeForge.

regards,
Vladimir

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
