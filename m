From: Paul Davis <pbd@op.net>
Subject: Re: snd-rme9652_mem and the H-DSP
Date: Mon, 13 May 2002 21:59:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205140158.g4E1wNT28027@post2.fast.net>
References: <s5hlmao8i5z.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA17860
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 03:58:32 +0200
In-Reply-To: Your message of "Mon, 13 May 2002 12:18:48 +0200."
             <s5hlmao8i5z.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Perhaps, we can use a more universal name like 'snd-pci-bigmem' or
>> something like that. Other hardware might require this (if I remember
>> correctly S3 SonicVibes cards also requires a big memory chunk for DLS
>> samples). We can move this module to /alsa-kernel/pci.
>
>yes.  ice1712 needs relatively big chunk, too.
>
>how about to add module options to specify the pci id and the required
>size for non-default cards?

not a bad idea. but before doing this, we should check with the
appropriate kernel lieutenant. this seems to get rather close to the whole
point of memory zones that have been in the kernel for a while now. it
might be better to pursue a more generic kernel-level solution, rather
an ALSA specific module.

who shall we ask?

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
