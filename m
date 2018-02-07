From: Sven Schnelle <svens@stackframe.org>
Subject: kernel crash in snd_ctl_notify
Date: Wed, 7 Feb 2018 22:25:18 +0100
Message-ID: <46a60ea3-95b6-00dd-dd48-20e06d5aed3a@stackframe.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C30C9E3E12DC392C28CCDF4B"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.duncanthrax.net (smtp.duncanthrax.net [89.31.1.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CF262676C5
 for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2018 22:25:20 +0100 (CET)
Received: from hsi-kbw-078-043-163-172.hsi4.kabel-badenwuerttemberg.de
 ([78.43.163.172] helo=[192.168.0.20])
 by smtp.eurescom.eu with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1ejXDT-0007u1-Qp
 for alsa-devel@alsa-project.org; Wed, 07 Feb 2018 22:25:19 +0100
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------C30C9E3E12DC392C28CCDF4B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi List,


i just got external screens for my Thinkpad T470p. They are connected
via Displayport to the docking station of the thinkpad. However, when i
put the Thinkpad in the docking station, i see the following kernel crash:


Feb  5 08:39:21 t470p kernel: [  106.616102] BUG: unable to handle
kernel NULL pointer dereference at 0000000000000
Feb  5 08:39:21 t470p kernel: [  106.616119] IP:
snd_ctl_notify.part.9+0xb3/0x190
Feb  5 08:39:21 t470p kernel: [  106.616123] PGD 0 P4D 0
Feb  5 08:39:21 t470p kernel: [  106.616129] Oops: 0000 [#1] SMP PTI
Feb  5 08:39:21 t470p kernel: [  106.616133] Modules linked in: e1000e
Feb  5 08:39:21 t470p kernel: [  106.616140] CPU: 6 PID: 1298 Comm: Xorg
Not tainted 4.15.0+ #148
Feb  5 08:39:21 t470p kernel: [  106.616143] Hardware name: LENOVO
20J6003DGE/20J6003DGE, BIOS R0FET39W (1.19 ) 12/
Feb  5 08:39:21 t470p kernel: [  106.616149] RIP:
0010:snd_ctl_notify.part.9+0xb3/0x190
Feb  5 08:39:21 t470p kernel: [  106.616152] RSP: 0018:ffffb7d2c068fa88
EFLAGS: 00010086
Feb  5 08:39:21 t470p kernel: [  106.616156] RAX: ffff949ab97edf60 RBX:
ffff949abb4ca4c8 RCX: 0000000000000000
Feb  5 08:39:21 t470p kernel: [  106.616159] RDX: 0000000000000060 RSI:
0000000000000000 RDI: ffff949ab97edfc0
Feb  5 08:39:21 t470p kernel: [  106.616162] RBP: ffff949abb4ca000 R08:
ffff949abaac3a10 R09: ffff949ab97edf60
Feb  5 08:39:21 t470p kernel: [  106.616164] R10: ffff949abaac3a10 R11:
00000000000003d8 R12: ffff949aaea132c0
Feb  5 08:39:21 t470p kernel: [  106.616167] R13: 0000000000000202 R14:
0000000000000010 R15: ffff949aaea13280
Feb  5 08:39:21 t470p kernel: [  106.616171] FS:  00007f57ded37500(0000)
GS:ffff949ad1580000(0000) knlGS:0000000000
Feb  5 08:39:21 t470p kernel: [  106.616174] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Feb  5 08:39:21 t470p kernel: [  106.616176] CR2: 0000000000000010 CR3:
000000043cf06005 CR4: 00000000003606e0
Feb  5 08:39:21 t470p kernel: [  106.616179] DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Feb  5 08:39:21 t470p kernel: [  106.616182] DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Feb  5 08:39:21 t470p kernel: [  106.616184] Call Trace:
Feb  5 08:39:21 t470p kernel: [  106.616194]  hdmi_present_sense+0xdc/0x370
Feb  5 08:39:21 t470p kernel: [  106.616200] 
check_presence_and_report+0x5e/0x80
Feb  5 08:39:21 t470p kernel: [  106.616206] 
intel_audio_codec_disable+0xab/0xd0
Feb  5 08:39:21 t470p kernel: [  106.616213] 
intel_encoders_disable.isra.97+0x70/0x90
Feb  5 08:39:21 t470p kernel: [  106.616219] 
haswell_crtc_disable+0x47/0x140
Feb  5 08:39:21 t470p kernel: [  106.616225] 
intel_atomic_commit_tail+0x70e/0xcb0
Feb  5 08:39:21 t470p kernel: [  106.616231]  ?
intel_atomic_commit_ready+0x44/0x4c
Feb  5 08:39:21 t470p kernel: [  106.616236] 
intel_atomic_commit+0x21f/0x2d0
Feb  5 08:39:21 t470p kernel: [  106.616241] 
drm_atomic_connector_commit_dpms+0xe5/0xf0
Feb  5 08:39:21 t470p kernel: [  106.616248] 
drm_mode_obj_set_property_ioctl+0x153/0x260
Feb  5 08:39:21 t470p kernel: [  106.616253]  ?
drm_mode_connector_set_obj_prop+0x70/0x70
Feb  5 08:39:21 t470p kernel: [  106.616258] 
drm_mode_connector_property_set_ioctl+0x2e/0x40
Feb  5 08:39:21 t470p kernel: [  106.616264]  drm_ioctl_kernel+0x59/0xb0
Feb  5 08:39:21 t470p kernel: [  106.616270]  drm_ioctl+0x29f/0x340
Feb  5 08:39:21 t470p kernel: [  106.616275]  ?
drm_mode_connector_set_obj_prop+0x70/0x70
Feb  5 08:39:21 t470p kernel: [  106.616282]  ? signal_setup_done+0x57/0x90
Feb  5 08:39:21 t470p kernel: [  106.616288]  ?
__fpu__restore_sig+0x80/0x400
Feb  5 08:39:21 t470p kernel: [  106.616295]  do_vfs_ioctl+0x8d/0x5d0
Feb  5 08:39:21 t470p kernel: [  106.616301]  SyS_ioctl+0x3b/0x70
Feb  5 08:39:21 t470p kernel: [  106.616307] 
entry_SYSCALL_64_fastpath+0x22/0x8a
Feb  5 08:39:21 t470p kernel: [  106.616312] RIP: 0033:0x7f57dc1b7307
Feb  5 08:39:21 t470p kernel: [  106.616314] RSP: 002b:00007ffe3459f138
EFLAGS: 00003246
Feb  5 08:39:21 t470p kernel: [  106.616317] Code: 8b 00 48 39 c8 75 ef
ba 58 00 00 00 be 20 80 08 01 48 89 4c 24 0
Feb  5 08:39:21 t470p kernel: [  106.616384] RIP:
snd_ctl_notify.part.9+0xb3/0x190 RSP: ffffb7d2c068fa88
Feb  5 08:39:21 t470p kernel: [  106.616387] CR2: 0000000000000010
Feb  5 08:39:21 t470p kernel: [  106.616391] ---[ end trace
0e8742968e349514 ]---

RIP is at snd_ctl_notify, because the id parameter is NULL.

Looking a bit further, i see the following in the kernel log:

Feb  6 08:14:20 t470p kernel: [    6.266169] snd_hda_intel 0000:00:1f.3:
Too many HDMI devices
Feb  6 08:14:20 t470p kernel: [    6.266170] snd_hda_intel 0000:00:1f.3:
Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
Feb  6 08:14:20 t470p kernel: [    6.266171] snd_hda_intel 0000:00:1f.3:
Too many HDMI devices
Feb  6 08:14:20 t470p kernel: [    6.266172] snd_hda_intel 0000:00:1f.3:
Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
Feb  6 08:14:20 t470p kernel: [    6.266172] snd_hda_intel 0000:00:1f.3:
Too many HDMI devices
Feb  6 08:14:20 t470p kernel: [    6.266173] snd_hda_intel 0000:00:1f.3:
Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y

So it seems like commit 1f7f51a63114bab3a05920f4b1343154e95e2cb6 ("Fix
regression of hdmi eld control created based on invalid pcm") might be
causing this issue. While it makes the probe work, it doesn't assign the
pcm pointer in the hdmi data structure. Later it get's referenced and
the kernel crashes.

Enabling CONFIG_SND_DYNAMIC_MINORS makes the issue go away, but the
kernel shouldn't crash if it's disabled.I made the attached patch to fix
this. However, i'm not sure whether this is the right way to fix it and
whether it needs to be patched in other places.


Regards

Sven



--------------C30C9E3E12DC392C28CCDF4B
Content-Type: text/x-patch;
 name="alsa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="alsa.patch"

commit b1b2c798b2943c887bd063bbe415aa2e48923817
Author: Sven Schnelle <svens@stackframe.org>
Date:   Tue Feb 6 09:17:18 2018 +0100

    ALSA: hda: check eld_ctl pointer before using it
    
    Signed-off-by: Sven Schnelle <svens@stackframe.org>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b4f1b6e88305..7efe0dc26c7c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1433,6 +1433,7 @@ static void update_eld(struct hda_codec *codec,
 {
 	struct hdmi_eld *pin_eld = &per_pin->sink_eld;
 	struct hdmi_spec *spec = codec->spec;
+	struct snd_kcontrol *eld_ctl;
 	bool old_eld_valid = pin_eld->eld_valid;
 	bool eld_changed;
 	int pcm_idx = -1;
@@ -1482,11 +1483,13 @@ static void update_eld(struct hda_codec *codec,
 		hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
 	}
 
-	if (eld_changed && pcm_idx >= 0)
+	eld_ctl =  get_hdmi_pcm(spec, pcm_idx)->eld_ctl;
+	if (eld_changed && pcm_idx >= 0 && eld_ctl) {
 		snd_ctl_notify(codec->card,
 			       SNDRV_CTL_EVENT_MASK_VALUE |
 			       SNDRV_CTL_EVENT_MASK_INFO,
-			       &get_hdmi_pcm(spec, pcm_idx)->eld_ctl->id);
+			       &eld_ctl->id);
+	}
 }
 
 /* update ELD and jack state via HD-audio verbs */


--------------C30C9E3E12DC392C28CCDF4B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------C30C9E3E12DC392C28CCDF4B--
