From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: M-Audio Revolution 7.1 sound card causing crash
	on	Alpha
Date: Tue, 1 Apr 2008 09:46:54 +1300
Message-ID: <4CDD8A25-D8B3-4B47-8344-F4E0C786DF49@orcon.net.nz>
References: <47CE565F.9020407@orcon.net.nz> <s5hmypc2m1v.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.orcon.net.nz (mx2.orcon.net.nz [219.88.242.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C09224842
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Mar 2008 22:47:03 +0200 (CEST)
Received: from Debian-exim by mx2.orcon.net.nz with local (Exim 4.67)
	(envelope-from <mcree@orcon.net.nz>) id 1JgQuC-0008KE-8G
	for alsa-devel@alsa-project.org; Tue, 01 Apr 2008 09:47:00 +1300
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
>> computer when I attempt to play sound through the sound card.  Since
>> this is my main computer I shifted the card to a DEC Alpha PWS500au  
>> and
>> it causes the same lock ups there, and in one case a kernel oops  
>> made it
>> into the system log (listed below).
>
> The oops looks related with mmap.  Maybe alpha doesn't support the
> mmap of coherent DMA pages like intel architectures allow?


I have just applied the recently announced patch (alpha: fix ALSA DMA  
mmap crash) in the -mm kernel tree to the 2.6.24.3 kernel I am  
running.  The M-Audio Revolution 7.1 card now works fine on both  
Compaq Alpha XP1000 and the DEC Alpha PWS600au.

Cheers
Michael.
