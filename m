From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Merging the new firmware files for CA0132 into
	alsa-firmware
Date: Tue, 28 May 2019 21:19:37 +0200
Message-ID: <58dfb36f-47ba-c62f-c39d-e05d000159b7@perex.cz>
References: <s5hblzmvdcq.wl-tiwai@suse.de>
 <9668d632-c5c9-5114-39cb-0e8a105a547c@perex.cz>
 <s5ha7f679o6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DB44F8065A
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 21:19:41 +0200 (CEST)
In-Reply-To: <s5ha7f679o6.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Connor McAdams <conmanx360@gmail.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 28. 05. 19 v 19:47 Takashi Iwai napsal(a):
> On Tue, 28 May 2019 18:38:48 +0200,
> Jaroslav Kysela wrote:
>>
>> Dne 28. 05. 19 v 16:54 Takashi Iwai napsal(a):
>>> Hi,
>>>
>>> it seems that Connor's previous attempt to put a couple of ca0132
>>> firmware files into linux-firmware tree didn't go through,
>>> unfortunately.  And now I'm thinking of taking them into alsa-firmware
>>> package as a stop-gap.  We already distribute other ca0132 firmware
>>> files, so the addition shouldn't be a big problem.
>>>
>>> Jaroslav, what do you think?
>>
>> No problem. The same situation is for the SoC SOF firmware files (drivers are
>> in kernel, firmware files are missing). Perhaps, we can release those files
>> quickly in alsa-firmware and then migrate them slowly to linux-firmware.
> 
> OK, now pushed to alsa-firmware git repo.
> 
> BTW, the situation is slightly different from SOF.  At this time, the
> problem was that it's been submitted by a third person.

Ok, so we don't have a licence for those files? Connor, have you tried to
contact Creative for a permission to use/distribute those files?

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
