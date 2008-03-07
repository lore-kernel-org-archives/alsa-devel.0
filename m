From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: OSS4 X-Fi driver port to ALSA
Date: Fri, 07 Mar 2008 16:41:00 +0000
Message-ID: <47D1701C.3050403@superbug.co.uk>
References: <1202160350.3719.76.camel@petrie.sacredspiral.co.uk.sacredspiral.co.uk>	
	<s5h8x1ytuku.wl%tiwai@suse.de> <47A99513.1040906@superbug.co.uk>	
	<47C40F55.3060609@superbug.co.uk> <s5hve4bua14.wl%tiwai@suse.de>	
	<1204035157.9659.657.camel@petrie>
	<47D061EC.6010102@superbug.co.uk>
	<1204839432.2939.22.camel@petrie.sacredspiral.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 633C624618
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 17:41:03 +0100 (CET)
In-Reply-To: <1204839432.2939.22.camel@petrie.sacredspiral.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Pitcock <nenolod@sacredspiral.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

William Pitcock wrote:
> Hi James,
>
> On Thu, 2008-03-06 at 21:28 +0000, James Courtier-Dutton wrote:
>    
>> William Pitcock wrote:
>>      
>>> Hi,
>>>
>>> On Tue, 2008-02-26 at 14:23 +0100, Takashi Iwai wrote:
>>>        
>>>> Will anyone start porting from OSS?  It doesn't look like so much
>>>> amount of codes...
>>>>
>>>>          
>>> I intend to port from OSS soon. I just need to learn more about the
>>> driver's internals.
>>>
>>> William
>>>
>>>        
>> I now had some datasheets for the x-fi.
>> I think the first thing we should do is create a GPL version of the
>> header files.
>> Shall I do that task?
>>
>> James
>>
>>
>>      
>
> Yes! That sounds great. I have two different X-Fi cards, so let me know
> when you have the headers ready, and we can merge them into the OSS4
> driver as an initial effort. That way everything we have is
> theoretically free. I'll have to recheck what is in OSS4 though.
>
> William
>    
Why put it into OSS4?
I would put it into the alsa-driver hg repository as a new driver.
The header would go into the alsa-driver include dir.
Then, start by writing a new alsa driver to just playback to the front 
speakers with possibly a volume control.
Once we have that in alsa-driver working, we can then add features 
gradually.
I don't think we will be able to use the OSS4 code, that is only really 
useful as a reference.

James
