From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 16:13:53 +0200
Message-ID: <503397A1.4000409@canonical.com>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com> <20120821140648.GC21557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BE27F265FB9
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:13:52 +0200 (CEST)
In-Reply-To: <20120821140648.GC21557@sirena.org.uk>
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

On 08/21/2012 04:06 PM, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 04:00:37PM +0200, David Henningsson wrote:
>> On 08/21/2012 01:37 PM, Clemens Ladisch wrote:
>
>>> This doesn't handle devices with simply numbered outputs (such as many
>>> ICE1712-based devices), or cases where one PCM channel can be routed to
>>> multiple outputs.  However, those devices typically have their own mixer
>>> applets, and generic applications aren't interested in configuring them.
>
>> As for routing more than one channel in the map from the same PCM,
>> that seems a bit more complex. Maybe one could do a bitmap of
>> channels instead of just one channel (with say, 32 room channel
>> positions and 32 just numbered positions, that would be 64 bits).
>> But how common is that anyway?
>
> It's very common on the embedded side to use pure numbered stuff (or at
> least to assign semantics dynamically at runtime which I suspect boils
> down to the same thing here).

It reminds me of the discussion we had about jack labelling (for HDA or 
everyone? I do not remember), where we ended up having

1) physical location (left side, internal, docking station)
2) type (headphone, speaker)
3) channel map (front, rear, c/lfe)

Maybe that's where this discussion is heading as well? I like the idea 
of having the same TLV description for jacks, mixer controls and PCM 
channels, maybe that could work for all but the most exotic cases?

(Where exotic means unusual hw on both the pro-audio and the embedded side)


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
