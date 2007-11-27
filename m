From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] 1616(M) cardbus improvements
Date: Tue, 27 Nov 2007 19:29:31 +0000
Message-ID: <474C701B.4080605@superbug.co.uk>
References: <200711160007.00300.c.fertr@gmail.com>
	<s5hwss3iqqu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id D9C4B244E4
	for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2007 20:29:32 +0100 (CET)
In-Reply-To: <s5hwss3iqqu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Ctirad Fertr <c.fertr@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 16 Nov 2007 00:07:00 +0100,
> Ctirad Fertr wrote:
>> Hello,
>>
>> this patch improves E-Mu 1616(M) cardbus support. It adds definitions of the 
>> new Microdock and 1010 cardbus registers (thanks again for descriptions 
>> James) and improves mixer for this card. Now you can use S/PDIF and ADAT on 
>> Mirodock and also use headpohone output on host cardbus card as another 
>> independent output.
>>
>> Signed-off-by: Ctirad Fertr <c.fertr@gmail.com> 
> 
> The changes look almost good to me.  But, if I understand correctly,
> the input source put isn't changed properly for EMU1616.
> 
> The patch below is the revised version with bunch of coding style
> fixes (at the next time, try scripts/checkpatch.pl in linux kernel
> tree before submission).
> Let me know if it works for you.  I'll apply to ALSA tree after your
> confirmation. 
> 
> 
> Thanks,
> 
> Takashi
> 

Thank you Takashi, I have not had time to look at this patch.
