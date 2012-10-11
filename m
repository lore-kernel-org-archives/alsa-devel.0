From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: usb audio race at disconnect time
Date: Thu, 11 Oct 2012 17:17:59 +0200
Message-ID: <5076E327.5030503@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080101040107020607030404"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co202.xi-lite.net (co202.xi-lite.net [149.6.83.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 909DF265176
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 17:18:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: USB list <linux-usb@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

--------------080101040107020607030404
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

while doing some monkey tests on a product we found races in usb audio code when
the device in unplugged from usb (on linus master tree).

This can be reproduced with usb_audio_show_race.diff and CONFIG_DEBUG_SLAB.
With this patch, start a stream :
# arecord -D hw:0 -r 44100 -c 2  -f S16_LE > /dev/null
you will see the kernel log : "in snd_usb_hw_params sleeping"
Unplug the device before "in snd_usb_hw_params sleeping exit", and you will see
an oops in snd_pcm_hw_params


Instead of using CONFIG_DEBUG_SLAB, usb_audio_show_use_after_free.diff can show
use after free by setting usb_device pointer to NULL in
snd_usb_audio_disconnect. [1]


In order to protect from all the races, before using any usb_device we need to
check if it is not freed.

What's the best way to do that ?

A trival fix would be to take a mutex in all snd_pcm_ops callback that access usb :

{
mutex_lock(&chip->shutdown_mutex);
if (!chip->dev) {
	mutex_unlock(&chip->shutdown_mutex);
	return -ENODEV;
}
[...]
mutex_unlock(&chip->shutdown_mutex);
}


But that will serialize all snd_pcm_ops callbacks.

Another solution could be to use refcounting or rwlock patern :
- snd_pcm_ops callbacks call rdlock_trylock/rdlock_unlock
- usb_driver disconnect callback take rwlock_lock and never release it

This will make "usb_driver disconnect" wait that all "snd_pcm_ops callback" are
finished and abort all future call to "snd_pcm_ops callback".

I believe similar problems exist in other drivers, (we saw another one  in
hidraw [2]), so it could be nice to find a generic pattern to help driver to
manage correctly disconnection.

Are there any recommended pattern ?


Do you have any comment ?

Thanks,

Matthieu


[1]

[ 1366.315307] usb 1-2.1.3: new full-speed USB device number 4 using ehci-omap
[ 1366.556579] input: USB Audio as /devices/platform/usbhs_omap/ehci-omap.0/usb1
/1-2/1-2.1/1-2.1.3/1-2.1.3:1.3/input/input1
[ 1366.604553] hid-generic 0003:06F8:C000.0001: input,hidraw0: USB HID v1.00 Dev
ice [USB Audio] on usb-ehci-omap.0-2.1.3/input3

#
#
# arecord -D hw:0 -r 44100 -c 2  -f S16_LE > /dev/null
Recording WAVE '[ 1368.937774] in snd_usb_hw_params sleeping
stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
         please, try the plug plugin
[ 1372.385375] hid-generic 0003:06F8:C000.0001: can't reset device, ehci-omap.0-
2.1.3/input3, status -71
[ 1372.439514] usb 1-2.1.3: USB disconnect, device number 4
[ 1372.449005] hid-generic 0003:06F8:C000.0001: can't reset device, ehci-omap.0-
2.1.3/input3, status -71
[ 1378.947235] in snd_usb_hw_params sleeping exit
[ 1378.952301] Unable to handle kernel NULL pointer dereference at virtual addre
ss 0000029c
[ 1378.961029] pgd = c31e8000
[ 1378.964019] [0000029c] *pgd=8e885831, *pte=00000000, *ppte=00000000
[ 1378.970825] Internal error: Oops: 17 [#1] SMP ARM
[ 1378.975799] Modules linked in:
[ 1378.979064] CPU: 0    Not tainted  (3.6.0-03889-ge8dc7a6-dirty #5)
[ 1378.985595] PC is at usb_ifnum_to_if+0xc/0xd4
[ 1378.990234] LR is at snd_usb_hw_params+0x1bc/0x764
[ 1378.995300] pc : [<c0275338>]    lr : [<c030816c>]    psr: 00000013
[ 1378.995300] sp : cf3fddf0  ip : cf3fde08  fp : cf3fde04
[ 1379.007415] r10: 0000bb80  r9 : 00000001  r8 : 00000000
[ 1379.012908] r7 : cf972f40  r6 : cf3e1f14  r5 : ce8ad000  r4 : cf3e1eb0
[ 1379.019805] r3 : 00000004  r2 : 00000005  r1 : 00000002  r0 : 00000000
[ 1379.026702] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[ 1379.034240] Control: 10c5387d  Table: 831e8019  DAC: 00000015
[ 1379.040313] Process arecord (pid: 636, stack limit = 0xcf3fc2f8)
[ 1379.046661] Stack: (0xcf3fddf0 to 0xcf3fe000)
[ 1379.051269] dde0:                                     cf3e1eb0 ce8ad000 cf3fd
e5c cf3fde08
[ 1379.059906] de00: c030816c c0275338 cf3fde3c cf3fde18 c02f5d68 c02f59e4 c05b4
c60 ce8ad000
[ 1379.068542] de20: cf3e1800 00000001 00000004 00000001 cf3fde5c cf3e1800 ce8ad
800 c05b8310
[ 1379.077178] de40: ce8ad000 c0014728 cf3fc000 00000000 cf3fde7c cf3fde60 c02f0
b8c c0307fbc
[ 1379.085815] de60: cf3e1800 be91b890 be91b890 ce8ad000 cf3fdec4 cf3fde80 c02f1
778 c02f0ad4
[ 1379.094451] de80: cf3fc000 60000013 cf97b540 00000002 c0126484 00000000 cf3fd
ed4 cf3e1800
[ 1379.103088] dea0: be91b890 cf3e5078 c0045877 c0014728 cf3fc000 00000000 cf3fd
efc cf3fdec8
[ 1379.111755] dec0: c02f2150 c02f1228 cf3fdf3c cf3fded8 c0126634 c0068ef0 00000
001 00000000
[ 1379.120391] dee0: cf87f280 be91b890 cf3e5078 c0045877 cf3fdf0c cf3fdf00 c02f2
5dc c02f2124
[ 1379.129028] df00: cf3fdf7c cf3fdf10 c00fd6b4 c02f25ac c03d7328 cf8b49c8 00000
026 00000000
[ 1379.137664] df20: cd673738 00000002 cf3fc000 00000000 cf3fdf6c cf3fdf40 c00ec
138 c0126420
[ 1379.146301] df40: 00000000 00000000 00000006 cf8b49c0 be919140 00000000 cf87f
280 be91b890
[ 1379.154907] df60: c25c4111 00000004 c0014728 cf3fc000 cf3fdfa4 cf3fdf80 c00fd
c6c c00fd638
[ 1379.163543] df80: c00183f0 00000000 00028288 b6fc68a0 00028238 00000036 00000
000 cf3fdfa8
[ 1379.172180] dfa0: c00145a0 c00fdc38 00028288 b6fc68a0 00000004 c25c4111 be91b
890 00020001
[ 1379.180816] dfc0: 00028288 b6fc68a0 00028238 00000036 be91b890 0000bb80 0000a
c44 be91bb74
[ 1379.189453] dfe0: 00028288 be91b760 b6fa41c8 b6e05aec 20000010 00000004 007ff
f00 00ffdf00
[ 1379.198089] Backtrace:
[ 1379.200683] [<c027532c>] (usb_ifnum_to_if+0x0/0xd4) from [<c030816c>] (snd_us
b_hw_params+0x1bc/0x764)
[ 1379.210418]  r5:ce8ad000 r4:cf3e1eb0
[ 1379.214263] [<c0307fb0>] (snd_usb_hw_params+0x0/0x764) from [<c02f0b8c>] (snd
_pcm_hw_params+0xc4/0x368)
[ 1379.224182] [<c02f0ac8>] (snd_pcm_hw_params+0x0/0x368) from [<c02f1778>] (snd
_pcm_common_ioctl1+0x55c/0xefc)
[ 1379.234558]  r7:ce8ad000 r6:be91b890 r5:be91b890 r4:cf3e1800
[ 1379.240600] [<c02f121c>] (snd_pcm_common_ioctl1+0x0/0xefc) from [<c02f2150>]
(snd_pcm_capture_ioctl1+0x38/0x488)
[ 1379.251342] [<c02f2118>] (snd_pcm_capture_ioctl1+0x0/0x488) from [<c02f25dc>]
 (snd_pcm_capture_ioctl+0x3c/0x40)
[ 1379.261962]  r7:c0045877 r6:cf3e5078 r5:be91b890 r4:cf87f280
[ 1379.268005] [<c02f25a0>] (snd_pcm_capture_ioctl+0x0/0x40) from [<c00fd6b4>] (
do_vfs_ioctl+0x88/0x600)
[ 1379.277770] [<c00fd62c>] (do_vfs_ioctl+0x0/0x600) from [<c00fdc6c>] (sys_ioct
l+0x40/0x68)
[ 1379.286376]  r9:cf3fc000 r8:c0014728 r7:00000004 r6:c25c4111 r5:be91b890
r4:cf87f280
[ 1379.294738] [<c00fdc2c>] (sys_ioctl+0x0/0x68) from [<c00145a0>] (ret_fast_sys
call+0x0/0x30)
[ 1379.303558]  r7:00000036 r6:00028238 r5:b6fc68a0 r4:00028288
[ 1379.309600] Code: e89da818 e1a0c00d e92dd830 e24cb004 (e590329c)
[ 1379.316223] ---[ end trace 48c30133f24e0b57 ]---
[ 1379.321105] Kernel panic - not syncing: Fatal exception


[2]
[  349.573974] ------------[ cut here ]------------
[  349.578796] WARNING: at
/opt/mcastet/CIA/fidji-beta28/raptor/kernel/omap/lib/list_debug.c:48
list_del+0x30/0x8c()
[  349.589477] list_del corruption. prev->next should be d95efc44, but was 6b6b6b6b
[  349.597167] Modules linked in: blackberry cdc_acm sierra option usb_wwan hso
atmel_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap2_mcspi omap_hsmmc
[  349.611572] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f7b4>]
(warn_slowpath_common+0x4c/0x64)
[  349.621368] [<c016f7b4>] (warn_slowpath_common+0x4c/0x64) from [<c016f84c>]
(warn_slowpath_fmt+0x2c/0x3c)
[  349.631347] [<c016f84c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0298200>]
(list_del+0x30/0x8c)
[  349.640228] [<c0298200>] (list_del+0x30/0x8c) from [<c0185d50>]
(remove_wait_queue+0x2c/0x6c)
[  349.649108] [<c0185d50>] (remove_wait_queue+0x2c/0x6c) from [<c01f4e64>]
(free_poll_entry+0x14/0x20)
[  349.658630] [<c01f4e64>] (free_poll_entry+0x14/0x20) from [<c01f4e88>]
(poll_freewait+0x18/0x6c)
[  349.667785] [<c01f4e88>] (poll_freewait+0x18/0x6c) from [<c01f5448>]
(do_sys_poll+0x314/0x3a4)
[  349.676757] [<c01f5448>] (do_sys_poll+0x314/0x3a4) from [<c01f56fc>]
(sys_poll+0x5c/0xbc)
[  349.685272] [<c01f56fc>] (sys_poll+0x5c/0xbc) from [<c0138f40>]
(ret_fast_syscall+0x0/0x30)
[  349.693969] ---[ end trace 1b75b31a2719ed1e ]---
[  349.698791] ------------[ cut here ]------------
[  349.703582] WARNING: at
/opt/mcastet/CIA/fidji-beta28/raptor/kernel/omap/lib/list_debug.c:51
list_del+0x58/0x8c()
[  349.714263] list_del corruption. next->prev should be d95efc44, but was 6b6b6b6b
[  349.721954] Modules linked in: blackberry cdc_acm sierra option usb_wwan hso
atmel_mxt_ts cp210x pl2303 usbserial 88w8688_wlan tun omap2_mcspi omap_hsmmc
[  349.736328] [<c013e608>] (unwind_backtrace+0x0/0xf0) from [<c016f7b4>]
(warn_slowpath_common+0x4c/0x64)
[  349.746124] [<c016f7b4>] (warn_slowpath_common+0x4c/0x64) from [<c016f84c>]
(warn_slowpath_fmt+0x2c/0x3c)
[  349.756103] [<c016f84c>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0298228>]
(list_del+0x58/0x8c)
[  349.764984] [<c0298228>] (list_del+0x58/0x8c) from [<c0185d50>]
(remove_wait_queue+0x2c/0x6c)
[  349.773864] [<c0185d50>] (remove_wait_queue+0x2c/0x6c) from [<c01f4e64>]
(free_poll_entry+0x14/0x20)
[  349.783386] [<c01f4e64>] (free_poll_entry+0x14/0x20) from [<c01f4e88>]
(poll_freewait+0x18/0x6c)
[  349.792541] [<c01f4e88>] (poll_freewait+0x18/0x6c) from [<c01f5448>]
(do_sys_poll+0x314/0x3a4)
[  349.801513] [<c01f5448>] (do_sys_poll+0x314/0x3a4) from [<c01f56fc>]
(sys_poll+0x5c/0xbc)
[  349.810028] [<c01f56fc>] (sys_poll+0x5c/0xbc) from [<c0138f40>]
(ret_fast_syscall+0x0/0x30)
[  349.818725] ---[ end trace 1b75b31a2719ed1f ]---
[  349.830444] hub 1-1:1.0: unable to enumerate USB device on port 2
[  350.412475] Slab corruption: size-64 start=d7189ac0, len=64
[  350.420166] 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b cc 9a 18 d7
[  350.426544] 010: cc 9a 18 d7 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
[  350.435699] Prev obj: start=d7189a80, len=64
[  350.441284] 000: 02 26 00 00 c5 91 18 d7 84 93 18 d7 c4 9d 18 d7
[  350.447601] 010: 50 91 ad d3 50 9f 18 d7 50 95 ad d3 00 00 00 00
[  350.454650] Next obj: start=d7189b00, len=64
[  350.460083] 000: 5d 25 00 00 05 78 e5 d8 c4 9e 18 d7 44 13 6a d9
[  350.466613] 010: 91 13 6a d9 00 00 00 00 00 00 00 00 00 00 00 00

--------------080101040107020607030404
Content-Type: text/x-diff; name="usb_audio_show_race.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="usb_audio_show_race.diff"

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f782ce1..7ffb394 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -453,6 +453,10 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels, rate, format;
 	int ret, changed;
 
+	printk("in snd_usb_hw_params sleeping\n");
+	msleep(10000);
+	printk("in snd_usb_hw_params sleeping exit\n");
+
 	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 					       params_buffer_bytes(hw_params));
 	if (ret < 0)

--------------080101040107020607030404
Content-Type: text/x-diff; name="usb_audio_show_use_after_free.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="usb_audio_show_use_after_free.diff"

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 4a469f0..7c72e41 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -134,6 +134,7 @@ static void snd_usb_stream_disconnect(struct list_head *head)
 		subs->interface = -1;
 		subs->data_endpoint = NULL;
 		subs->sync_endpoint = NULL;
+		subs->dev = NULL;
 	}
 }
 
@@ -582,6 +583,7 @@ static void snd_usb_audio_disconnect(struct usb_device *dev,
 			snd_usb_mixer_disconnect(p);
 		}
 		usb_chip[chip->index] = NULL;
+		chip->dev = NULL;
 		mutex_unlock(&chip->shutdown_mutex);
 		mutex_unlock(&register_mutex);
 		snd_card_free_when_closed(card);

--------------080101040107020607030404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080101040107020607030404--
