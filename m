From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - ESI Juli driver - removed debugs
Date: Tue, 18 Mar 2008 16:59:04 +0100
Message-ID: <47DFE6C8.7040306@insite.cz>
References: <47DD1934.3000003@insite.cz>	<s5hod9du6gb.wl%tiwai@suse.de>	<47DE328D.1080009@insite.cz>	<s5htzj5r9d6.wl%tiwai@suse.de>	<47DE3BD2.5090007@insite.cz>	<s5hwso1pkms.wl%tiwai@suse.de>	<47DE7B70.2040407@insite.cz>	<s5hd4ptpefs.wl%tiwai@suse.de>	<47DE934F.3060308@insite.cz>	<s5hy78hnxy7.wl%tiwai@suse.de>	<47DF678B.3000605@insite.cz>
	<s5h7ig0w01l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from prague.insite.cz (r3g29.net.upc.cz [213.220.198.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 613DB2447E
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 16:59:10 +0100 (CET)
In-Reply-To: <s5h7ig0w01l.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Takashi Iwai napsal(a):
> At Tue, 18 Mar 2008 07:56:11 +0100,
> Pavel Hofman wrote:
>> Takashi Iwai wrote:
>>> At Mon, 17 Mar 2008 16:50:39 +0100,
>>> Pavel Hofman wrote:
>>>
>>> Well, then we'll need to find some point to compromise.  Could you
>>> repost the patch after reducing the callbacks again?
>>>
>>> I'll have also no time from the next week at all -- will be on
>>> vacation for three weeks.  So, let's kick it out soonish :)
>>>
>> Hi,
>>
>> I am sorry, the previous patch had some debugs enabled. Here is a fixed 
>> patch.
>>
>> Thanks a lot.
>>
>> Pavel.
>>
>>
>> Signed-off-by: Pavel Hofman <dustin at seznam.cz>
>>
>> * moving most of clock-specific code to card-specific routines
>> * support for ESI Juli
>> * to-be-researched - monitoring of analog/digital inputs
> 
> Thanks.  Now I checked the patch and found it much better now.
> However, I still think the get_rate_index can be omitted by checking
> the index from the rate list dynamically.  This looks inefficent but
> improves the readability and reduces the code size better.  Moreover,
> the snd_pcm_hw's aren't needed to be prepared for each type.
> 
> Below is my revised patch.  With this patch, ice->hw_rates must be
> non-NULL and this is referred in many places.  It cleans up
> *_internal_clock*() nicely.
> 

Takashi, thanks a lot. I will test the patch tonight and let you know.

Pavel.
