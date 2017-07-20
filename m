From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: sgtl5000: add avc support
Date: Thu, 20 Jul 2017 14:11:42 -0300
Message-ID: <CAOMZO5Cx6OrYSKYcbj6DWhn=hzS51sENadWHLSYdTkjRk9qJXw@mail.gmail.com>
References: <1497337054-4911-1-git-send-email-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497337054-4911-1-git-send-email-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, kalle.kankare@vincit.fi, Eric Nelson <eric@nelint.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, dev@g0hl1n.net
List-Id: alsa-devel@alsa-project.org

Hi Richard,

On Tue, Jun 13, 2017 at 3:57 AM, Richard Leitner
<richard.leitner@skidata.com> wrote:
> The sgtl5000 features a automatic volume control block (AVC), which
> reduces loud signals and amplifies low level signals for easier
> listening. This patch adds support for this AVC block to the driver.
>
> Apart from the "AVC Switch" control which enables the block following
> controls for the configuration of AVC are added:
>         + AVC Threshold Volume: threshold where audio is compressed when
>                 the measured level is above or expanded when below
>         + AVC Max Gain Volume: maximum gain which can be applied when
>                 the measured audio level is below threshold
>         + AVC Hard Limiter Switch: when enabled the signal is limited to
>                 the programmed threshold.
>         + AVC Integrator Response: response time of the integrator
>
> The AVC block is enabled and configured using the DAP_AVC_CTRL and
> DAP_AVC_THRESHOLD registers.
>
> Following 2 checkpatch.pl strict checks are ignored because the
> indentation style is different for the struct snd_kcontrol_new
> definition:
>         patch:145: CHECK: Alignment should match open parenthesis
>         patch:148: CHECK: Alignment should match open parenthesis
>
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>

Running linux-next-20170720 on a imx53-qsb I get the following issue:

root@imx53qsb:~# reboot

Broadcast message from root@imx53qsb (ttymxc0) (Mon May 15 18:40:54 2017):
The system is going down for reboot NOW!
INIT: Switching to runlevel: 6
INIT: Sending processes the TERM signal
root@imx53qsb:~#  * Stopping Avahi mDNS/DNS-SD Daemon: avahi-daemon
   ...done.
Stopping bluetooth
/usr/libexec/bluetooth/bluetoothd
Stopping system message bus: dbus.
hwclock: can't open '/dev/misc/rtc': No such file or directory
Stopping syslogd/klogd: stopped syslogd (pid 278)
stopped klogd (pid 282)
done
Stopping Telephony daemon
ALSA: Storing mixer settings...
[   20.031604] Unable to handle kernel paging request at virtual
address fffffffe
[   20.039268] pgd = de2a0000
[   20.041999] [fffffffe] *pgd=8fffd861, *pte=00000000, *ppte=00000000
[   20.048387] Internal error: Oops: 80000007 [#1] SMP ARM
[   20.053626] Modules linked in:
[   20.056704] CPU: 0 PID: 331 Comm: alsactl Not tainted
4.13.0-rc1-next-20170720 #28
[   20.064280] Hardware name: Freescale i.MX53 (Device Tree Support)
[   20.070381] task: dfb12640 task.stack: ddcfa000
[   20.074922] PC is at 0xfffffffe
[   20.078083] LR is at snd_soc_component_read+0x34/0x40
[   20.083142] pc : [<fffffffe>]    lr : [<c0759b14>]    psr: a00f0033
[   20.089416] sp : ddcfbe60  ip : ddcfbe70  fp : ddcfbe6c
[   20.094648] r10: 00000000  r9 : de1cebf4  r8 : de1cef68
[   20.099880] r7 : becb9450  r6 : de2e4800  r5 : de1b9980  r4 : de2e4800
[   20.106416] r3 : ffffffff  r2 : ddcfbe74  r1 : 00000126  r0 : de1a9e40
[   20.112952] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb
Segment none
[   20.120268] Control: 10c5387d  Table: 8e2a0019  DAC: 00000051
[   20.126022] Process alsactl (pid: 331, stack limit = 0xddcfa210)
[   20.132036] Stack: (0xddcfbe60 to 0xddcfc000)
[   20.136406] be60: ddcfbe84 ddcfbe70 c0759bc8 c0759aec 00000001
00000000 ddcfbe9c ddcfbe88
[   20.144595] be80: c075e19c c0759bb8 0000000f de1b9980 ddcfbf0c
ddcfbea0 c07349fc c075e18c
[   20.152784] bea0: ffffe000 de280080 de280000 de280080 de280034
00000001 de280080 de280000
[   20.160973] bec0: ddcfbee4 ddcfbed0 c09c44a0 c0174d34 00000010
de280000 ddcfbf0c ddcfbee8
[   20.169161] bee0: c024bc0c becb9450 de1baf98 de221b40 c023d2e4
00000004 ddcfa000 00000000
[   20.177350] bf00: ddcfbf7c ddcfbf10 c023c8f0 c0734450 de221b40
de20d000 00000020 de221b48
[   20.185538] bf20: de1baf98 00000000 ddcfbf4c ddcfbf38 de221b40
de221b40 00000002 00000001
[   20.193727] bf40: 00000004 ddcfa000 ddcfbfa4 ddcfbf58 c023b500
de221b40 00000004 de221b40
[   20.201915] bf60: c2c85512 becb9450 ddcfa000 00000000 ddcfbfa4
ddcfbf80 c023d2e4 c023c860
[   20.210104] bf80: becb9338 00000000 becb9450 00000036 c0107f24
ddcfa000 00000000 ddcfbfa8
[   20.218292] bfa0: c0107d60 c023d2b4 becb9338 00000000 00000004
c2c85512 becb9450 01d22568
[   20.226481] bfc0: becb9338 00000000 becb9450 00000036 01d25328
becb9998 01d226c0 becb9f10
[   20.234670] bfe0: b6f8c41c becb931c b6f0b1d5 b6dde1a6 200f0030
00000004 8fffd861 8fffdc61
[   20.242852] Backtrace:
[   20.245318] [<c0759ae0>] (snd_soc_component_read) from [<c0759bc8>]
(snd_soc_read+0x1c/0x30)
[   20.253774] [<c0759bac>] (snd_soc_read) from [<c075e19c>]
(avc_get_threshold+0x1c/0x90)
[   20.261798] [<c075e180>] (avc_get_threshold) from [<c07349fc>]
(snd_ctl_ioctl+0x5b8/0xb38)
[   20.270069]  r5:de1b9980 r4:0000000f
[   20.273661] [<c0734444>] (snd_ctl_ioctl) from [<c023c8f0>]
(do_vfs_ioctl+0x9c/0xa54)
[   20.281415]  r10:00000000 r9:ddcfa000 r8:00000004 r7:c023d2e4
r6:de221b40 r5:de1baf98
[   20.289250]  r4:becb9450
[   20.291794] [<c023c854>] (do_vfs_ioctl) from [<c023d2e4>]
(SyS_ioctl+0x3c/0x64)
[   20.299114]  r10:00000000 r9:ddcfa000 r8:becb9450 r7:c2c85512
r6:de221b40 r5:00000004
[   20.306949]  r4:de221b40
[   20.309503] [<c023d2a8>] (SyS_ioctl) from [<c0107d60>]
(ret_fast_syscall+0x0/0x1c)
[   20.317083]  r9:ddcfa000 r8:c0107f24 r7:00000036 r6:becb9450
r5:00000000 r4:becb9338
[   20.325226] Code: bad PC value
[   20.328330] ---[ end trace 7d153a40b8b802a3 ]---


If I revert a729526720059ae ("ASoC: sgtl5000: add avc support") the
problem does not happen.

Could you please fix this issue?
