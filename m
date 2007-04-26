From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [ASoC] list corruption during AC97 registration
Date: Thu, 26 Apr 2007 19:16:43 +0200
Message-ID: <20070426171643.GA27510@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 8952824733
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2007 19:16:44 +0200 (CEST)
Content-Disposition: inline
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
Cc: lg@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi Folks,

I hit the following oops (on 2.6.21) when ASoC registers an AC97 codec.
Happens both on MIPS and SH, for example the mips oops:

asoc: AC97 HiFi <-> au1xpsc-ac97-1 mapping ok
list_add corruption. prev->next should be next (80488f60), but was 865ffad8. (prev=865ffad8).
<snip> 
Call Trace:
[<80271290>] __list_add+0x68/0x94
[<802ac0e4>] bus_attach_device+0x48/0x78
[<802aa4c4>] device_add+0x3d8/0x844
[<c00882a8>] snd_soc_register_card+0x1d0/0x2c8 [snd_soc_core]
[<c00b3268>] ac97_soc_probe+0x17c/0x1e4 [snd_soc_ac97]
[<c0088f48>] soc_probe+0xb0/0x1ac [snd_soc_core]
[<802ad410>] really_probe+0x148/0x268
[<802ac1cc>] bus_for_each_drv+0x50/0xa0
[<802ad758>] device_attach+0xe4/0x194
[<802ac0cc>] bus_attach_device+0x30/0x78
[<802aa4c4>] device_add+0x3d8/0x844
[<802aff24>] platform_device_add+0x13c/0x198
[<c00b71c8>] exm1200_mobo_ac97_init+0x1c8/0x1fc [snd_soc_exmmb_ac97]
[<801478d0>] sys_init_module+0x1448/0x15b8
[<8010bcc0>] stack_done+0x20/0x3c

System.map says:
80488e60 D ac97_bus_type

As I said, it happens on both MIPS and SH (with machine and PCM drivers
written by myself). With CONFIG_DEBUG_LIST disabled the code works and plays
sound, but still I'd like to know what causes this list corruption.

Thanks for any hints!

-- 
 Manuel Lauss
