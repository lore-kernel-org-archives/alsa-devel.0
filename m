From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 17:38:28 +0200
Message-ID: <5033AB74.8050201@canonical.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com> <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
 <5033A0AD.2010403@canonical.com>
 <20120821150720.GS7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C044265FFA
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 17:38:26 +0200 (CEST)
In-Reply-To: <20120821150720.GS7995@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 08/21/2012 05:07 PM, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 04:52:29PM +0200, David Henningsson wrote:
>> On 08/21/2012 04:18 PM, Mark Brown wrote:
>
>>> Or perhaps what we want to do here is define the channel mapping in
>>> terms of saying "I'm connecting to this input/output" and then use the
>>> jack interface to describe all inputs and outputs rather than just jacks
>>> (making sure it's easy to see which ones can change state)?
>
>> That's an interesting idea. The possible drawback is that it would
>> require all drivers that want to use this to implement jacks also.
>
> I'm not sure that's a big deal, we should be able to make the fixed data
> case easy enough to do.
>
>> In the ctljack interface for HDA, we already describe all inputs and
>> outputs - with the nonchangable ones having the additional "Phantom"
>> suffix, so the result becomes e g "Internal Mic Phantom Jack".
>
> Which of course is also replicated with the calls into the original
> jack API.

Actually, the phantom jacks are only in the ctljack API. I deliberately 
left them out of the old jack API, because it was deprecated (or at 
least so I thought).


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
