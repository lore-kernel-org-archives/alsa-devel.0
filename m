From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, devel now at v2.6.34-rc2-55-g0bf0e5a
Date: Fri, 26 Mar 2010 10:58:55 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003261056120.3925@eeebox2.perex-int.cz>
References: <20100326093800.3510C103802@alsa0.perex.cz>
	<s5hljdf5s23.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D3ED103802
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 10:58:56 +0100 (CET)
In-Reply-To: <s5hljdf5s23.wl%tiwai@suse.de>
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

On Fri, 26 Mar 2010, Takashi Iwai wrote:

> At Fri, 26 Mar 2010 10:37:56 +0100 (CET),
> noreply-git@alsa-project.org wrote:
>>
>> commit cd508fe58b07499403e806b558c7f15c90442292
>> Author:     Jaroslav Kysela <perex@perex.cz>
>> AuthorDate: Fri Mar 26 10:28:46 2010 +0100
>> Commit:     Jaroslav Kysela <perex@perex.cz>
>> CommitDate: Fri Mar 26 10:37:39 2010 +0100
>>
>>     ALSA: hda-intel - add special 'hwio' model to bypass initialization
>>
>>     Using the 'model=hwio' option, the driver bypasses any codec
>>     initialization and the reset procedure for codecs is also
>>     bypassed. This mode is usefull to enable direct access using
>>     hwdep interface (using hdaverb or hda-analyzer tools) and
>>     retain codec setup from BIOS.
>
> What is the merit over probe_only=1 option...?

I overlooked this possibility. Anyway, skipping the codec reset might 
help to determine the BIOS settings of codec. I'll update this patch 
(remove changes in hda_codec.c and use bit 1 in probe_only as skip codec 
reset).

 				Thanks,
 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
