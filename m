From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 16:52:29 +0200
Message-ID: <5033A0AD.2010403@canonical.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com> <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C1D526600E
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:52:28 +0200 (CEST)
In-Reply-To: <20120821141759.GO7995@opensource.wolfsonmicro.com>
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

On 08/21/2012 04:18 PM, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 04:13:53PM +0200, David Henningsson wrote:
>
>> It reminds me of the discussion we had about jack labelling (for HDA
>> or everyone? I do not remember), where we ended up having
>
>> 1) physical location (left side, internal, docking station)
>> 2) type (headphone, speaker)
>> 3) channel map (front, rear, c/lfe)
>
>> Maybe that's where this discussion is heading as well? I like the
>> idea of having the same TLV description for jacks, mixer controls
>> and PCM channels, maybe that could work for all but the most exotic
>> cases?
>
>> (Where exotic means unusual hw on both the pro-audio and the embedded side)
>
> Or perhaps what we want to do here is define the channel mapping in
> terms of saying "I'm connecting to this input/output" and then use the
> jack interface to describe all inputs and outputs rather than just jacks
> (making sure it's easy to see which ones can change state)?

That's an interesting idea. The possible drawback is that it would 
require all drivers that want to use this to implement jacks also.

In the ctljack interface for HDA, we already describe all inputs and 
outputs - with the nonchangable ones having the additional "Phantom" 
suffix, so the result becomes e g "Internal Mic Phantom Jack".


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
