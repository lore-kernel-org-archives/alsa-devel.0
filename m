From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: snd_array_free - snd: bad kfree when HDA reconfig
Date: Fri, 2 Sep 2011 15:16:28 +0800
Message-ID: <CAN8cciZcDYzWdLZxGZQH40Q2Vi2+7D3oNpk48Jw=X7n-Q5Tvwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E391F10387F
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 09:16:28 +0200 (CEST)
Received: by fxh10 with SMTP id 10so1434995fxh.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Sep 2011 00:16:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

These errors "snd: bad kfree" occur when reconfig HDA from model
"6stack-dig-fp" to "auto" and vice versa

Is "HD-Audio reconfiguration" still experimental ?

BTW, it seem that HDA Digital PCBeep assigned to different input after
each reconfig

input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input7
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input8
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input9


aplay -l
card 1: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 1: AD198x Digital [AD198x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 2: AD198x Headphone [AD198x Headphone]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


echo "auto" > /sys/class/sound/hwC1D0/modelname
echo 1 > /sys/class/sound/hwC1D0/reconfig


aplay -l
card 1: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 1: AD198x Digital [AD198x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


echo "6stack-dig-fp" > /sys/class/sound/hwC1D0/modelname
echo 1 > /sys/class/sound/hwC1D0/reconfig

aplay -l
card 1: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 1: AD198x Digital [AD198x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Intel [HDA Intel], device 2: AD198x Headphone [AD198x Headphone]
  Subdevices: 1/1
  Subdevice #0: subdevice #0







ALSA hda_hwdep.c:220: hda-codec: reconfiguring
snd: bad kfree (called from f8be4636)
Pid: 8079, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be807e>] snd_hda_ctls_clear+0x35/0x45 [snd_hda_codec]
 [<f8be8180>] snd_hda_codec_reset+0xf2/0x250 [snd_hda_codec]
 [<f8959ab8>] ? __snd_printk+0x33/0x3c [snd]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<f8bec6bf>] reconfig_store+0x3e/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================
snd: bad kfree (called from f8be4636)
Pid: 8079, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be8089>] snd_hda_ctls_clear+0x40/0x45 [snd_hda_codec]
 [<f8be8180>] snd_hda_codec_reset+0xf2/0x250 [snd_hda_codec]
 [<f8959ab8>] ? __snd_printk+0x33/0x3c [snd]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<f8bec6bf>] reconfig_store+0x3e/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================
snd: bad kfree (called from f8be4636)
Pid: 8079, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be81de>] snd_hda_codec_reset+0x150/0x250 [snd_hda_codec]
 [<f8959ab8>] ? __snd_printk+0x33/0x3c [snd]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<f8bec6bf>] reconfig_store+0x3e/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================
snd: bad kfree (called from f8be4636)
Pid: 8079, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be81e9>] snd_hda_codec_reset+0x15b/0x250 [snd_hda_codec]
 [<f8959ab8>] ? __snd_printk+0x33/0x3c [snd]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<f8bec6bf>] reconfig_store+0x3e/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================
ALSA hda_codec.c:3961: hda_codec: model 'auto' is selected
ALSA hda_codec.c:4900: autoconfig: line_outs=4
(0x12/0x16/0x24/0x25/0x0) type:line
ALSA hda_codec.c:4904:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4908:    hp_outs=1 (0x11/0x0/0x0/0x0/0x0)
ALSA hda_codec.c:4909:    mono: mono_out=0x0
ALSA hda_codec.c:4912:    dig-out=0x1b/0x0
ALSA hda_codec.c:4913:    inputs:<7>ALSA hda_codec.c:4917:  Front
Mic=0x14<7>ALSA hda_codec.c:4917:  Rear Mic=0x17<7>ALSA
hda_codec.c:4917:  Line=0x15<7>ALSA hda_codec.c:4917:  CD=0x18<7>ALSA
hda_codec.c:4919:
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input8
ALSA hda_codec.c:2370: Cannot find slave Mono Playback Volume, skipped
ALSA hda_codec.c:2370: Cannot find slave Speaker Playback Volume, skipped
ALSA hda_codec.c:2370: Cannot find slave Mono Playback Switch, skipped
ALSA hda_codec.c:2370: Cannot find slave Speaker Playback Switch, skipped
snd: bad kfree (called from f8be4636)
Pid: 8079, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8b79d29>] ad198x_free_kctls+0x37/0x3c [snd_hda_codec_analog]
 [<f8b7ad5a>] ad198x_build_controls+0x190/0x217 [snd_hda_codec_analog]
 [<f8be7481>] snd_hda_codec_build_controls+0x31/0x3d [snd_hda_codec]
 [<f8bec704>] reconfig_store+0x83/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================



ALSA hda_hwdep.c:220: hda-codec: reconfiguring
snd: bad kfree (called from f8be4636)
Pid: 8201, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be807e>] snd_hda_ctls_clear+0x35/0x45 [snd_hda_codec]
 [<f8be8180>] snd_hda_codec_reset+0xf2/0x250 [snd_hda_codec]
 [<f8959ab8>] ? __snd_printk+0x33/0x3c [snd]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<f8bec6bf>] reconfig_store+0x3e/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================
snd: bad kfree (called from f8be4636)
Pid: 8201, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be8089>] snd_hda_ctls_clear+0x40/0x45 [snd_hda_codec]
 [<f8be8180>] snd_hda_codec_reset+0xf2/0x250 [snd_hda_codec]
 [<f8959ab8>] ? __snd_printk+0x33/0x3c [snd]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<f8bec6bf>] reconfig_store+0x3e/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================
snd: bad kfree (called from f8be4636)
Pid: 8201, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be81de>] snd_hda_codec_reset+0x150/0x250 [snd_hda_codec]
 [<f8959ab8>] ? __snd_printk+0x33/0x3c [snd]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<f8bec6bf>] reconfig_store+0x3e/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================
snd: bad kfree (called from f8be4636)
Pid: 8201, comm: bash Not tainted 2.6.27.41-170.2.117.fc10.i686 #1
 [<c06aa30b>] ? printk+0xf/0x14
 [<f895523e>] snd_hidden_kfree+0x2a/0x70 [snd]
 [<f8be4636>] ? snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be4636>] snd_array_free+0xe/0x25 [snd_hda_codec]
 [<f8be81e9>] snd_hda_codec_reset+0x15b/0x250 [snd_hda_codec]
 [<f8959ab8>] ? __snd_printk+0x33/0x3c [snd]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<f8bec6bf>] reconfig_store+0x3e/0xab [snd_hda_codec]
 [<f8bec681>] ? reconfig_store+0x0/0xab [snd_hda_codec]
 [<c0594ee1>] dev_attr_store+0x1b/0x23
 [<c04ce68a>] sysfs_write_file+0xb4/0xdf
 [<c04ce5d6>] ? sysfs_write_file+0x0/0xdf
 [<c04932ee>] vfs_write+0x84/0xdf
 [<c04933e2>] sys_write+0x3b/0x60
 [<c0404c8a>] syscall_call+0x7/0xb
 =======================
ALSA hda_codec.c:3961: hda_codec: model '6stack-dig-fp' is selected
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input9
