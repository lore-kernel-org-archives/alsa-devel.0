From: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Subject: Re: [PATCH] SB Live24-External better handling
Date: Tue, 30 Oct 2007 17:24:44 +0300
Message-ID: <47273EAC.10208@ipi.ac.ru>
References: <4725F0D0.4090201@ipi.ac.ru> <s5h7il5lz60.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipi.ac.ru (blackpeer.ipi.ac.ru [83.149.227.82])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C3ED24467
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 15:24:45 +0100 (CET)
In-Reply-To: <s5h7il5lz60.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Mon, 29 Oct 2007 17:40:16 +0300,
> Timofei V. Bondarenko wrote:
>> Hi.
>>
>> This patch improves support for 'SB Live 24-bit Extarnal' USB card.
>>
>> 1) This card can go into muted state when a headphones connected or 
>> disconnected. So notify mixer about changes in headphone jack.
>>
>> 2) Add LED controls and procfs support just as in similar Audigy 2 NX card.
>>
>> 3) Rename 'PCM Capture' conrol to 'Mic Capture' to reflect reality:
>> the card may adjust microphone input level only.
>>
>> Regards.
>> 	Tim.
> 
> Thanks for the patch.
> 
> The patch looks fine (except for tiny coding-issues, which I
> fixed already on my tree).
> 
> Could you give your sign-off to merge to the upstream tree?

Signed-off-by: Timofei Bondarenko <tim@ipi.ac.ru>

Just forgot it, sorry.

--
Regards,
	Tim.
