From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH 2/2] snd-usb-audio: Add duplex mode for
 Digidesign Mbox 1 and enable mixer
Date: Mon, 10 Nov 2014 10:45:19 +1100
Message-ID: <545FFC8F.9040001@gmail.com>
References: <1415059597-18344-1-git-send-email-damien@zamaudio.com>
 <1415059597-18344-3-git-send-email-damien@zamaudio.com>
 <s5ha9442z6d.wl-tiwai@suse.de> <545E1C21.3090803@gmail.com>
 <s5hk3343f6y.wl-tiwai@suse.de> <545F747A.7090002@ladisch.de>
 <s5hfvds2sjo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C324260592
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 00:45:25 +0100 (CET)
Received: by mail-pd0-f181.google.com with SMTP id y10so6645380pdj.40
 for <alsa-devel@alsa-project.org>; Sun, 09 Nov 2014 15:45:24 -0800 (PST)
In-Reply-To: <s5hfvds2sjo.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 10/11/14 04:27, Takashi Iwai wrote:
> At Sun, 09 Nov 2014 15:04:42 +0100,
> Clemens Ladisch wrote:
>>
>> Takashi Iwai wrote:
>>> I think the only point is the check in create_composite_quirk(), where
>>> it marks the iface as claimed and skips the next entry that has been
>>> already claimed.  However, the current code looks inconsistent -- it
>>> allows multiple entries only if the iface matches with the current
>>> one.  Fixing it like below would make things working.
>>>
>>> It's a quick idea, so a bit more reviews would be needed, though.
>>> Clemens, what do you think?
>>
>> Reviewed-by: Clemens Ladisch <clemens@ladisch.de>


>>> ---
>>> --- a/sound/usb/quirks.c
>>> +++ b/sound/usb/quirks.c
>>> @@ -58,9 +58,17 @@ static int create_composite_quirk(struct snd_usb_audio *chip,
>>>  		err = snd_usb_create_quirk(chip, iface, driver, quirk);
>>>  		if (err < 0)
>>>  			return err;
>>> -		if (quirk->ifnum != probed_ifnum)
>>> +	}
>>> +
>>> +	for (quirk = quirk->data; quirk->ifnum >= 0; ++quirk) {
>>> +		iface = usb_ifnum_to_if(chip->dev, quirk->ifnum);
>>> +		if (!iface)
>>> +			continue;
>>> +		if (quirk->ifnum != probed_ifnum &&
>>> +		    !usb_interface_claimed(iface))
>>>  			usb_driver_claim_interface(driver, iface, (void *)-1L);
>>>  	}
>>> +
>>>  	return 0;
>>>  }
>>>
>>

When I tried the patch on the hardware with my quirk, I got a kernel oops.

[   62.317456] BUG: unable to handle kernel NULL pointer dereference at
0000000000000010
[   62.317461] IP: [<ffffffffa04a5f34>] create_composite_quirk+0x84/0xf0
[snd_usb_audio]
[   62.317469] PGD 0
[   62.317471] Oops: 0000 [#1] PREEMPT SMP
[   62.317474] Modules linked in: snd_usb_audio(OE+) snd_usbmidi_lib(OE)
snd_hwdep(O) snd_pcm(O) snd_seq_midi(O) snd_seq_midi_event(O)
snd_rawmidi(O) snd_seq(O) snd_seq_device(O) snd_timer(O) snd(O)
soundcore(O) binfmt_misc dvb_pll mt352 cx88_dvb videobuf_dvb
cx88_vp3054_i2c dvb_core rc_dntv_live_dvb_t kvm_amd kvm cx8800 cx8802
crct10dif_pclmul cx88xx crc32_pclmul ghash_clmulni_intel aesni_intel
btcx_risc tveeprom aes_x86_64 videobuf_dma_sg lrw rc_core gf128mul
videobuf_core dm_multipath glue_helper v4l2_common scsi_dh ablk_helper
videodev cryptd shpchp serio_raw i2c_algo_bit k10temp i2c_piix4 mac_hid
parport_pc ppdev lp parport btrfs(E) raid10(E) raid456(E)
async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
async_tx(E) xor(E) raid6_pq(E) raid0(E) multipath(E) linear(E)
dm_mirror(E) dm_region_hash(E) dm_log(E) raid1(E) hid_generic(E)
usbhid(E) hid(E) psmouse(E) firewire_ohci(E) firewire_core(E)
crc_itu_t(E) r8169(E) mii(E) sdhci_pci(E) sdhci(E) ahci(E) libahci(E)
[   62.317514] CPU: 1 PID: 1549 Comm: insmod Tainted: G           OE
3.18.0-rc2+ #3
[   62.317516] Hardware name: ASUS F2A85-M, BIOS 4.0-5272-g07d881a-dirty
01/16/2014
[   62.317518] task: ffff880036638000 ti: ffff880036004000 task.ti:
ffff880036004000
[   62.317519] RIP: 0010:[<ffffffffa04a5f34>]  [<ffffffffa04a5f34>]
create_composite_quirk+0x84/0xf0 [snd_usb_audio]
[   62.317526] RSP: 0018:ffff880036007b08  EFLAGS: 00010286
[   62.317528] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000001
[   62.317529] RDX: 0000000000000008 RSI: 00000000ffffffff RDI:
ffff8804049b6400
[   62.317530] RBP: ffff880036007b28 R08: 0000000000000008 R09:
ffff88040e801b00
[   62.317531] R10: ffffffffa04221e0 R11: ffff880404f33890 R12:
0000000000000000
[   62.317532] R13: ffffffffa04b2f60 R14: ffff880036556d00 R15:
0000000000000000
[   62.317534] FS:  00007fa6ac676740(0000) GS:ffff88041ec80000(0000)
knlGS:0000000000000000
[   62.317535] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   62.317536] CR2: 0000000000000010 CR3: 00000000bad77000 CR4:
00000000000407e0
[   62.317538] Stack:
[   62.317539]  ffff880404f33800 0000000000000000 ffff880036556d00
ffffffffa04a8660
[   62.317541]  ffff880036007b38 ffffffffa04a5e7a ffff880036007bb8
ffffffffa0498888
[   62.317544]  ffff880404510cc8 0000000000000000 ffff880404f33890
ffff8804049b5c00
[   62.317546] Call Trace:
[   62.317554]  [<ffffffffa04a5e7a>] snd_usb_create_quirk+0x1a/0x50
[snd_usb_audio]
[   62.317560]  [<ffffffffa0498888>] usb_audio_probe+0x108/0x8d0
[snd_usb_audio]
[   62.317566]  [<ffffffff8158268f>] usb_probe_interface+0x1df/0x330
[   62.317569]  [<ffffffff814c4aad>] driver_probe_device+0x12d/0x3e0
[   62.317572]  [<ffffffff814c4e3b>] __driver_attach+0x9b/0xa0
[   62.317574]  [<ffffffff814c4da0>] ? __device_attach+0x40/0x40
[   62.317576]  [<ffffffff814c29d3>] bus_for_each_dev+0x63/0xa0
[   62.317578]  [<ffffffff814c448e>] driver_attach+0x1e/0x20
[   62.317580]  [<ffffffff814c4090>] bus_add_driver+0x180/0x240
[   62.317583]  [<ffffffff814c56a4>] driver_register+0x64/0xf0
[   62.317585]  [<ffffffff81580cf2>] usb_register_driver+0x82/0x160
[   62.317589]  [<ffffffffa04c1000>] ? 0xffffffffa04c1000
[   62.317594]  [<ffffffffa04c101e>] usb_audio_driver_init+0x1e/0x1000
[snd_usb_audio]
[   62.317597]  [<ffffffff8100212c>] do_one_initcall+0xbc/0x1f0
[   62.317601]  [<ffffffff811aa53c>] ? __vunmap+0x9c/0x110
[   62.317604]  [<ffffffff810f3252>] load_module+0x1d92/0x2820
[   62.317607]  [<ffffffff810ef0d0>] ? store_uevent+0x40/0x40
[   62.317610]  [<ffffffff810f3e56>] SyS_finit_module+0x86/0xb0
[   62.317613]  [<ffffffff81772aed>] system_call_fastpath+0x16/0x1b
[   62.317615] Code: 00 00 00 75 d2 48 89 d9 4c 89 ea 48 89 c6 4c 89 f7
e8 41 ff ff ff 85 c0 78 6f 48 83 c3 20 0f bf 73 10 66 85 f6 79 bd 48 8b
5b 18 <0f> bf 73 10 66 85 f6 79 10 eb 51 90 48 83 c3 20 0f bf 73 10 66
[   62.317638] RIP  [<ffffffffa04a5f34>]
create_composite_quirk+0x84/0xf0 [snd_usb_audio]
[   62.317645]  RSP <ffff880036007b08>
[   62.317646] CR2: 0000000000000010
[   62.317648] ---[ end trace d7b86fed44940082 ]---


My patch looks like this:

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c657752..773859c 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2944,27 +2944,53 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.data = (const struct snd_usb_audio_quirk[]){
 			{
 				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
-					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
+				.data = &(const struct audioformat){
+					.formats =
+						SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 1,
 					.altsetting = 1,
 					.altset_idx = 1,
-					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.attributes = 0x4,
 					.endpoint = 0x02,
-					.ep_attr = 0x01,
-					.rates = SNDRV_PCM_RATE_44100 |
-						 SNDRV_PCM_RATE_48000,
-					.rate_min = 44100,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_SYNC,
+					.maxpacksize = 0x130,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
 					.rate_max = 48000,
-					.nr_rates = 2,
+					.nr_rates = 1,
 					.rate_table = (unsigned int[]) {
-						44100, 48000
+						48000
+					}
+				}
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat){
+					.formats =
+						SNDRV_PCM_FMTBIT_S24_3BE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0x4,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.maxpacksize = 0x130,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) {
+						48000
 					}
 				}
 			},


I think it is something to do with the usb_ifnum_to_if() function not
liking to be called when the interface is not claimed, or something like
that?  Or did I miss something silly?

Damien
