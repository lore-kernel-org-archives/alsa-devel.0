From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: USX2Y 2.6.20-rt2 Oops on disconnect
Date: Mon, 5 Feb 2007 23:27:06 +0100
Message-ID: <200702052327.06365.annabellesgarden@yahoo.de>
References: <20070205065636.GA1652@elte.hu>
	<200702051525.49465.fzu@wemgehoertderstaat.de>
	<49143.192.168.1.8.1170712006.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_686xF3XkbSAql1o"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <49143.192.168.1.8.1170712006.squirrel@www.rncbc.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_686xF3XkbSAql1o
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Montag, 5. Februar 2007 22:46 schrieb Rui Nuno Capela:
> Hi Karsten,
> 
> I'm having this kernel oops right on disconnecting my US-224. Probably it
> has been creeping around before, but only now I had the opportunity to
> report.
> 
> ...
> ALSA sound/usb/usx2y/usx2yhwdeppcm.c:76: activ frame status -62. Most
> propably some hardware problem.
> usb 2-1: USB disconnect, address 5
> BUG: unable to handle kernel paging request at virtual address 00070033
>  printing eip:
> e06ccc6f
> *pde = 00000000
> stopped custom tracer.
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: snd_rtctimer snd_seq_midi snd_seq_midi_event
> snd_seq_dummy snd_pcm_oss snd_mixer_oss snd_seq snd_usb_usx2y snd_usb_lib
> snd_rawmidi snd_seq_device snd_hwdep snd_ali5451 snd_ac97_codec snd_pcm
> snd_timer snd appletalk ax25 ipx p8023 arc4 ecb blkcipher
> ieee80211_crypt_wep af_packet ipv6 button battery ac loop dm_mod hostap_cs
> hostap ieee80211_crypt pcmcia firmware_class i2c_ali1535 ohci1394 ieee1394
> ohci_hcd parport_pc ide_cd cdrom parport usbcore i2c_ali15x3 shpchp
> yenta_socket ati_agp i2c_core agpgart rsrc_nonstatic pci_hotplug
> pcmcia_core ac97_bus natsemi soundcore snd_page_alloc ext3 mbcache jbd edd
> fan alim15x3 thermal processor ide_disk ide_core
> CPU:    0
> EIP:    0060:[<e06ccc6f>]    Not tainted VLI
> EFLAGS: 00210202   (2.6.20-rt2.0 #1)
> EIP is at snd_info_free_entry+0xa/0x47 [snd]
> eax: 00070007   ebx: 00070007   ecx: c040be90   edx: c4d44d30
> esi: dc63dc00   edi: dc63ddac   ebp: d4399e78   esp: d4399e74
> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> Process jackd (pid: 5167, ti=d4399000 task=c4d44d30 task.ti=d4399000)
> Stack: dc63dc00 d4399e90 e06cb6f9 00000000 c4ded3e0 dc63dc00 c4ded3e0
> d4399eb8
>        e06cb7cf 00000000 d4399eb8 c0116dcf 00000001 d3eec480 d31b4f18
> d31b4e00
>        d5d29c00 d4399ee4 e06f8f89 00000000 df7659c0 d321e8bc d4399ee0
> d3eec480
> Call Trace:
>  [<e06cb6f9>] snd_card_do_free+0xb4/0xea [snd]
>  [<e06cb7cf>] snd_card_file_remove+0xa0/0x10f [snd]
>  [<e06f8f89>] snd_pcm_release+0xbb/0xc5 [snd_pcm]
>  [<e06cbd6e>] snd_disconnect_release+0x70/0x78 [snd]
>  [<c01617f0>] __fput+0xa4/0x163
>  [<c01618c5>] fput+0x16/0x18
>  [<c015f025>] filp_close+0x54/0x5c
>  [<c011b00b>] put_files_struct+0x66/0xa8
>  [<c011c0c4>] do_exit+0x20e/0x75a
>  [<c011c6a0>] complete_and_exit+0x0/0x16
>  [<c0103e04>] syscall_call+0x7/0xb
>  [<b7f39199>] 0xb7f39199
>  =======================
> Code: 85 28 00 00 e8 04 89 a3 df eb 0f 8b 53 2c e8 65 ff ff ff c7 43 2c 00
> 00 00 00 83 c4 10 5b 5e 5d c3 55 85 c0 89 e5 53 89 c3 74 3a <83> 78 2c 00
> 74 1b b8 40 89 6d e0 e8 18 bb bd df 89 d8 e8 4b ff
> EIP: [<e06ccc6f>] snd_info_free_entry+0xa/0x47 [snd] SS:ESP 0068:d4399e74
>  <1>Fixing recursive fault but reboot is needed!
> Bad page state in process 'beagled-helper'
> page:c123fe40 flags:0x40000000 mapping:00000000 mapcount:0 count:-1
> Trying to fix it up, but a reboot is needed
> Backtrace:
>  [<c0104d68>] dump_trace+0x63/0x1e5
>  [<c0104f04>] show_trace_log_lvl+0x1a/0x2f
>  [<c01054d4>] show_trace+0x12/0x14
>  [<c0105567>] dump_stack+0x16/0x18
>  [<c0149262>] bad_page+0x61/0x8e
>  [<c0149ab0>] get_page_from_freelist+0x1d6/0x2a7
>  [<c0149bce>] __alloc_pages+0x4d/0x274
>  [<c0146e18>] generic_file_buffered_write+0x154/0x520
>  [<c014764f>] __generic_file_aio_write_nolock+0x46b/0x4d8
>  [<c0147712>] generic_file_aio_write+0x56/0xb4
>  [<e085e157>] ext3_file_write+0x27/0x96 [ext3]
>  [<c016046e>] do_sync_write+0xc2/0xff
>  [<c0160cad>] vfs_write+0xaf/0x163
>  [<c016122d>] sys_write+0x3d/0x61
>  [<c0103d90>] sysenter_past_esp+0x5d/0x81
>  [<ffffe410>] _einittext+0x3fc3c386/0xffee9993
>  =======================

hm, just pulled the usb-cable off my us428 twice with nothing in dmesg.
Under jackd working.
Which is the way to reproduce this?
As a shot in the dark, please try the attached patch.
Should be correct anyhow ;-)

      Cheers, Karsten

--Boundary-00=_686xF3XkbSAql1o
Content-Type: text/x-diff; charset="iso-8859-15";
	name="snd_hwdep_release-racefix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd_hwdep_release-racefix.diff"

Hi Takashi,

had some oopses here running -rt kernels,
which vanished after applying this.

      Karsten
------------------------------------------------------------------- 
snd_hwdep_release() racefix


snd_card_file_remove() can free the snd_card.
Touch hw->* only before calling snd_card_file_remove().

Unrelated: Allow hwdep devices not to have own ops.release();


Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


--- /alsa-kernel/core/hwdep.c_	2007-01-30 20:32:01.000000000 +0100
+++ /alsa-kernel/core/hwdep.c	2007-01-30 20:32:01.000000000 +0100
@@ -156,15 +156,16 @@
 	int err = -ENXIO;
 	struct snd_hwdep *hw = file->private_data;
 	struct module *mod = hw->card->module;
+
 	mutex_lock(&hw->open_mutex);
-	if (hw->ops.release) {
+	if (hw->ops.release)
 		err = hw->ops.release(hw, file);
-		wake_up(&hw->open_wait);
-	}
 	if (hw->used > 0)
 		hw->used--;
-	snd_card_file_remove(hw->card, file);
 	mutex_unlock(&hw->open_mutex);
+	wake_up(&hw->open_wait);
+
+	snd_card_file_remove(hw->card, file);
 	module_put(mod);
 	return err;
 }

--Boundary-00=_686xF3XkbSAql1o
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Boundary-00=_686xF3XkbSAql1o
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_686xF3XkbSAql1o--
