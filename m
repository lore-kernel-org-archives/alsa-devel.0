From: Timur Tabi <timur@freescale.com>
Subject: Need help with "BUG: key e69d3aac not in .data!"
Date: Thu, 10 Nov 2011 18:35:38 -0600
Message-ID: <4EBC6DDA.2010900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 28133103834
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 01:35:48 +0100 (CET)
Received: from mail82-ch1 (localhost.localdomain [127.0.0.1])	by
	mail82-ch1-R.bigfish.com (Postfix) with ESMTP id 5651813103E8	for
	<alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 00:35:32 +0000 (UTC)
Received: from CH1EHSMHS011.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.248])	by mail82-ch1.bigfish.com (Postfix) with ESMTP id
	E00AC167804B	for <alsa-devel@alsa-project.org>;
	Fri, 11 Nov 2011 00:35:29 +0000 (UTC)
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
	az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	pAB0Zdrb004198	for
	<alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 18:35:39 -0600 (CST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I turned on some mutex debugging options, and now I'm getting this in my audio driver:

Freescale Synchronous Serial Interface (SSI) ASoC Driver                        
BUG: key e69d3aac not in .data!                                                 
------------[ cut here ]------------                                            
WARNING: at /home/b04825/git/linux.10b/kernel/lockdep.c:2980                    
Modules linked in:                                                              
NIP: c0078160 LR: c0078148 CTR: 00000000                                        
REGS: e685dcd0 TRAP: 0700   Not tainted  (3.2.0-10b-00093-gebea711-dirty)       
MSR: 00029000 <EE,ME,CE>  CR: 22044042  XER: 20000000                           
TASK = e6860000[1] 'swapper' THREAD: e685c000 CPU: 0                            
GPR00: 00000000 e685dd80 e6860000 00000001 00000001 c0043824 00000000 00000002  
GPR08: 00000000 c0620000 00000001 00000000 22044042 40401800 00000000 00000000  
GPR16: c0000a00 00000014 3fffffff 03ff9000 00000015 7ff3a68c c061e000 00000000  
GPR24: 00000000 00000000 00001700 fffffff4 00000124 e6f9a3c0 c0620000 e6f9a3c8  
NIP [c0078160] lockdep_init_map+0x25c/0x468                                     
LR [c0078148] lockdep_init_map+0x244/0x468                                      
Call Trace:                                                                     
[e685dd80] [c0078138] lockdep_init_map+0x234/0x468 (unreliable)                 
[e685ddc0] [c0133740] sysfs_add_file_mode+0x98/0xf8                             
[e685ddf0] [c0277578] device_create_file+0x20/0x30                              
[e685de00] [c0462754] fsl_ssi_probe+0x284/0x410                                 
[e685deb0] [c027ba2c] platform_drv_probe+0x20/0x30                              
[e685dec0] [c027a4b0] driver_probe_device+0xa4/0x1d4                            
[e685dee0] [c027a6a4] __driver_attach+0xc4/0xc8                                 
[e685df00] [c027939c] bus_for_each_dev+0x60/0x9c                                
[e685df30] [c027a0e4] driver_attach+0x24/0x34                                   
[e685df40] [c0279d30] bus_add_driver+0x1b0/0x278                                
[e685df70] [c027aab8] driver_register+0x88/0x154                                
[e685df90] [c027bd5c] platform_driver_register+0x68/0x78                        
[e685dfa0] [c05d822c] fsl_ssi_init+0x24/0x34                                    
[e685dfb0] [c0001eb8] do_one_initcall+0x34/0x1ac                                
[e685dfe0] [c05b984c] kernel_init+0xa0/0x13c                                    
[e685dff0] [c000e588] kernel_thread+0x4c/0x68                                   
Instruction dump:                                                               
7ca42b78 483e03b9 801e5158 2f800000 409efe30 4819def5 2f830000 41befe24         
3d20c062 80095328 2f800000 40befe14 <0fe00000> 4bfffe0c 3f9c000a 881cc010       
---[ end trace d5a900576f6c55ce ]---                        

Is there something wrong with the way I'm calling device_create_file()?  That code has been around for years.  I don't understand what the kernel is complainging about.

-- 
Timur Tabi
Linux kernel developer at Freescale
