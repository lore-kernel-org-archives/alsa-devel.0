From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Thu, 28 Apr 2011 23:24:38 +0200
Message-ID: <4DB9DB16.1060507@metafoo.de>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
	<4DB9D06C.5090006@metafoo.de>
	<20110428205827.GA18350@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 243AF243CA
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 23:24:46 +0200 (CEST)
In-Reply-To: <20110428205827.GA18350@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 04/28/2011 10:58 PM, Mark Brown wrote:
> On Thu, Apr 28, 2011 at 10:39:08PM +0200, Lars-Peter Clausen wrote:
>> On 04/28/2011 09:40 PM, Mark Brown wrote:
>  [...]
> 
>>> TBH I'm not sure how much of a help I find this, it's nice to not have
>>> to pass the operation we're doing about all the time especially if we
>>> end up using more context information in the middle of the operation
>>> (which I suspect we may end up doing).  You still have to work back
>>> through the call chain to find where the data came from.
> 
>> Well, but you know that it is a parameter to the function call. With the
>> current scheme you don't know this immediately. Right now dapm->update is some
>> random global variable and it is not quite clear that it is only valid for the
>> time dapm_power_widgets is called.
> 
> It should be valid at any time, it's cleared after use. 

But you only know that when looking at all callers, which is my point.
Being part of the dapm struct which is available to all drivers doesn't make
this easier.

> It only makes sense when something is in the middle of doing an update. Half
> of the thing for me is that we can now grep for actual users without seeing
> things that are just bouncing the data around.

Hm. I won't argue to death here. I could only repeat what I've said before.
But if we keep passing it indirectly we should at least make the struct opaque
to the world outside of soc-dapm and move the update pointer from
snd_soc_dapm_context to snd_soc_card.

- Lars
