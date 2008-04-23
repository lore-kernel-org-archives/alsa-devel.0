From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: MIDI on ice1724 - preliminary findings and
	questions
Date: Wed, 23 Apr 2008 13:08:10 +0200
Message-ID: <480F189A.7030500@insite.cz>
References: <480E495B.20607@insite.cz> <s5h63u8evih.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id E99002434C
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 13:08:18 +0200 (CEST)
In-Reply-To: <s5h63u8evih.wl%tiwai@suse.de>
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
> At Tue, 22 Apr 2008 22:23:55 +0200,
> Pavel Hofman wrote:
>> Hi,
>>
...........
>>
>> After the playback stops, the interrupts are gone too. It seems as if 
>> the playback interrupt initiates the MPU TX interrupt.
>>
>> If we could avoid generating the MPU TX interrupt during regular 
>> playback, I believe the major problem would be resolved.
>>
>> Even if I mask the interrupts (CCS01) and do not explicitly unmask them 
>> (according to proc ice1724 the CCS01 register stays at 0xa0), the 
>> interrupt gets generated.
> 
> OK, then the simplest way would be to just ignore the TX bit at the
> second or later check.
> 
> How about the patch below?

Takashi, thanks for the hack idea. The overhead is just one more loop 
which is nothing. I will test it and post details of further problems 
(there is a bunch of them :) )

Pavel.
