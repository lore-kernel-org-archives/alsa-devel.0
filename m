From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: M-Audio Revolution 7.1 sound card causing crash
	on	Alpha
Date: Fri, 7 Mar 2008 08:52:03 +1300
Message-ID: <D6EF80FD-E853-4E4C-90AE-C5703986A7F4@orcon.net.nz>
References: <47CE565F.9020407@orcon.net.nz> <s5hmypc2m1v.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.orcon.net.nz (mx1.orcon.net.nz [219.88.242.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 385C524346
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 20:52:12 +0100 (CET)
Received: from Debian-exim by mx1.orcon.net.nz with local (Exim 4.67)
	(envelope-from <mcree@orcon.net.nz>) id 1JXM8O-0002aF-AL
	for alsa-devel@alsa-project.org; Fri, 07 Mar 2008 08:52:08 +1300
In-Reply-To: <s5hmypc2m1v.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, debian-alpha@lists.debian.org
List-Id: alsa-devel@alsa-project.org

On 6/03/2008, at 11:18 PM, Takashi Iwai wrote:

> At Wed, 05 Mar 2008 21:14:23 +1300, Michael Cree wrote:
>>
>> I recently installed a M-Audio Revolution 7.1 sound card into DEC/ 
>> Compaq
>> Alpha XP1000, and it is causing crashes and complete lock ups of the
>> computer when I attempt to play sound through the sound card.

>>   This seems to be a bug possibly specific to the Alpha
>> architecture.
>>
>> Any ideas as to the problem?
>
> The oops looks related with mmap.  Maybe alpha doesn't support the
> mmap of coherent DMA pages like intel architectures allow?
>
> Try to disable mmap support in the driver once - e.g. comment out
> SNDRV_PCM_INFO_MMAP in struct snd_pcm_hardware.info fields found in
> ice1724.c.

I see that there is also a SNDRV_PCM_INFO_MMAP_VALID flag in the  
initialisations of the snd_pcm_hardware.info field.  Should I comment  
that out too?

May be a few days before I can test this out - I have just realised  
that a couple of my disk partitions are corrupted; I suspect one of  
the crashes of the audio driver is the explanation.  I will have to  
restore from a backup first before continuing testing.

Michael.
