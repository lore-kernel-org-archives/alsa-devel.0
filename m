From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH 06/19] mx27vis-aic32x4: only register when running on the right machine
Date: Tue, 13 Dec 2011 07:31:38 +0100
Message-ID: <1323757911-25217-6-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Javier Martin <javier.martin@vista-silicon.com>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

without this fix, a kernel compiled with imx_v4_v5_defconfig
and running on a cpuimx25sd leads to :
asoc: tlv320aic23-hifi <-> imx-ssi.0 mapping ok
------------[ cut here ]------------
WARNING: at fs/sysfs/dir.c:481 sysfs_add_one+0x90/0xb8()
sysfs: cannot create duplicate filename '/devices/platform/soc-audio'
Modules linked in:
[<c00198e8>] (unwind_backtrace+0x0/0xf0) from [<c002ea5c>] (warn_slowpa=
th_common+0x48/0x60)
[<c002ea5c>] (warn_slowpath_common+0x48/0x60) from [<c002eb08>] (warn_s=
lowpath_fmt+0x30/0x40)
[<c002eb08>] (warn_slowpath_fmt+0x30/0x40) from [<c0120090>] (sysfs_add=
_one+0x90/0xb8)
[<c0120090>] (sysfs_add_one+0x90/0xb8) from [<c0120118>] (create_dir+0x=
60/0xc0)
[<c0120118>] (create_dir+0x60/0xc0) from [<c0120228>] (sysfs_create_dir=
+0x84/0xcc)
[<c0120228>] (sysfs_create_dir+0x84/0xcc) from [<c019b9e0>] (kobject_ad=
d_internal+0xac/0x1d0)
[<c019b9e0>] (kobject_add_internal+0xac/0x1d0) from [<c019bdd8>] (kobje=
ct_add+0x50/0x98)
[<c019bdd8>] (kobject_add+0x50/0x98) from [<c01f6aec>] (device_add+0xb0=
/0x610)
[<c01f6aec>] (device_add+0xb0/0x610) from [<c01fac8c>] (platform_device=
_add+0xfc/0x238)
[<c01fac8c>] (platform_device_add+0xfc/0x238) from [<c046d884>] (mx27vi=
s_aic32x4_init+0x38/0x84)
[<c046d884>] (mx27vis_aic32x4_init+0x38/0x84) from [<c00088a0>] (do_one=
_initcall+0x34/0x178)
[<c00088a0>] (do_one_initcall+0x34/0x178) from [<c045978c>] (kernel_ini=
t+0x78/0x114)
[<c045978c>] (kernel_init+0x78/0x114) from [<c0014df4>] (kernel_thread_=
exit+0x0/0x8)
---[ end trace b6a96897e189aea3 ]---
kobject_add_internal failed for soc-audio with -EEXIST, don't try to re=
gister things with the same name in the same directory.
[<c00198e8>] (unwind_backtrace+0x0/0xf0) from [<c019baec>] (kobject_add=
_internal+0x1b8/0x1d0)
[<c019baec>] (kobject_add_internal+0x1b8/0x1d0) from [<c019bdd8>] (kobj=
ect_add+0x50/0x98)
[<c019bdd8>] (kobject_add+0x50/0x98) from [<c01f6aec>] (device_add+0xb0=
/0x610)
[<c01f6aec>] (device_add+0xb0/0x610) from [<c01fac8c>] (platform_device=
_add+0xfc/0x238)
[<c01fac8c>] (platform_device_add+0xfc/0x238) from [<c046d884>] (mx27vi=
s_aic32x4_init+0x38/0x84)
[<c046d884>] (mx27vis_aic32x4_init+0x38/0x84) from [<c00088a0>] (do_one=
_initcall+0x34/0x178)
[<c00088a0>] (do_one_initcall+0x34/0x178) from [<c045978c>] (kernel_ini=
t+0x78/0x114)
[<c045978c>] (kernel_init+0x78/0x114) from [<c0014df4>] (kernel_thread_=
exit+0x0/0x8)
ASoC: Platform device allocation failed
mxc_audmux_v1_configure_port: not configured
mxc_audmux_v1_configure_port: not configured

Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/imx/mx27vis-aic32x4.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-ai=
c32x4.c
index 054110b..224ffcc 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -96,6 +96,10 @@ static int __init mx27vis_aic32x4_init(void)
 {
 	int ret;
=20
+	if (!machine_is_imx27_visstrim_m10())
+		/* return happy. We might run on a totally different machine */
+		return 0;
+
 	mx27vis_aic32x4_snd_device =3D platform_device_alloc("soc-audio", -1)=
;
 	if (!mx27vis_aic32x4_snd_device)
 		return -ENOMEM;
--=20
1.7.6.4
