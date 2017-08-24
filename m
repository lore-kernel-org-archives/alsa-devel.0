From: Fabio Estevam <festevam@gmail.com>
Subject: proc_dir_entry 'asound/pcm' already registered
Date: Thu, 24 Aug 2017 14:28:12 -0300
Message-ID: <CAOMZO5CMogVduV2K4QMKOiEjJ2u+zQaDymt9aYhHQ+ZMih7TKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 911E8266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 19:28:14 +0200 (CEST)
Received: by mail-oi0-f53.google.com with SMTP id t88so1241119oij.0
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 10:28:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I am running linux-next 20170824 on a imx6q-sabresd and getting the
warnings below.

Any ideas as to why 'asound/pcm' is getting registered twice?

Thanks

[    3.842972] fsl-ssi-dai 202c000.ssi: No cache defaults, reading back from HW
[    3.859270] input: WM8962 Beep Generator as
/devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-001a/input/input1
[    3.921494] ------------[ cut here ]------------
[    3.926181] WARNING: CPU: 1 PID: 1 at fs/proc/generic.c:330
proc_register+0xc8/0x13c
[    3.934020] proc_dir_entry 'asound/pcm' already registered
[    3.939609] Modules linked in:
[    3.942712] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.13.0-rc6-next-20170824 #49
[    3.950301] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    3.956849] Backtrace:
[    3.959340] [<c010ca24>] (dump_backtrace) from [<c010ccf4>]
(show_stack+0x18/0x1c)
[    3.966933]  r7:00000000 r6:60000013 r5:00000000 r4:c0e79b80
[    3.972620] [<c010ccdc>] (show_stack) from [<c09ca560>]
(dump_stack+0xb4/0xe8)
[    3.979869] [<c09ca4ac>] (dump_stack) from [<c0125654>] (__warn+0xd8/0x104)
[    3.986856]  r9:c029892c r8:0000014a r7:00000009 r6:c0c06374
r5:00000000 r4:ec069b48
[    3.994623] [<c012557c>] (__warn) from [<c01256bc>]
(warn_slowpath_fmt+0x3c/0x44)
[    4.002129]  r9:ec338f2c r8:00000000 r7:ec338f00 r6:00000001
r5:ec887b40 r4:c0c06404
[    4.009898] [<c0125684>] (warn_slowpath_fmt) from [<c029892c>]
(proc_register+0xc8/0x13c)
[    4.018096]  r3:ec338f7d r2:c0c06404
[    4.021691]  r4:ec12c874
[    4.024254] [<c0298864>] (proc_register) from [<c0298c64>]
(proc_create_data+0x80/0xc4)
[    4.032281]  r10:ec8a9e00 r9:00000000 r8:00000000 r7:ec138000
r6:ec887a80 r5:c0a900f0
[    4.040130]  r4:ec887b40
[    4.042695] [<c0298be4>] (proc_create_data) from [<c075456c>]
(snd_info_register+0x6c/0xd4)
[    4.051066]  r5:ec338f00 r4:ec887a80
[    4.054670] [<c0754500>] (snd_info_register) from [<c07590ac>]
(snd_pcm_new_stream+0x15c/0x454)
[    4.063388]  r5:ec145800 r4:00000000
[    4.066987] [<c0758f50>] (snd_pcm_new_stream) from [<c0759a54>]
(_snd_pcm_new+0xb4/0x13c)
[    4.075188]  r10:00000000 r9:00000000 r8:00000001 r7:ec138000
r6:ec069ca4 r5:ec069ca8
[    4.083036]  r4:ec145800
[    4.085593] [<c07599a0>] (_snd_pcm_new) from [<c0759afc>]
(snd_pcm_new+0x20/0x28)
[    4.093100]  r10:ec069ca8 r9:00000001 r8:ec132c80 r7:00000000
r6:ec8a9a0c r5:00000001
[    4.100948]  r4:00000001 r3:00000001
[    4.104550] [<c0759adc>] (snd_pcm_new) from [<c0777c0c>]
(soc_new_pcm+0x12c/0x45c)
[    4.112139]  r4:ec144800
[    4.114700] [<c0777ae0>] (soc_new_pcm) from [<c076b658>]
(snd_soc_register_card+0xc40/0xe38)
[    4.123162]  r10:ec144800 r9:ec8cd810 r8:00000002 r7:ec8cd898
r6:ec8cd9d4 r5:ec8cd978
[    4.131011]  r4:c0c8dcb8
[    4.133570] [<c076aa18>] (snd_soc_register_card) from [<c0778474>]
(devm_snd_soc_register_card+0x38/0x78)
[    4.143161]  r10:ec224400 r9:ec8cd810 r8:c0aaf308 r7:ec284c10
r6:ec8cd898 r5:ec89b150
[    4.151009]  r4:ec8cd898
[    4.153575] [<c077843c>] (devm_snd_soc_register_card) from
[<c07913a4>] (imx_wm8962_probe+0x244/0x37c)
[    4.162905]  r7:ef7d9650 r6:ec284c10 r5:ec284c00 r4:ec8cd898
[    4.168595] [<c0791160>] (imx_wm8962_probe) from [<c0546780>]
(platform_drv_probe+0x54/0xb8)
[    4.177056]  r10:00000000 r9:00000000 r8:c0e70228 r7:fffffdfb
r6:c0e70228 r5:ec284c10
[    4.184904]  r4:ec284c10
[    4.187470] [<c054672c>] (platform_drv_probe) from [<c0544bf4>]
(driver_probe_device+0x274/0x2fc)
[    4.196365]  r7:c15e6c10 r6:00000000 r5:c15e6c0c r4:ec284c10
[    4.202051] [<c0544980>] (driver_probe_device) from [<c0544d44>]
(__driver_attach+0xc8/0xcc)
[    4.210513]  r10:c0d00618 r9:c0d6089c r8:00000000 r7:00000000
r6:ec284c44 r5:c0e70228
[    4.218361]  r4:ec284c10 r3:00000000
[    4.221964] [<c0544c7c>] (__driver_attach) from [<c0542ebc>]
(bus_for_each_dev+0x74/0xa8)
[    4.230164]  r7:00000000 r6:c0544c7c r5:c0e70228 r4:00000000
[    4.235852] [<c0542e48>] (bus_for_each_dev) from [<c0544530>]
(driver_attach+0x20/0x28)
[    4.243876]  r6:c0e3b288 r5:ec132300 r4:c0e70228
[    4.248520] [<c0544510>] (driver_attach) from [<c054402c>]
(bus_add_driver+0x190/0x218)
[    4.256549] [<c0543e9c>] (bus_add_driver) from [<c05456e4>]
(driver_register+0x80/0x100)
[    4.264662]  r7:c0cf5ec4 r6:c0d60894 r5:c0d4e44c r4:c0e70228
[    4.270347] [<c0545664>] (driver_register) from [<c05466d4>]
(__platform_driver_register+0x38/0x4c)
[    4.279412]  r5:c0d4e44c r4:ffffe000
[    4.283020] [<c054669c>] (__platform_driver_register) from
[<c0d4e464>] (imx_wm8962_driver_init+0x18/0x20)
[    4.292702] [<c0d4e44c>] (imx_wm8962_driver_init) from [<c0101c54>]
(do_one_initcall+0x44/0x17c)
[    4.301517] [<c0101c10>] (do_one_initcall) from [<c0d00e7c>]
(kernel_init_freeable+0x118/0x1d0)
[    4.310238]  r8:000000f1 r7:c0cf5ec4 r6:c0d60894 r5:c0e7d000 r4:c0d710e0
[    4.316967] [<c0d00d64>] (kernel_init_freeable) from [<c09de898>]
(kernel_init+0x10/0x118)
[    4.325254]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c09de888
[    4.333102]  r4:00000000
[    4.335665] [<c09de888>] (kernel_init) from [<c01080f8>]
(ret_from_fork+0x14/0x3c)
[    4.343255]  r5:c09de888 r4:00000000
[    4.346962] ---[ end trace 3ea29ef261f4780c ]---
[    4.351955] ------------[ cut here ]------------
[    4.356611] WARNING: CPU: 1 PID: 1 at fs/proc/generic.c:330
proc_register+0xc8/0x13c
[    4.364434] proc_dir_entry 'asound/pcm' already registered
[    4.369982] Modules linked in:
[    4.373083] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.13.0-rc6-next-20170824 #49
[    4.381887] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    4.388433] Backtrace:
[    4.390918] [<c010ca24>] (dump_backtrace) from [<c010ccf4>]
(show_stack+0x18/0x1c)
[    4.398512]  r7:00000000 r6:60000013 r5:00000000 r4:c0e79b80
[    4.404196] [<c010ccdc>] (show_stack) from [<c09ca560>]
(dump_stack+0xb4/0xe8)
[    4.411443] [<c09ca4ac>] (dump_stack) from [<c0125654>] (__warn+0xd8/0x104)
[    4.418430]  r9:c029892c r8:0000014a r7:00000009 r6:c0c06374
r5:00000000 r4:ec069b48
[    4.426196] [<c012557c>] (__warn) from [<c01256bc>]
(warn_slowpath_fmt+0x3c/0x44)
[    4.433703]  r9:ec338f2c r8:00000000 r7:ec338f00 r6:00000001
r5:ec88c480 r4:c0c06404
[    4.441470] [<c0125684>] (warn_slowpath_fmt) from [<c029892c>]
(proc_register+0xc8/0x13c)
[    4.449668]  r3:ec338f7d r2:c0c06404
[    4.453263]  r4:ec12c874
[    4.455822] [<c0298864>] (proc_register) from [<c0298c64>]
(proc_create_data+0x80/0xc4)
[    4.463850]  r10:ec8c8000 r9:00000001 r8:00000000 r7:ec138000
r6:ec88c3c0 r5:c0a900f0
[    4.471698]  r4:ec88c480
[    4.474261] [<c0298be4>] (proc_create_data) from [<c075456c>]
(snd_info_register+0x6c/0xd4)
[    4.482632]  r5:ec338f00 r4:ec88c3c0
[    4.486234] [<c0754500>] (snd_info_register) from [<c07590ac>]
(snd_pcm_new_stream+0x15c/0x454)
[    4.494953]  r5:ec145800 r4:00000000
[    4.498552] [<c0758f50>] (snd_pcm_new_stream) from [<c0759a6c>]
(_snd_pcm_new+0xcc/0x13c)
[    4.506753]  r10:00000000 r9:00000000 r8:00000001 r7:ec138000
r6:ec069ca4 r5:00000000
[    4.514601]  r4:ec145800
[    4.517159] [<c07599a0>] (_snd_pcm_new) from [<c0759afc>]
(snd_pcm_new+0x20/0x28)
[    4.524665]  r10:ec069ca8 r9:00000001 r8:ec132c80 r7:00000000
r6:ec8a9a0c r5:00000001
[    4.532513]  r4:00000001 r3:00000001
[    4.536112] [<c0759adc>] (snd_pcm_new) from [<c0777c0c>]
(soc_new_pcm+0x12c/0x45c)
[    4.543700]  r4:ec144800
[    4.546260] [<c0777ae0>] (soc_new_pcm) from [<c076b658>]
(snd_soc_register_card+0xc40/0xe38)
[    4.554721]  r10:ec144800 r9:ec8cd810 r8:00000002 r7:ec8cd898
r6:ec8cd9d4 r5:ec8cd978
[    4.562569]  r4:c0c8dcb8
[    4.565129] [<c076aa18>] (snd_soc_register_card) from [<c0778474>]
(devm_snd_soc_register_card+0x38/0x78)
[    4.574719]  r10:ec224400 r9:ec8cd810 r8:c0aaf308 r7:ec284c10
r6:ec8cd898 r5:ec89b150
[    4.582567]  r4:ec8cd898
[    4.585132] [<c077843c>] (devm_snd_soc_register_card) from
[<c07913a4>] (imx_wm8962_probe+0x244/0x37c)
[    4.594460]  r7:ef7d9650 r6:ec284c10 r5:ec284c00 r4:ec8cd898
[    4.600146] [<c0791160>] (imx_wm8962_probe) from [<c0546780>]
(platform_drv_probe+0x54/0xb8)
[    4.608607]  r10:00000000 r9:00000000 r8:c0e70228 r7:fffffdfb
r6:c0e70228 r5:ec284c10
[    4.616455]  r4:ec284c10
[    4.619019] [<c054672c>] (platform_drv_probe) from [<c0544bf4>]
(driver_probe_device+0x274/0x2fc)
[    4.627913]  r7:c15e6c10 r6:00000000 r5:c15e6c0c r4:ec284c10
[    4.633600] [<c0544980>] (driver_probe_device) from [<c0544d44>]
(__driver_attach+0xc8/0xcc)
[    4.642062]  r10:c0d00618 r9:c0d6089c r8:00000000 r7:00000000
r6:ec284c44 r5:c0e70228
[    4.649910]  r4:ec284c10 r3:00000000
[    4.653512] [<c0544c7c>] (__driver_attach) from [<c0542ebc>]
(bus_for_each_dev+0x74/0xa8)
[    4.661711]  r7:00000000 r6:c0544c7c r5:c0e70228 r4:00000000
[    4.667397] [<c0542e48>] (bus_for_each_dev) from [<c0544530>]
(driver_attach+0x20/0x28)
[    4.675421]  r6:c0e3b288 r5:ec132300 r4:c0e70228
[    4.680064] [<c0544510>] (driver_attach) from [<c054402c>]
(bus_add_driver+0x190/0x218)
[    4.688093] [<c0543e9c>] (bus_add_driver) from [<c05456e4>]
(driver_register+0x80/0x100)
[    4.696206]  r7:c0cf5ec4 r6:c0d60894 r5:c0d4e44c r4:c0e70228
[    4.701889] [<c0545664>] (driver_register) from [<c05466d4>]
(__platform_driver_register+0x38/0x4c)
[    4.710954]  r5:c0d4e44c r4:ffffe000
[    4.714558] [<c054669c>] (__platform_driver_register) from
[<c0d4e464>] (imx_wm8962_driver_init+0x18/0x20)
[    4.724239] [<c0d4e44c>] (imx_wm8962_driver_init) from [<c0101c54>]
(do_one_initcall+0x44/0x17c)
[    4.733053] [<c0101c10>] (do_one_initcall) from [<c0d00e7c>]
(kernel_init_freeable+0x118/0x1d0)
[    4.741774]  r8:000000f1 r7:c0cf5ec4 r6:c0d60894 r5:c0e7d000 r4:c0d710e0
[    4.748502] [<c0d00d64>] (kernel_init_freeable) from [<c09de898>]
(kernel_init+0x10/0x118)
[    4.756789]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c09de888
[    4.764637]  r4:00000000
[    4.767197] [<c09de888>] (kernel_init) from [<c01080f8>]
(ret_from_fork+0x14/0x3c)
[    4.774787]  r5:c09de888 r4:00000000
[    4.778454] ---[ end trace 3ea29ef261f4780d ]---
