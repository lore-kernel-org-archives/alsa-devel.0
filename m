From: Federico Fuga <f.fuga@people.it>
Subject: Re: Inappropriate ioctl for device on
 alsalib	with	uclibc and arm platform
Date: Fri, 23 Nov 2007 18:49:17 +0100
Message-ID: <4747129D.3020909@people.it>
References: <4741AA03.5070903@people.it>
	<s5hbq9pggs3.wl%tiwai@suse.de>	<4743108A.7050409@people.it>
	<s5h8x4rj4cf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpi2.ngi.it (smtpi2.ngi.it [88.149.128.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 13FAE24662
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 18:48:55 +0100 (CET)
In-Reply-To: <s5h8x4rj4cf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai ha scritto:
>>> ioctl(4, USBDEVFS_HUB_PORTINFO, 0xbeab0768) = -1 ENOTTY (Inappropriate
>>>   
>>>
>>> Looks like the definition of SNDRV_CTL_ICOTL_ELEM_WRITE doesn't match
>>> with the user-space and the kernel, most likely the size of struct
>>> snd_ctl_elem_value.  This might be a word alignment issue.
>>>       
> Well, I vaguely remember about the ARM cross-compiling problem.
> Checking the mail archive might help...
>   

Hi,

I have solved that problem.
While compiling the kernel, the alsa modules (not the alsa-driver, but
that one included in the "vanilla" sources) are compiled with the option
-mabi=aapcs-linux.
When compiling the library, that option is missing, using, as default,
another abi and, evidently, another data alignment => another struct
size => another ioctl.
I send you that for reference, but I think that a more general solution
should be nice.
Best regards, ant thank you for your interest.

ing. Federico Fuga
