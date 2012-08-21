From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 17:38:34 +0200
Message-ID: <5033AB7A.7050609@ladisch.de>
References: <s5hr4r0359e.wl%tiwai@suse.de> <50337316.4080208@ladisch.de>
 <50339485.30500@canonical.com> <20120821140648.GC21557@sirena.org.uk>
 <503397A1.4000409@canonical.com>
 <20120821141759.GO7995@opensource.wolfsonmicro.com>
 <s5htxvw1eqz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E4E2426603C
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 17:38:35 +0200 (CEST)
In-Reply-To: <s5htxvw1eqz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Mark Brown wrote:
>> On Tue, Aug 21, 2012 at 04:13:53PM +0200, David Henningsson wrote:
>>> It reminds me of the discussion we had about jack labelling (for HDA
>>> or everyone? I do not remember), where we ended up having
>>>
>>> 1) physical location (left side, internal, docking station)
>>> 2) type (headphone, speaker)
>>> 3) channel map (front, rear, c/lfe)
>>>
>>> Maybe that's where this discussion is heading as well? I like the
>>> idea of having the same TLV description for jacks, mixer controls
>>> and PCM channels, maybe that could work for all but the most exotic
>>> cases?
>>>
>>> (Where exotic means unusual hw on both the pro-audio and the embedded side)
>>
>> Or perhaps what we want to do here is define the channel mapping in
>> terms of saying "I'm connecting to this input/output" and then use the
>> jack interface to describe all inputs and outputs rather than just jacks
>> (making sure it's easy to see which ones can change state)?
>
> It's an interesting idea.  But, in the case of HDMI, there are no
> multiple jacks, so this won't fit.  [...]
> The primary goal of this API is to provide a way for apps to decide
> the channel map for multi-channel streams.

Indeed; including the jack location/type would go beyond what the
channel map is useful for.  Playback applications know what kind of
multichannel stream they're playing, but they definitely do _not_ want
to decice if the output should go to the front or back panel.

The channel mapping is a _stream_ configuration, the other routing
choices are device setup.

At the moment, we lack an API to provide topology information.  But
whatever form it takes, it should probably be independent of the channel
mapping.  (I'll see if I can find time to do something about my media
framework patches until next week.)


Regards,
Clemens
