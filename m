From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: BUG: double free of PCM structure upon module removal
Date: Tue, 23 May 2017 18:46:58 +0200
Message-ID: <87k2571px9.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 by alsa0.perex.cz (Postfix) with ESMTP id A49ED267111
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 18:47:00 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Mark,

I've encoutered a double free on my platform with the last mainline kernel.

The devm_card_release() call makes a double free in my platform configuration.

This double release is a PCM free, ie. a soc_free_pcm_runtime() is called and
then soc_pcm_free() is called on the same PCM.

The call stack as far as I could tell is :
 - devm_card_release()
   snd_soc_unregister_card()
     soc_remove_pcm_runtimes()
       soc_free_pcm_runtime() ===> first release
     ...
     snd_card_free()
       snd_card_free_when_closed()
         put_device()
	   release_card_device()
	     snd_device_free_all()
               __snd_device_free()
	         snd_pcm_dev_free()
		   snd_pcm_free() ===> second release

The issue is seen on the PXA platform, where the PCM is allocated in :
  sound/soc/pxa/pxa2xx-pcm.c, pxa2xx_soc_pcm_new()

Did you notice the same behavior on other platforms, and if not would you have a
hint why it happens to me ?

Cheers.

--
Robert

PS: The stacks I captured (with added WARN_ON() calls) :
================================================================
=============== Added warning for first pcm free ===============
================================================================
------------[ cut here ]------------

[ 4033.143750] RJK: soc_new_pcm_runtime() rtd=c307c000, rtd->card=bf025a08
[ 4033.153523] RJK: soc_new_pcm_runtime() rtd=c39cb800, rtd->card=bf025a08

[ 4036.674226] WARNING: CPU: 0 PID: 969 at sound/soc/soc-core.c:578 soc_free_pcm_runtime+0x28/0x6c
[ 4036.680894] Modules linked in: snd_soc_mioa701(-) snd_soc_pxa2xx snd_soc_pxa2xx_ac97 snd_soc_wm9713 snd_pxa2xx_lib snd_pcm_dmaengine regmap_ac97
[ 4036.691540] CPU: 0 PID: 969 Comm: rmmod Not tainted 4.12.0-rc2+ #35
[ 4036.698136] Hardware name: MIO A701
[ 4036.701883] [<c00125fc>] (unwind_backtrace) from [<c000eb58>] (show_stack+0x20/0x24)
[ 4036.708352] [<c000eb58>] (show_stack) from [<c0229274>] (dump_stack+0x20/0x28)
[ 4036.714974] [<c0229274>] (dump_stack) from [<c001d354>] (__warn+0xe8/0x114)
[ 4036.721680] [<c001d354>] (__warn) from [<c001d450>] (warn_slowpath_null+0x30/0x38)
[ 4036.728132] [<c001d450>] (warn_slowpath_null) from [<c03d0590>] (soc_free_pcm_runtime+0x28/0x6c)
[ 4036.734727] [<c03d0590>] (soc_free_pcm_runtime) from [<c03d0968>] (soc_remove_pcm_runtimes+0x70/0x94)
[ 4036.741435] [<c03d0968>] (soc_remove_pcm_runtimes) from [<c03d1cc0>] (snd_soc_unregister_card+0x5c/0xdc)
[ 4036.747840] [<c03d1cc0>] (snd_soc_unregister_card) from [<c03e1c84>] (devm_card_release+0x1c/0x20)
[ 4036.754415] [<c03e1c84>] (devm_card_release) from [<c02cfe18>] (release_nodes+0x1f0/0x228)
[ 4036.761125] [<c02cfe18>] (release_nodes) from [<c02d075c>] (devres_release_all+0x68/0x70)
[ 4036.767522] [<c02d075c>] (devres_release_all) from [<c02cc24c>] (device_release_driver_internal+0x170/0x204)
[ 4036.774064] [<c02cc24c>] (device_release_driver_internal) from [<c02cc3b4>] (driver_detach+0xb0/0xd0)
[ 4036.780703] [<c02cc3b4>] (driver_detach) from [<c02cb0a0>] (bus_remove_driver+0x9c/0xdc)
[ 4036.786995] [<c02cb0a0>] (bus_remove_driver) from [<c02ccbdc>] (driver_unregister+0x4c/0x58)
[ 4036.793449] [<c02ccbdc>] (driver_unregister) from [<c02ce270>] (platform_driver_unregister+0x1c/0x20)
[ 4036.799763] [<c02ce270>] (platform_driver_unregister) from [<bf025174>] (mioa701_wm9713_driver_exit+0x14/0x1c [snd_soc_mioa701])
[ 4036.809548] [<bf025174>] (mioa701_wm9713_driver_exit [snd_soc_mioa701]) from [<c0088a74>] (SyS_delete_module+0x194/0x220)
[ 4036.819840] [<c0088a74>] (SyS_delete_module) from [<c000a960>] (ret_fast_syscall+0x0/0x1c)
[ 4036.826896] ---[ end trace 6aefa683095edac5 ]---
[ 4036.830510] RJK: soc_free_pcm_runtime() rtd=c307c000, rtd->card=bf025a08
[ 4036.837138] ------------[ cut here ]------------
[ 4036.840936] WARNING: CPU: 0 PID: 969 at sound/soc/soc-core.c:578 soc_free_pcm_runtime+0x28/0x6c
[ 4036.847717] Modules linked in: snd_soc_mioa701(-) snd_soc_pxa2xx snd_soc_pxa2xx_ac97 snd_soc_wm9713 snd_pxa2xx_lib snd_pcm_dmaengine regmap_ac97
[ 4036.857917] CPU: 0 PID: 969 Comm: rmmod Tainted: G        W       4.12.0-rc2+ #35
[ 4036.864741] Hardware name: MIO A701
[ 4036.868164] [<c00125fc>] (unwind_backtrace) from [<c000eb58>] (show_stack+0x20/0x24)
[ 4036.875069] [<c000eb58>] (show_stack) from [<c0229274>] (dump_stack+0x20/0x28)
[ 4036.881999] [<c0229274>] (dump_stack) from [<c001d354>] (__warn+0xe8/0x114)
[ 4036.888630] [<c001d354>] (__warn) from [<c001d450>] (warn_slowpath_null+0x30/0x38)
[ 4036.895458] [<c001d450>] (warn_slowpath_null) from [<c03d0590>] (soc_free_pcm_runtime+0x28/0x6c)
[ 4036.902422] [<c03d0590>] (soc_free_pcm_runtime) from [<c03d0968>] (soc_remove_pcm_runtimes+0x70/0x94)
[ 4036.909100] [<c03d0968>] (soc_remove_pcm_runtimes) from [<c03d1cc0>] (snd_soc_unregister_card+0x5c/0xdc)
[ 4036.915941] [<c03d1cc0>] (snd_soc_unregister_card) from [<c03e1c84>] (devm_card_release+0x1c/0x20)
[ 4036.922900] [<c03e1c84>] (devm_card_release) from [<c02cfe18>] (release_nodes+0x1f0/0x228)
[ 4036.929603] [<c02cfe18>] (release_nodes) from [<c02d075c>] (devres_release_all+0x68/0x70)
[ 4036.936447] [<c02d075c>] (devres_release_all) from [<c02cc24c>] (device_release_driver_internal+0x170/0x204)
[ 4036.943404] [<c02cc24c>] (device_release_driver_internal) from [<c02cc3b4>] (driver_detach+0xb0/0xd0)
[ 4036.950059] [<c02cc3b4>] (driver_detach) from [<c02cb0a0>] (bus_remove_driver+0x9c/0xdc)
[ 4036.956876] [<c02cb0a0>] (bus_remove_driver) from [<c02ccbdc>] (driver_unregister+0x4c/0x58)
[ 4036.963793] [<c02ccbdc>] (driver_unregister) from [<c02ce270>] (platform_driver_unregister+0x1c/0x20)
[ 4036.970766] [<c02ce270>] (platform_driver_unregister) from [<bf025174>] (mioa701_wm9713_driver_exit+0x14/0x1c [snd_soc_mioa701])
[ 4036.981054] [<bf025174>] (mioa701_wm9713_driver_exit [snd_soc_mioa701]) from [<c0088a74>] (SyS_delete_module+0x194/0x220)
[ 4036.991323] [<c0088a74>] (SyS_delete_module) from [<c000a960>] (ret_fast_syscall+0x0/0x1c)
[ 4036.998052] ---[ end trace 6aefa683095edac6 ]---
[ 4037.001597] RJK: soc_free_pcm_runtime() rtd=c39cb800, rtd->card=bf025a08
------------[ cut here ]------------

================================================================
====================== Here comes the BUG ======================
================================================================

[ 4037.309613] RJK: soc_pcm_free() rtd=c39cb800, rtd->card=35343720
[ 4037.327993] Unable to handle kernel paging request at virtual address 35343848
[ 4037.334248] pgd = c3184000
[ 4037.337047] [35343848] *pgd=00000000
[ 4037.339722] Internal error: Oops: f5 [#1] PREEMPT ARM
[ 4037.342391] Modules linked in: snd_soc_mioa701(-) snd_soc_pxa2xx snd_soc_pxa2xx_ac97 snd_soc_wm9713 snd_pxa2xx_lib snd_pcm_dmaengine regmap_ac97
[ 4037.350342] CPU: 0 PID: 969 Comm: rmmod Tainted: G        W       4.12.0-rc2+ #35
[ 4037.355660] Hardware name: MIO A701
[ 4037.358383] task: c2871ae0 task.stack: c31f4000
[ 4037.361184] PC is at soc_pcm_free+0x38/0x80
[ 4037.364008] LR is at preempt_count_sub+0x3c/0x58
[ 4037.366807] pc : [<c03dcea8>]    lr : [<c0043494>]    psr: 60000013
[ 4037.366807] sp : c31f5cf8  ip : 00000000  fp : c31f5d14
[ 4037.374932] r10: 00000000  r9 : c02cf494  r8 : c287fa60
[ 4037.377654] r7 : c287f960  r6 : c2811000  r5 : c39cb800  r4 : c072b394
[ 4037.383037] r3 : 35343720  r2 : 35343720  r1 : c0059460  r0 : 00000034
[ 4037.388622] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 4037.394328] Control: 0000397f  Table: a3184000  DAC: 00000051
[ 4037.400110] Process rmmod (pid: 969, stack limit = 0xc31f4198)
[ 4037.406089] Stack: (0xc31f5cf8 to 0xc31f6000)
[ 4037.409177] 5ce0:                                                       c03dce70 c072b394
[ 4037.415346] 5d00: c2811000 c072b3a0 c31f5d34 c31f5d18 c03b0c7c c03dce7c c03b0e68 c287f120
[ 4037.421501] 5d20: c39cb190 c3181960 c31f5d44 c31f5d38 c03b0e84 c03b0c14 c31f5d5c c31f5d48
[ 4037.427649] 5d40: c03a9d28 c03b0e74 c03a5160 c336e060 c31f5d74 c31f5d60 c03a9f00 c03a9ce0
[ 4037.433829] 5d60: c39cb358 c39cb000 c31f5d8c c31f5d78 c03a5184 c03a9ed8 c39cb360 c39cb358
[ 4037.440010] 5d80: c31f5dac c31f5d90 c02c6264 c03a516c c02c61f8 c39cb360 c0721cd4 c07382f0
[ 4037.446202] 5da0: c31f5dd4 c31f5db0 c022ab8c c02c6204 c05cbbc0 c31f5dac c39cb358 c39cb000
[ 4037.452401] 5dc0: bf025ad0 c287f980 c31f5dec c31f5dd8 c02c70cc c022aa28 00020000 00000000
[ 4037.458590] 5de0: c31f5e04 c31f5df0 c03a57d4 c02c70a0 c31f5e0c c39cb000 c31f5e2c c31f5e08
[ 4037.464923] 5e00: c03a594c c03a57b4 bf025518 00000000 c31f5e10 c31f5e10 bf025518 bf025a08
[ 4037.471327] 5e20: c31f5e4c c31f5e30 c03d1d0c c03a5914 c03e1c68 c31f5e60 00000003 c06ef270
[ 4037.477748] 5e40: c31f5e5c c31f5e50 c03e1c84 c03d1c70 c31f5e94 c31f5e60 c02cfe18 c03e1c74
[ 4037.484180] 5e60: c287f9c0 c287f980 a0000013 c06ef270 a0000013 c0721f80 bf025bcc c0721fb4
[ 4037.490631] 5e80: c31f4000 00020000 c31f5eac c31f5e98 c02d075c c02cfc34 c06ef270 c06ef2a4
[ 4037.497192] 5ea0: c31f5ed4 c31f5eb0 c02cc24c c02d0700 00020000 c06ef270 bf025bcc c31f4000
[ 4037.503789] 5ec0: 00000081 c000ab28 c31f5ef4 c31f5ed8 c02cc3b4 c02cc0e8 00000000 bf025bcc
[ 4037.510424] 5ee0: beebd4a8 00000880 c31f5f0c c31f5ef8 c02cb0a0 c02cc310 bf025160 bf025bcc
[ 4037.517107] 5f00: c31f5f24 c31f5f10 c02ccbdc c02cb010 bf025160 bf025d40 c31f5f34 c31f5f28
[ 4037.523869] 5f20: c02ce270 c02ccb9c c31f5f44 c31f5f38 bf025174 c02ce260 c31f5fa4 c31f5f48
[ 4037.530706] 5f40: c0088a74 bf02516c 00001000 5f646e73 5f636f73 616f696d 00313037 c31f5f68
[ 4037.537553] 5f60: c00ed5cc c00514e4 c31f5f68 c31f5f68 c31f4000 007fd008 00000000 beebd4d0
[ 4037.544443] 5f80: beebd4a8 00000081 00000000 00000000 beebd4d0 beebd4a8 00000000 c31f5fa8
[ 4037.551358] 5fa0: c000a960 c00888ec 00000000 beebd4d0 beebd4a8 00000880 00000000 00000000
[ 4037.558280] 5fc0: 00000000 beebd4d0 beebd4a8 00000081 beebfcd0 beebfd10 00000880 beebfd44
[ 4037.565213] 5fe0: 00000000 beebd4a0 00009088 b6f2fbcc 60000010 beebd4a8 00000000 00000000
[ 4037.572210] [<c03dcea8>] (soc_pcm_free) from [<c03b0c7c>] (snd_pcm_free+0x74/0xa0)
[ 4037.579179] [<c03b0c7c>] (snd_pcm_free) from [<c03b0e84>] (snd_pcm_dev_free+0x1c/0x20)
[ 4037.586210] [<c03b0e84>] (snd_pcm_dev_free) from [<c03a9d28>] (__snd_device_free+0x54/0x7c)
[ 4037.593253] [<c03a9d28>] (__snd_device_free) from [<c03a9f00>] (snd_device_free_all+0x34/0x48)
[ 4037.600252] [<c03a9f00>] (snd_device_free_all) from [<c03a5184>] (release_card_device+0x24/0x7c)
[ 4037.607279] [<c03a5184>] (release_card_device) from [<c02c6264>] (device_release+0x6c/0xa4)
[ 4037.614304] [<c02c6264>] (device_release) from [<c022ab8c>] (kobject_put+0x170/0x1e0)
[ 4037.621295] [<c022ab8c>] (kobject_put) from [<c02c70cc>] (put_device+0x38/0x44)
[ 4037.628237] [<c02c70cc>] (put_device) from [<c03a57d4>] (snd_card_free_when_closed+0x2c/0x34)
[ 4037.635196] [<c03a57d4>] (snd_card_free_when_closed) from [<c03a594c>] (snd_card_free+0x44/0x68)
[ 4037.642125] [<c03a594c>] (snd_card_free) from [<c03d1d0c>] (snd_soc_unregister_card+0xa8/0xdc)
[ 4037.649044] [<c03d1d0c>] (snd_soc_unregister_card) from [<c03e1c84>] (devm_card_release+0x1c/0x20)
[ 4037.655995] [<c03e1c84>] (devm_card_release) from [<c02cfe18>] (release_nodes+0x1f0/0x228)
[ 4037.662917] [<c02cfe18>] (release_nodes) from [<c02d075c>] (devres_release_all+0x68/0x70)
[ 4037.669805] [<c02d075c>] (devres_release_all) from [<c02cc24c>] (device_release_driver_internal+0x170/0x204)
[ 4037.676678] [<c02cc24c>] (device_release_driver_internal) from [<c02cc3b4>] (driver_detach+0xb0/0xd0)
[ 4037.683522] [<c02cc3b4>] (driver_detach) from [<c02cb0a0>] (bus_remove_driver+0x9c/0xdc)
[ 4037.690308] [<c02cb0a0>] (bus_remove_driver) from [<c02ccbdc>] (driver_unregister+0x4c/0x58)
[ 4037.697092] [<c02ccbdc>] (driver_unregister) from [<c02ce270>] (platform_driver_unregister+0x1c/0x20)
[ 4037.703885] [<c02ce270>] (platform_driver_unregister) from [<bf025174>] (mioa701_wm9713_driver_exit+0x14/0x1c [snd_soc_mioa701])
[ 4037.714014] [<bf025174>] (mioa701_wm9713_driver_exit [snd_soc_mioa701]) from [<c0088a74>] (SyS_delete_module+0x194/0x220)
[ 4037.724128] [<c0088a74>] (SyS_delete_module) from [<c000a960>] (ret_fast_syscall+0x0/0x1c)
[ 4037.730848] Code: e59f104c ebf37450 e5952004 e1a03002 (e5b34128) 
[ 4037.738251] ---[ end trace 6aefa683095edac7 ]---

-- 
Robert
