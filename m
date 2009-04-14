From: Florian Faber <faber@faberman.de>
Subject: [PATCH] hdspm: native float
Date: Tue, 14 Apr 2009 19:11:45 +0200
Message-ID: <1239729105.18545.12.camel@x200.watzmann.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id A039024434
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 19:12:11 +0200 (CEST)
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

Adds native float support to the driver. The interface has hardware
support for CoreAudio[tm], why shouldn't jack users benefit from it.

diff a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c

13a14,16
>  *      Modified 2009-04-14 for native float support by Florian Faber
>  *                                               <faber@faberman.de>
>  *
39a43
> #include <sound/pcm_params.h>
198a203
> #define HDSPe_FLOAT_FORMAT         0x2000000
3726a3732,3747
> 
> 
> 	/* Switch to native float format if requested */
> 	if (SNDRV_PCM_FORMAT_FLOAT_LE == params_format(params)) {
> 	  if (!(hdspm->control_register & HDSPe_FLOAT_FORMAT)) {
> 	    snd_printk(KERN_INFO "hdspm: Switching to native 32bit LE float
format.\n");
> 	  }
> 	  hdspm->control_register |= HDSPe_FLOAT_FORMAT;
> 	} else if (SNDRV_PCM_FORMAT_S32_LE == params_format(params)) {
> 	  if (hdspm->control_register & HDSPe_FLOAT_FORMAT) {
> 	    snd_printk(KERN_INFO "hdspm: Switching to native 32bit LE integer
format.\n");
> 	  }
> 	  hdspm->control_register &= ~HDSPe_FLOAT_FORMAT;
> 	}
> 	hdspm_write(hdspm, HDSPM_controlRegister, hdspm->control_register);
> 
3870c3891
< 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
---
> 	.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_FLOAT_LE,
3895c3916
< 	.formats = SNDRV_PCM_FMTBIT_S32_LE,
---
> 	.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_FLOAT_LE,

Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
