From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: New snd-hda warning spew
Date: Tue, 15 Mar 2016 18:02:07 +0200
Message-ID: <20160315160207.GY4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B8842654D5
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 17:03:07 +0100 (CET)
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We have a few new WARN spews from snd-hda causing some grief in i915 CI.

This one happens on ILK and BYT. Looks like it happens 100% of the time on =
driver load:
[   18.809850] ------------[ cut here ]------------
[   18.809866] WARNING: CPU: 0 PID: 39 at sound/hda/hdac_i915.c:129 pin2por=
t+0x25/0x30 [snd_hda_core]()
[   18.809869] Modules linked in: ax88179_178a usbnet mii intel_powerclamp =
coretemp crct10dif_pclmul i915 snd_hda_codec_hdmi snd_hda_codec_generic crc=
32_pclmul ghash_clmulni_intel snd_hda_intel snd_hda_codec snd_hwdep snd_hda=
_core snd_pcm mei_me mei lpc_ich sdhci_pci sdhci mmc_core e1000e ptp pps_co=
re
[   18.809903] CPU: 0 PID: 39 Comm: kworker/0:1 Not tainted 4.5.0-gfxbench+=
 #1
[   18.809905] Hardware name: Hewlett-Packard HP EliteBook 8440p/172A, BIOS=
 68CCU Ver. F.24 09/13/2013
[   18.809912] Workqueue: events azx_probe_work [snd_hda_intel]
[   18.809915]  0000000000000000 ffff8800b646b9e8 ffffffff813fef15 00000000=
00000000
[   18.809920]  ffffffffa00f277c ffff8800b646ba20 ffffffff81078a21 ffff8800=
b2436000
[   18.809924]  ffff8800b24755e8 ffff8800b24755f0 0000000000000100 ffff8800=
aed08330
[   18.809929] Call Trace:
[   18.809936]  [<ffffffff813fef15>] dump_stack+0x67/0x92
[   18.809942]  [<ffffffff81078a21>] warn_slowpath_common+0x81/0xc0
[   18.809945]  [<ffffffff81078b15>] warn_slowpath_null+0x15/0x20
[   18.809953]  [<ffffffffa00f12d5>] pin2port+0x25/0x30 [snd_hda_core]
[   18.809960]  [<ffffffffa00f1378>] snd_hdac_acomp_get_eld+0x38/0x70 [snd_=
hda_core]
[   18.809966]  [<ffffffffa017da52>] hdmi_present_sense+0x92/0x370 [snd_hda=
_codec_hdmi]
[   18.809971]  [<ffffffffa017e0ff>] generic_hdmi_build_controls+0x11f/0x20=
0 [snd_hda_codec_hdmi]
[   18.809985]  [<ffffffffa01105b1>] snd_hda_codec_build_controls+0x191/0x1=
d0 [snd_hda_codec]
[   18.809993]  [<ffffffffa0110881>] ? snd_hda_codec_build_pcms+0xe1/0x1a0 =
[snd_hda_codec]
[   18.809999]  [<ffffffffa010b442>] hda_codec_driver_probe+0x82/0x100 [snd=
_hda_codec]
[   18.810005]  [<ffffffff8153d729>] driver_probe_device+0x229/0x450
[   18.810008]  [<ffffffff8153da7d>] __device_attach_driver+0x6d/0x80
[   18.810011]  [<ffffffff8153da10>] ? driver_allows_async_probing+0x30/0x30
[   18.810015]  [<ffffffff8153b4b8>] bus_for_each_drv+0x58/0x90
[   18.810018]  [<ffffffff8153d3c8>] __device_attach+0xb8/0x130
[   18.810022]  [<ffffffff8153dc0e>] device_initial_probe+0xe/0x10
[   18.810025]  [<ffffffff8153c76e>] bus_probe_device+0x9e/0xb0
[   18.810028]  [<ffffffff8153a5a1>] device_add+0x421/0x5f0
[   18.810035]  [<ffffffff817c2599>] ? mutex_unlock+0x9/0x10
[   18.810041]  [<ffffffffa00eba7f>] snd_hdac_device_register+0xf/0x40 [snd=
_hda_core]
[   18.810048]  [<ffffffffa010b1f6>] snd_hda_codec_configure+0x36/0x180 [sn=
d_hda_codec]
[   18.810057]  [<ffffffffa01150c3>] azx_codec_configure+0x23/0x40 [snd_hda=
_codec]
[   18.810062]  [<ffffffffa0134707>] azx_probe_work+0x567/0x870 [snd_hda_in=
tel]
[   18.810067]  [<ffffffff81093c8b>] process_one_work+0x1cb/0x680
[   18.810070]  [<ffffffff81093c06>] ? process_one_work+0x146/0x680
[   18.810073]  [<ffffffff81094189>] worker_thread+0x49/0x490
[   18.810076]  [<ffffffff81094140>] ? process_one_work+0x680/0x680
[   18.810081]  [<ffffffff8109a87a>] kthread+0xea/0x100
[   18.810085]  [<ffffffff817c5407>] ? _raw_spin_unlock_irq+0x27/0x50
[   18.810090]  [<ffffffff8109a790>] ? kthread_create_on_node+0x1f0/0x1f0
[   18.810093]  [<ffffffff817c60bf>] ret_from_fork+0x3f/0x70
[   18.810097]  [<ffffffff8109a790>] ? kthread_create_on_node+0x1f0/0x1f0
[   18.810277] ---[ end trace 2d4983bcfed2cd4b ]---

This other one was seen at least on on SKL:
[  124.808525] ------------[ cut here ]------------
[  124.808545] WARNING: CPU: 3 PID: 173 at sound/hda/hdac_i915.c:91 snd_hda=
c_display_power+0xf1/0x110 [snd_hda_core]()
[  124.808551] Modules linked in: snd_hda_codec_hdmi snd_hda_codec_realtek =
snd_hda_codec_generic x86_pkg_temp_thermal intel_powerclamp coretemp i915 c=
rct10dif_pclmul snd_hda_intel crc32_pclmul snd_hda_codec ghash_clmulni_inte=
l snd_hwdep snd_hda_core snd_pcm mei_me mei i2c_hid sdhci_pci e1000e ptp sd=
hci pps_core mmc_core
[  124.808603] CPU: 3 PID: 173 Comm: kworker/3:2 Tainted: G        W       =
4.5.0-gfxbench+ #1
[  124.808608] Hardware name:                  /NUC6i5SYB, BIOS SYSKLi35.86=
A.0028.2015.1112.1822 11/12/2015
[  124.808616] Workqueue: pm pm_runtime_work
[  124.808639]  0000000000000000 ffff88026423fbb8 ffffffff813fef15 00000000=
00000000
[  124.808644]  ffffffffa00f877c ffff88026423fbf0 ffffffff81078a21 00000000=
00000000
[  124.808648]  ffff880085a11148 ffff880085586ab8 ffff8800861b8000 00000000=
00000000
[  124.808652] Call Trace:
[  124.808656]  [<ffffffff813fef15>] dump_stack+0x67/0x92
[  124.808660]  [<ffffffff81078a21>] warn_slowpath_common+0x81/0xc0
[  124.808662]  [<ffffffff81078b15>] warn_slowpath_null+0x15/0x20
[  124.808668]  [<ffffffffa00f77e1>] snd_hdac_display_power+0xf1/0x110 [snd=
_hda_core]
[  124.808673]  [<ffffffffa015039d>] azx_intel_link_power+0xd/0x10 [snd_hda=
_intel]
[  124.808680]  [<ffffffffa011e32a>] azx_link_power+0x1a/0x30 [snd_hda_code=
c]
[  124.808684]  [<ffffffffa00f21f9>] snd_hdac_link_power+0x29/0x40 [snd_hda=
_core]
[  124.808690]  [<ffffffffa01192a6>] hda_codec_runtime_suspend+0x76/0xa0 [s=
nd_hda_codec]
[  124.808697]  [<ffffffffa0119230>] ? hda_codec_runtime_resume+0x50/0x50 [=
snd_hda_codec]
[  124.808701]  [<ffffffff8154719d>] __rpm_callback+0x2d/0x70
[  124.808704]  [<ffffffff815471ff>] rpm_callback+0x1f/0x80
[  124.808710]  [<ffffffffa0119230>] ? hda_codec_runtime_resume+0x50/0x50 [=
snd_hda_codec]
[  124.808713]  [<ffffffff81547764>] rpm_suspend+0x134/0x7f0
[  124.808716]  [<ffffffff810c80a9>] ? __lock_is_held+0x49/0x70
[  124.808719]  [<ffffffff81548129>] rpm_idle+0x209/0x530
[  124.808722]  [<ffffffff815494f9>] pm_runtime_work+0xa9/0xc0
[  124.808725]  [<ffffffff81093c8b>] process_one_work+0x1cb/0x680
[  124.808728]  [<ffffffff81093c06>] ? process_one_work+0x146/0x680
[  124.808731]  [<ffffffff81094189>] worker_thread+0x49/0x490
[  124.808733]  [<ffffffff81094140>] ? process_one_work+0x680/0x680
[  124.808735]  [<ffffffff81094140>] ? process_one_work+0x680/0x680
[  124.808738]  [<ffffffff8109a87a>] kthread+0xea/0x100
[  124.808742]  [<ffffffff817c53d7>] ? _raw_spin_unlock_irq+0x27/0x50
[  124.808745]  [<ffffffff8109a790>] ? kthread_create_on_node+0x1f0/0x1f0
[  124.808749]  [<ffffffff817c607f>] ret_from_fork+0x3f/0x70
[  124.808752]  [<ffffffff8109a790>] ? kthread_create_on_node+0x1f0/0x1f0
[  124.808755] ---[ end trace 2b97e417eb08d213 ]---

-- =

Ville Syrj=E4l=E4
Intel OTC
