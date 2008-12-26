From: Thomas Schneider <nailstudio@gmx.net>
Subject: Re: S/PDIF-Out on Asus M3A-H/HDMI with ALC1200]
Date: Fri, 26 Dec 2008 13:29:30 +0100
Message-ID: <4954CE2A.2040309@gmx.net>
References: <49538A00.3070009@gmx.net> <20081226024838.GA13302@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 362461037F3
	for <alsa-devel@alsa-project.org>; Fri, 26 Dec 2008 13:29:39 +0100 (CET)
In-Reply-To: <20081226024838.GA13302@localhost>
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

Hi,

sorry, i get a kernel oops with this changes when i activate iec958 in 
the mixer !


[ 1435.041914] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000006
[ 1435.041914] IP: [<ffffffff880d0223>] :snd_hda_codec:set_dig_out+0x47/0x57
[ 1435.041914] PGD 6b5c3067 PUD 781ba067 PMD 0
[ 1435.041914] Oops: 0000 [1] SMP
[ 1435.041914] CPU 1
[ 1435.041914] Modules linked in: snd_pcm_oss snd_mixer_oss 
snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm 
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_timer 
snd_seq_device snd soundcore snd_page_alloc lirc_serial lirc_dev mantis 
mb86a16 stb6100 stb0899 b2c2_flexcop_pci b2c2_flexcop s5h1420 mt352 
itd1000 bcm3510 dvb_pll nxt200x isl6421 tuner_simple tuner_types cx24123 
lgdt330x mt312 v4l2_common dvb_ttpci lnbp21 l64781 saa7146_vv saa7146 
videobuf_dma_sg videobuf_core ves1820 tda8083 sp8870 firmware_class 
stv0297 ves1x93 ttpci_eeprom stv0299 dvb_core videodev v4l1_compat 
nvidia(P) battery ppdev parport_pc lp parport ipv6 cpufreq_ondemand 
cpufreq_conservative cpufreq_userspace nls_iso8859_1 nls_cp437 joydev 
usb_storage usbhid hid serio_raw pcspkr psmouse evdev i2c_piix4 k8temp 
atl1 i2c_core mii ehci_hcd ohci_hcd wmi button [last unloaded: soundcore]
[ 1435.041914] Pid: 17229, comm: alsamixer Tainted: P         2.6.25.16 #5
[ 1435.041914] RIP: 0010:[<ffffffff880d0223>]  [<ffffffff880d0223>] 
:snd_hda_codec:set_dig_out+0x47/0x57
[ 1435.041914] RSP: 0018:ffff81006f86fcb8  EFLAGS: 00010206
[ 1435.041914] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 
0000000000000010
[ 1435.041914] RDX: 0000000000000001 RSI: ffff81007cd1f1f0 RDI: 
ffff81007dc05828
[ 1435.041914] RBP: ffff81007dc05828 R08: 0000000000000001 R09: 
0000000000200200
[ 1435.041914] R10: ffff81007cd1f208 R11: ffffffff880d08ae R12: 
0000000000000001
[ 1435.041914] R13: 000000000000070d R14: 0000000000000001 R15: 
ffff81007dc05a30
[ 1435.041914] FS:  00007faf065546e0(0000) GS:ffff81007fb7fbc0(0000) 
knlGS:0000000000000000
[ 1435.041914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1435.041914] CR2: 0000000000000006 CR3: 000000006f849000 CR4: 
00000000000006e0
[ 1435.041914] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 1435.041914] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[ 1435.041914] Process alsamixer (pid: 17229, threadinfo 
ffff81006f86e000, task ffff81007e7395c0)
[ 1435.041914] Stack:  ffff81006f86fcd8 0000000000000010 
ffff81007dc05828 0000000000000010
[ 1435.041914]  0000000000000001 ffffffff880d0926 ffff81007ccd2028 
ffff81007c89e2e8
[ 1435.041914]  ffff81007ccd2028 ffff81007dc049c0 ffff81007dc04828 
ffff81007c89e2e8
[ 1435.041914] Call Trace:
[ 1435.041914]  [<ffffffff880d0926>] ? 
:snd_hda_codec:snd_hda_spdif_out_switch_put+0x78/0xe4
[ 1435.041914]  [<ffffffff8806f184>] ? :snd:snd_ctl_elem_write+0x9c/0xdb
[ 1435.041914]  [<ffffffff8806fc16>] ? :snd:snd_ctl_ioctl+0x2d3/0x770
[ 1435.041914]  [<ffffffff8024be32>] ? hrtimer_start+0x115/0x137
[ 1435.041914]  [<ffffffff8020bef9>] ? sysret_signal+0x2b/0x45
[ 1435.041914]  [<ffffffff802341e5>] ? hrtick_set+0xa1/0x10a
[ 1435.041914]  [<ffffffff8020b95a>] ? do_notify_resume+0x850/0x871
[ 1435.041914]  [<ffffffff8022f636>] ? __wake_up+0x38/0x4f
[ 1435.041914]  [<ffffffff8023b7d6>] ? current_fs_time+0x1e/0x24
[ 1435.041914]  [<ffffffff802ab23d>] ? vfs_ioctl+0x21/0x6c
[ 1435.041914]  [<ffffffff802ab4c1>] ? do_vfs_ioctl+0x239/0x24f
[ 1435.041914]  [<ffffffff802a061f>] ? vfs_read+0x11e/0x152
[ 1435.041914]  [<ffffffff802ab528>] ? sys_ioctl+0x51/0x71
[ 1435.041914]  [<ffffffff8020bef9>] ? sysret_signal+0x2b/0x45
[ 1435.041914]  [<ffffffff8020be4a>] ? system_call_after_swapgs+0x8a/0x8f
[ 1435.041914]
[ 1435.041914]
[ 1435.041914] Code: 08 e8 36 ff ff ff 48 8b 9d 30 02 00 00 48 85 db 75 
19 eb 1f 0f b7 f0 45 89 e0 44 89 e9 31 d2 48 89 ef 48 83 c3 02 e8 11 ff 
ff ff <66> 8b 03 66 85 c0 75 e1 5b 5b 5d 41 5c 41 5d c3 41 57 41 56 41
[ 1435.041914] RIP  [<ffffffff880d0223>] 
:snd_hda_codec:set_dig_out+0x47/0x57
[ 1435.041914]  RSP <ffff81006f86fcb8>
[ 1435.041914] CR2: 0000000000000006
[ 1435.041930] ---[ end trace 9b9cd1aadfad1315 ]---


Thomas


Am 26.12.2008 03:48, schrieb Wu Fengguang:
> Hi Thomas,
>
> This patch adds the SPDIF pin as slave digital out which I hope to
> create concurrent HDMI/SPDIF outputs for you.
>
> It's against today's sound-2.6 git tree.
>
> Thanks,
> Fengguang
> ---
> diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
> index 6f2fe0f..c9262f0 100644
> --- a/sound/pci/hda/hda_local.h
> +++ b/sound/pci/hda/hda_local.h
> @@ -227,6 +227,7 @@ struct hda_multi_out {
>   	hda_nid_t hp_nid;	/* optional DAC for HP, 0 when not exists */
>   	hda_nid_t extra_out_nid[3];	/* optional DACs, 0 when not exists */
>   	hda_nid_t dig_out_nid;	/* digital out audio widget */
> +	hda_nid_t *slave_dig_outs;
>   	int max_channels;	/* currently supported analog channels */
>   	int dig_out_used;	/* current usage of digital out (HDA_DIG_XXX) */
>   	int no_share_stream;	/* don't share a stream with multiple pins */
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 0bd4e6b..08bedee 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -336,6 +336,7 @@ struct alc_config_preset {
>   	hda_nid_t *dac_nids;
>   	hda_nid_t dig_out_nid;		/* optional */
>   	hda_nid_t hp_nid;		/* optional */
> +	hda_nid_t *slave_dig_outs;
>   	unsigned int num_adc_nids;
>   	hda_nid_t *adc_nids;
>   	hda_nid_t *capsrc_nids;
> @@ -810,6 +811,7 @@ static void setup_preset(struct alc_spec *spec,
>   	spec->multiout.num_dacs = preset->num_dacs;
>   	spec->multiout.dac_nids = preset->dac_nids;
>   	spec->multiout.dig_out_nid = preset->dig_out_nid;
> +	spec->multiout.slave_dig_outs = preset->slave_dig_outs;
>   	spec->multiout.hp_nid = preset->hp_nid;
>
>   	spec->num_mux_defs = preset->num_mux_defs;
> @@ -3085,6 +3087,7 @@ static int alc_build_pcms(struct hda_codec *codec)
>   	/* SPDIF for stream index #1 */
>   	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
>   		codec->num_pcms = 2;
> +	        codec->slave_dig_outs = spec->multiout.slave_dig_outs;
>   		info = spec->pcm_rec + 1;
>   		info->name = spec->stream_name_digital;
>   		info->pcm_type = HDA_PCM_TYPE_SPDIF;
> @@ -8865,6 +8868,7 @@ static struct alc_config_preset alc883_presets[] = {
>   		.dac_nids = alc883_dac_nids,
>   		.dig_out_nid = ALC1200_DIGOUT_NID,
>   		.dig_in_nid = ALC883_DIGIN_NID,
> +		.slave_dig_outs = { ALC883_DIGOUT_NID, 0 },
>   		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
>   		.channel_mode = alc883_sixstack_modes,
>   		.input_mux =&alc883_capture_source,
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>    
