From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: Issues with alsa-lib-1.0.13 built using arm gcc 4.1.1
Date: Mon, 17 Mar 2008 20:06:20 -0700
Message-ID: <2d51cbf80803172006g368e54c0n93b014a4b71da506@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by alsa0.perex.cz (Postfix) with ESMTP id A53C924131
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 04:06:22 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so7244432wxc.23
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 20:06:21 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hello,

I have written an external io type plugin for an arm based board.
While debugging the plugin, I encountered unexpected errors
which I doubt are because of gcc optimizations, and after looking up on
web it seems that arm-gcc 4.1.1 which we are using has some known bugs
due to which alsa-library functions behave unexpectedly.
E.g. snd_mask_refine() reportedly behaves differently when it is
compiled using different optimization levels, I am facing the same issue
where snd_mask_refine() returns unexpected (-EINVAL) and after I modify the
code as in src/pcm/mask_inline.h

 MASK_INLINE void snd_mask_copy(snd_mask_t *mask, const snd_mask_t *v)
 {
-  *mask = *v;
+    memcpy(mask->bits, v->bits, MASK_SIZE * 4);
 }

snd_mask_refine() returns 0 which is valid but I get segfaults just after
returning from snd_pcm_ioplug_hw_refine().

Is this a known bug and if yes/no then is there any list of known
bugs/quirks when using alsa-lib with arm gcc 4.1.1?


I am attaching a log below, pardon for non-alsa flavour of debug messages in
the log.

# aplay -D myplug etc/startup.wav
AlsaVersion=1.0.13, Opened for Playback
----- INFO  (ALSA) : Successfully Registered the IO plugin ALSA-OPENMAX
PLUGIN

Playing WAVE 'etc/startup.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Ste
reo
####aplay.c set_params calling snd_pcm_hw_params_any
###### snd_pcm_hw_params_any 1
##### _snd_pcm_hw_params_any 0
##### _snd_pcm_hw_params_any 2
##### _snd_pcm_hw_params_any 8
##### _snd_pcm_hw_params_any 19
_snd_pcm_hw_param_any
 in hw_is_mask
_snd_pcm_hw_param_any
 in hw_is_mask
_snd_pcm_hw_param_any
 in hw_is_mask
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
_snd_pcm_hw_param_any
 in hw_is_interval
##### snd_pcm_hw_params_any 1
#####snd_pcm_hw_refine
#####snd_pcm_hw_refine calling hw_refine
#### snd_pcm_ioplug_hw_refine 1
snd_ext_parm_mask_refine 1
 snd_mask_refine 1
 snd_ext_parm_mask_refine return val is = 1
 snd_ext_parm_mask_refine 1
 snd_mask_refine 1
 snd_ext_parm_mask_refine return val is = 1
 snd_pcm_ioplug_hw_refine 2
 snd_ext_parm_interval_refine 1
 snd_ext_parm_interval_refine 1
 snd_pcm_ioplug_hw_refine 3
 snd_mask_refine 1
 snd_mask_refine 1
 snd_mask_refine 1
 snd_pcm_ioplug_hw_refine 4
 snd_ext_parm_interval_refine 1
 snd_pcm_ioplug_hw_refine 5
 snd_ext_parm_interval_refine 1
 snd_ext_parm_interval_refine 1
 snd_ext_parm_interval_refine 1
 snd_ext_parm_interval_refine 1
 snd_pcm_ioplug_hw_refine 5 change is = 1
 ##### return val of hw_refine = 1
#####snd_pcm_hw_refine
#####snd_pcm_hw_refine calling hw_refine
#### snd_pcm_ioplug_hw_refine 1
snd_ext_parm_mask_refine 1
 snd_mask_refine 1
 snd_ext_parm_mask_refine return val is = 0
 snd_ext_parm_mask_refine 1
 snd_mask_refine 1
 snd_ext_parm_mask_refine return val is = 0
 snd_pcm_ioplug_hw_refine 2
 snd_ext_parm_interval_refine 1
 snd_ext_parm_interval_refine 1
 snd_pcm_ioplug_hw_refine 3
 snd_mask_refine 1
 snd_pcm_ioplug_hw_refine 4
 snd_ext_parm_interval_refine 1
 snd_pcm_ioplug_hw_refine 5
 snd_ext_parm_interval_refine 1
 snd_ext_parm_interval_refine 1
 snd_pcm_ioplug_hw_refine 5 change is = 0
 ##### return val of hw_refine = 0
Dec 31 16:27:59 kernel: aplay: unhandled page fault (11) at 0x00000022, code
0x0
17
Dec 31 16:27:59 kernel: pgd = c30d8000
Dec 31 16:27:59 kernel:
Dec 31 16:27:59 kernel:
Dec 31 16:27:59 kernel: Pid: 206, comm:                aplay
Dec 31 16:27:59 kernel: CPU: 0    Not tainted  (2.6.23.14-BROADCOM #1)
Dec 31 16:27:59 kernel: PC is at 0x40170770
Dec 31 16:27:59 kernel: LR is at 0x40168210
Dec 31 16:27:59 kernel: pc : [<40170770>]    lr : [<40168210>]    psr:
a0000010
Dec 31 16:27:59 kernel: sp : bee6f698  ip : 401855f8  fp : bee6fb64
Dec 31 16:27:59 kernel: r10: 401852b0  r9 : 00000006  r8 : bee6f894
Dec 31 16:27:59 kernel: r7 : 0001cc64  r6 : 00000022  r5 : 000130fc  r4 :
bee6f7
04
Dec 31 16:27:59 kernel: r3 : ffffffff  r2 : 00000022  r1 : fffffffe  r0 :
000000
22
Dec 31 16:27:59 kernel: Flags: NzCv  IRQs on  FIQs on  Mode USER_32  ISA
ARM  Se
gment user
Dec 31 16:27:59 kernel: Control: 00e5387f  Table: c30d8008  DAC: 00000015
Dec 31 16:27:59 kernel: (__do_user_fault+0x5c/0xa4)
Dec 31 16:27:59 kernel:
Dec 31 16:27:59 kernel: (do_page_fault+0x200/0x238)
Dec 31 16:27:59 kernel:
Dec 31 16:27:59 kernel: (do_DataAbort+0x3c/0xa0)
Dec 31 16:27:59 kernel: (ret_from_exception+0x0/0x10)
Dec 31 16:27:59 kernel: Exception stack(0xc31a1fb0 to 0xc31a1ff8)
Dec 31 16:27:59 kernel:
Dec 31 16:27:59 kernel:
Dec 31 16:27:59 kernel:
Dec 31 16:27:59 kernel:
Segmentation fault
Regards,
Sandeep.
