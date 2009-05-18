From: "Michael (Micksa) Slade" <micksa@knobbits.org>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Mon, 18 May 2009 13:43:36 +1000
Message-ID: <4A10D968.8040108@knobbits.org>
References: <s5h4ovovtwe.wl%tiwai@suse.de>	<s5h7i0i9yng.wl%tiwai@suse.de>	<4A0E88A4.2030206@knobbits.org>
	<s5h7i0h84sh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from killface.knobbits.org (killface.knobbits.org [67.18.208.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 94CE31037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 05:43:43 +0200 (CEST)
In-Reply-To: <s5h7i0h84sh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "Michael (Micksa) Slade" <mslade@knobbits.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 16 May 2009 19:34:28 +1000,
> Michael (Micksa) Slade wrote:
>   
>> Takashi Iwai wrote:
>>     
>>> It seems that there is no critical issues, so far.
>>> Thus I merged X-fi patch to sound GIT tree.  It'll appear in the
>>> normal alsa-driver snapshot below, too.
>>>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
>>>   
>>>       
>> Should the hda driver still have the X-fi PCI ids?
>>     
>
> Yes, it looks like that not all models are supported by ctxfi driver.
>
> The question is whether we get real conflicts.  If any, let me know.
>   
Well on my box snd-hda-intel, as-is, stole my card before snd-ctxfi 
could get to it.  Does that count as a conflict?

Mick.
