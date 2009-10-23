From: "Neil Jones" <neil.jones@imgtec.com>
Subject: Re: What is the meaning of the mask values in the
	pcmhw constraints struct ?
Date: Fri, 23 Oct 2009 14:39:58 +0100
Message-ID: <0D107966AF6D79418315B7C5549F4B5101150B9F@lemail1.le.imgtec.org>
References: <0D107966AF6D79418315B7C5549F4B5101150A39@lemail1.le.imgtec.org>
	<20091020165037.GA15813@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filter3.imgtec.com (multi.imgtec.com [194.200.65.239])
	by alsa0.perex.cz (Postfix) with ESMTP id D4C8E1037F8
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Oct 2009 15:40:00 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <20091020165037.GA15813@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> I get the error "aplay: set_params:1022: Unable to install hw
params:"
>> I have traced the problem to a failing ioctl call
>> (snd_pcm_playback_ioctl) the error occurs in snd_pcm_hw_refine when
>> refining the mask for the SNDRV_PCM_HW_PARAM_ACCESS mask, all the bit
>> fields in my runtime->hw_constraints are zero for this field, but the

>You should set these up with snd_soc_set_runtime_hwparams() with the
>flags in the info field.

>> requested params have the value 7, Im not sure what this means, the
>> SNDRV_PCM_ACCESS_xxx defines in asound.h only go upto 4 ?

>It's a bitmask at this point, treat those values as shifts.

Cheers, I wasn't setting the 'SNDRV_PCM_INFO_MMAP' in my
snd_pcm_hardware description, because I didn't have MMAP support, I have
now added MMAP support to my driver to resolve this issue, although I
thought ALSA/aplay supported drivers without MMAP support ?



-
This message is subject to Imagination Technologies' e-mail terms: http://www.imgtec.com/e-mail.htm

Imagination Technologies Ltd is a limited company registered in England No:  1306335 
Registered Office: Imagination House, Home Park Estate, Kings Langley, Hertfordshire, WD4 8LZ.  

Email to and from the company may be monitored for compliance and other administrative purposes.  
-
