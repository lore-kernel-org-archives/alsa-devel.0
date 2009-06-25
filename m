From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Thu, 25 Jun 2009 17:26:30 -0600
Message-ID: <4A4407A6.7010909@gmail.com>
References: <378E7985-7CD3-4009-AA14-127391A819F2@opensource.wolfsonmicro.com>	
	<9e4733910906241207m50340ef5gd63fc4527e50b861@mail.gmail.com>	
	<s5hprctmj5x.wl%tiwai@suse.de>	
	<9e4733910906242126v30add6d5r150f992aed6694dd@mail.gmail.com>	
	<4A430CC2.9050003@gmail.com>
	<9e4733910906250720r15a6ee0x79f472da482aa9ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f183.google.com (mail-pz0-f183.google.com
	[209.85.222.183])
	by alsa0.perex.cz (Postfix) with ESMTP id D919024572
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 01:25:49 +0200 (CEST)
Received: by pzk13 with SMTP id 13so1440537pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 16:25:48 -0700 (PDT)
In-Reply-To: <9e4733910906250720r15a6ee0x79f472da482aa9ec@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/25/2009 08:20 AM, Jon Smirl wrote:
> On Thu, Jun 25, 2009 at 1:36 AM, Robert Hancock<hancockrwd@gmail.com>  wrote:
>> On 06/24/2009 10:26 PM, Jon Smirl wrote:
>>> On Wed, Jun 24, 2009 at 5:11 PM, Takashi Iwai<tiwai@suse.de>    wrote:
>>>>> The problem is knowing which sample in the background music to start
>>>>> mixing the low latency laser blast into.
>>>> That's why querying the accurate hwptr is important in PA.
>>> I'm still not convinced that all of this logic should be exposed to
>>> PA. Exposing these details is what makes ALSA hard to use. We should
>>> be able to better isolate user space from this. If mixing were moved
>>> into the kernel these details could be hidden.  The in-kernel code
>>> could then be customized for various sound DMA hardware. This would
>>> also go a long ways toward getting rid of latency issues by removing
>>> the need for real-time response from PA.
>> Mixing really does not belong in the kernel. Moving it there doesn't remove
>> any complication or problem, it just moves it to a different place where
>> it's more difficult to program and less debuggable. Most OSes (Windows
>> included) are moving in the direction of moving mixing out of the kernel,
>> not into it.
>
> Mixing has a real-time component to it. Currently Desktop Linux
> doesn't have real-time support. That's why pulse is developing
> RealTimeKit.  Buggy real-time code can easily lock your machine to
> where you need to hit the reset button.
>
> User space code that is locked down with real-time priority and
> servicing interrupts is effectively kernel code, it might as well be
> in the kernel where it can get rid of the process overhead.
>
> http://git.0pointer.de/?p=rtkit.git;a=blob;f=README

Just because it runs with real time priority does not mean it is 
effectively kernel code, or that it belongs there. Putting the code into 
the kernel adds a bunch of extra challenges for little reason, and also 
locks all users into a mixing scheme that may not meet their needs 
(ahem, Windows kernel mixer..)
