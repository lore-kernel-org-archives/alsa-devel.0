From: Lee Revell <rlrevell@joe-job.com>
Subject: Mozilla Bug #252851 - Mozilla should use ALSA for sound rather
 than OSS
Date: Sat, 24 Jul 2004 00:33:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090643583.956.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Just FYI, I filed the following bug today after noticing that Mozilla
was opening the sound device in OSS emulation mode, rather than using
ALSA native funcitons:

http://bugzilla.mozilla.org/show_bug.cgi?id=252851

This causes the following XRUN on my system:

Jul 24 00:21:41 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 24 00:21:41 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 24 00:21:41 mindpipe kernel:  [__crc_open_exec+6091194/6092646] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+61783/3197748] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 24 00:21:41 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 24 00:21:41 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 24 00:21:41 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+908343/3197748] snd_pcm_oss_change_params+0x5a1/0x850 [snd_pcm_oss]
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+909148/3197748] snd_pcm_oss_get_active_substream+0x76/0x90 [snd_pcm_oss]
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+912967/3197748] snd_pcm_oss_get_channels+0x11/0x30 [snd_pcm_oss]
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+919229/3197748] snd_pcm_oss_ioctl+0x447/0x740 [snd_pcm_oss]
Jul 24 00:21:41 mindpipe kernel:  [sys_ioctl+256/608] sys_ioctl+0x100/0x260
Jul 24 00:21:41 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 24 00:21:41 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 24 00:21:41 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 24 00:21:41 mindpipe kernel:  [__crc_open_exec+6091194/6092646] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+61783/3197748] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 24 00:21:41 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 24 00:21:41 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 24 00:21:41 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+908343/3197748] snd_pcm_oss_change_params+0x5a1/0x850 [snd_pcm_oss]
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+909148/3197748] snd_pcm_oss_get_active_substream+0x76/0x90 [snd_pcm_oss]
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+912823/3197748] snd_pcm_oss_get_rate+0x11/0x30 [snd_pcm_oss]
Jul 24 00:21:41 mindpipe kernel:  [__crc_totalram_pages+919694/3197748] snd_pcm_oss_ioctl+0x618/0x740 [snd_pcm_oss]
Jul 24 00:21:41 mindpipe kernel:  [sys_ioctl+256/608] sys_ioctl+0x100/0x260

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
