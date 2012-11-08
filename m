From: Misael Lopez <misael.lopez@ti.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
 by codec
Date: Thu, 8 Nov 2012 12:18:26 -0600
Message-ID: <509BF772.7010607@ti.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
 <505BE5BB.5010008@st.com> <5098E929.7040404@st.com>
 <20121106114323.GD10080@opensource.wolfsonmicro.com>
 <5099F265.6010008@st.com>
 <20121107145606.GJ20844@opensource.wolfsonmicro.com>
 <509B3501.6040807@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 29E28261576
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2012 19:18:27 +0100 (CET)
In-Reply-To: <509B3501.6040807@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Rajeev,

On 11/07/2012 10:28 PM, Rajeev kumar wrote:
<snip>

> Unable to handle kernel NULL pointer dereference at virtual address
> 00000008
> pgd = bd470000
> [00000008] *pgd=3d43b831, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#1] SMP ARM
> Modules linked in:
> CPU: 1    Not tainted  (3.5.0-lsp-3.3.0-rc1 #5)
> PC is at snd_soc_dapm_shutdown+0x48/0x11c
> LR is at snd_soc_poweroff+0x68/0x70
> pc : [<80372438>]    lr : [<8036ccf4>]    psr: 00000013
> sp : bd5bbd98  ip : bd5bbdc8  fp : bd5bbdc4
> r10: 806a6048  r9 : 8044e200  r8 : bd5bbd98
> r7 : 807260c4  r6 : bebceec8  r5 : ffffffec  r4 : bebcee08
> r3 : 00000000  r2 : bebcec10  r1 : 00000000  r0 : 807260c4
> Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 10c53c7d  Table: 3d47004a  DAC: 00000015
> Process disk.sh (pid: 1932, stack limit = 0xbd5ba2f0)
> Stack: (0xbd5bbd98 to 0xbd5bc000)
> bd80:                                                       bd5bbd98
> bd5bbd98
> bda0: bd5bbdc4 807260c4 000016b0 00000004 00000000 8024397c bd5bbde4
> bd5bbdc8
> bdc0: 8036ccf4 803723fc 8036cc8c be9b2808 be9b2808 00000000 bd5bbdf4
> bd5bbde8
> bde0: 802439bc 8036cc98 bd5bbe2c bd5bbdf8 80247a28 80243988 80435b80
> 8008fc18
> be00: 00000000 00000000 bd5bbe2c be9b2808 00000004 be9b283c 8072359c
> 00000004
> be20: bd5bbe54 bd5bbe30 80248564 802479f8 806a5c98 009b2880 be9b2880
> 00000000
> be40: 806a6008 be9b2808 bd5bbe8c bd5bbe58 80248dac 80248450 3a87fb94
> 00000023
> be60: 3a87fb94 00000023 00000004 806f6e58 00000004 00000005 be863e00
> bd4a2918
> be80: bd5bbea4 bd5bbe90 80249144 80248cfc 00000001 00000000 bd5bbebc
> bd5bbea8
> bea0: 800590a8 802490e4 00000000 806953ac bd5bbed4 bd5bbec0 800592dc
> 8005906c
> bec0: bde8b000 be863f00 bd5bbefc bd5bbed8 80057444 80059194 00000005
> be863f00
> bee0: bd4a2900 bd5bbf70 be863e00 bd4a2918 bd5bbf0c bd5bbf00 801e5e18
> 80057394
> bf00: bd5bbf3c bd5bbf10 80124f18 801e5e08 bd5bbf70 00000005 bdcd9300
> 76fc6000
> bf20: bd5bbf70 00000000 00000000 00000000 bd5bbf6c bd5bbf40 800cf8b0
> 80124e0c
> bf40: 00000000 bde7b500 00000003 bdcd9300 76fc6000 00000005 00000004
> 00000000
> bf60: bd5bbfa4 bd5bbf70 800cfb2c 800cf7f8 00000000 00000000 00000005
> 00000000
> bf80: 00000004 76f87628 00000005 76fc6000 8000e088 bd5ba000 00000000
> bd5bbfa8
> bfa0: 8000dde0 800cfaec 76f87628 00000005 00000001 76fc6000 00000005
> 00000000
> bfc0: 76f87628 00000005 76fc6000 00000004 00000005 76fc74c0 000b0094
> 0005dae8
> bfe0: 00000005 7e8df7c8 76ed713c 76f1fafc 60000010 00000001 3fffe821
> 3fffec21
> [<80372438>] (snd_soc_dapm_shutdown+0x48/0x11c) from [<8036ccf4>]
> (snd_soc_poweroff+0x68/0x70)
> [<8036ccf4>] (snd_soc_poweroff+0x68/0x70) from [<802439bc>]
> (platform_pm_poweroff+0x40/0x58)
> [<802439bc>] (platform_pm_poweroff+0x40/0x58) from [<80247a28>]
> (dpm_run_callback.isra.12+0x3c/0x74)
> [<80247a28>] (dpm_run_callback.isra.12+0x3c/0x74) from [<80248564>]
> (__device_suspend+0x120/0x194)
> [<80248564>] (__device_suspend+0x120/0x194) from [<80248dac>]
> (dpm_suspend+0xbc/0x224)
> [<80248dac>] (dpm_suspend+0xbc/0x224) from [<80249144>]
> (dpm_suspend_start+0x6c/0x74)
> [<80249144>] (dpm_suspend_start+0x6c/0x74) from [<800590a8>]
> (hibernation_platform_enter+0x48/0x128)
> [<800590a8>] (hibernation_platform_enter+0x48/0x128) from [<800592dc>]
> (hibernate+0x154/0x21c)
> [<800592dc>] (hibernate+0x154/0x21c) from [<80057444>]
> (state_store+0xbc/0xd0)
> [<80057444>] (state_store+0xbc/0xd0) from [<801e5e18>]
> (kobj_attr_store+0x1c/0x28)
> [<801e5e18>] (kobj_attr_store+0x1c/0x28) from [<80124f18>]
> (sysfs_write_file+0x118/0x14c)
> [<80124f18>] (sysfs_write_file+0x118/0x14c) from [<800cf8b0>]
> (vfs_write+0xc4/0x140)
> [<800cf8b0>] (vfs_write+0xc4/0x140) from [<800cfb2c>] (sys_write+0x4c/0x78)
> [<800cfb2c>] (sys_write+0x4c/0x78) from [<8000dde0>]
> (ret_fast_syscall+0x0/0x48)
> Code: e59350f8 e3a03000 e2455014 ea00000f (e595201c)
> ================================================================================================


The backtrace doesn't seem to point directly to codec's shutdown but
system's. There is a problem in the way the card's codec list is
traversed to perform the shutdown, please see [1]. Take a look at that
patch, it might help with this kernel crash.

Regards,
-Misa

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-November/056846.html
