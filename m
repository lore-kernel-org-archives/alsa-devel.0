From: holborn <holborn@telefonica.net>
Subject: sfxload / asfxload page allocation failure
Date: Tue, 13 Apr 2004 12:37:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404131237.11198.holborn@telefonica.net>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


Hi!

I have problems when i try to load "big" soundfonts, in older versions i was 
load this soundfonts without probems.

when i run sfxload or asfxload with PC51f.sf2 (for example ... ) asfxload or 
sfxload try to load but no returnd to command line. No way to kill the 
process, no way to load other soundfonts and when i reboot i have this 
message:

(Is hand copied ... maybe they are some typo errors)

sfxload: page allocation failure. order:0, mode:0xd1

Call Trace:
[<c013377a>] __alloc_pages+0x2e0/0x325
[<c01337de>] __get_free_pages+0x1f/0x41
[<c010d74f>] dma_alloc_coherent+0x47/0x7a
[<e09681b6>] snd_dma_hack_alloc_coherent+0x13e/0x14e [snd_page_alloc]
[<e096837c>] snd_malloc_dev_pages+0x4f/0x69 [snd_page_alloc]
[<e096853f>] snd_dma_alloc_pages+0xc2/0xc4 [snd_page_alloc]
[<e0a4e0d0>] synth_alloc_pages+0x5b/0x103 [snd_emu10k1]
[<e0a4df3d>] snd_emu10k1_synth_alloc+0x4a/0x96 [snd_emu10k1]
[<e0a10e8c>] snd_emu10k1_sample_new+0x84/0x1cd [snd_emu10k1_synth]
[<e0a44b40>] load_data+0x167/0x1b7 [snd_emux_synth]
[<e0a43f03>] snd_soundfont_load+0x12e/0x275 [snd_emux_synth]
[<e0a45de5<] snd_emux_load_patch_seq_oss+0xde/0x116 [snd_emux_synth]
[<e09ce49e>] snd_seq_oss_synth_load_patch+0x99/0x9b [snd_seq_oss]
[<e09cd9ce>] snd_seq_oss_write+0x16c/0x17e [snd_seq_oss]
[<e09cb0ba>] odev_write+0x0/0x14 [snd_seq_oss]
[<c0149cec>] vfs_write+0xb0/0x119
[<c0149dfa>] sys_write+0x42/0x63
[<c0106d33>] syscall_cal+0x7/0xb

I have the same error in a gentoo 
Driver version 1.0.4rc2  in kernel 2.6.5
and also in debian same kernel same alsa version of course .. :)

Small soundfonts (8MB) loads perfect ...

Thanks

Josep





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
