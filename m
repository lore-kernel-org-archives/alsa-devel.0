From: Andy Green <andy@warmcat.com>
Subject: Re: Acer Aspire 8920g / snd-hda-intel / ALC889
Date: Tue, 13 May 2008 15:41:58 +0100
Message-ID: <4829A8B6.30409@warmcat.com>
References: <480C8260.70501@warmcat.com>	<s5hr6czb3po.wl%tiwai@suse.de>	<480CDC26.3010506@warmcat.com>	<s5h63uab2k1.wl%tiwai@suse.de>	<480DC787.9070208@warmcat.com>	<s5h3apeb0gq.wl%tiwai@suse.de>	<480DCBC6.3050203@warmcat.com>	<480FA5D5.9090208@warmcat.com>	<s5h3apakthj.wl%tiwai@suse.de>	<481F84FA.4060307@warmcat.com>	<s5hod7jd8dc.wl%tiwai@suse.de>	<48203A6B.7020408@warmcat.com>
	<s5hskwmcnxm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.mog.warmcat.com (purr.warmcat.com [87.106.142.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D57E24B02
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 16:42:10 +0200 (CEST)
In-Reply-To: <s5hskwmcnxm.wl%tiwai@suse.de>
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

Somebody in the thread at some point said:
> At Tue, 06 May 2008 12:00:59 +0100,
> Andy Green wrote:
>> Somebody in the thread at some point said:
>>
>> Hi -
>>
>>> Is this above with model=acer-aspire *and* your additional verb?
>>> Or, is it without model option?
>> I tried it with model=acer (same as no forcing) and acer-aspire, I was 
>> able to play 2-channel PCM sounds OK only with the extra verb either 
>> way.  I got more controls in alsamixer with just "acer" (like low 
>> frequency channel), but they didn't seem to do anything useful.
>>
>>> I found that one initialization is missing for auto-configuration mode
>>> of ALC889.  Please try the patch below and remove model=xxx option.
>> OK I will test this patch later today with no model forcing.
> 
> Did you get any positive/negative result?

Sorry Takashi, I did try both patches but neither seemed to work.  I 
didn't get any time since then to confirm it wasn't something dumb on my 
side.  After failing to see anything from the recompile / re-install and 
modprobing snd-hda-intel out and back in, running hda-verb as described 
did continue to bring the audio right up.

I should check that the mixer VID/PID actually is ...889 on this machine.

-Andy
