From: Tim Cussins <timcussins@eml.cc>
Subject: Re: proposal: snd_pcm_start_at()
Date: Wed, 08 Oct 2014 17:09:04 +0100
Message-ID: <543561A0.8020701@eml.cc>
References: <1412260460.3891605.174362449.667FB9BE@webmail.messagingengine.com>	<542D8E3F.4080400@linux.intel.com>	<542E8FE4.4080904@eml.cc>	<542F2216.7050801@linux.intel.com>	<s5h61fxzg2y.wl-tiwai@suse.de>	<20141008141832.GZ4609@sirena.org.uk>
 <s5hwq8atw95.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id C3BA2260478
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 18:09:17 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by gateway2.nyi.internal (Postfix) with ESMTP id D97F421107
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 12:09:16 -0400 (EDT)
In-Reply-To: <s5hwq8atw95.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 08/10/14 16:29, Takashi Iwai wrote:
> At Wed, 8 Oct 2014 15:18:32 +0100,
> Mark Brown wrote:
>>
>> On Mon, Oct 06, 2014 at 11:45:57AM +0200, Takashi Iwai wrote:
>>
>>> I think some synchronized triggering mechanism is missing in API, too.
>>> There has been a similar request from others in the past (Digigram
>>> wanted to have such a feature), so maybe it's not so uncommon
>>> scenario.
>>
>> Yes, I've had people ask me about this too, mainly around getting
>> multiple DSP streams synchronized.  It was a while ago and a bit edge
>> casey though.
>
> OK, I added it to the topic list of audio mini-summit.
> Let's see whether we can talk something about this.
>

Awesome. There's a couple of things I can do here:

1) Post my ideas for selecting/controlling VCO associated with PCM _soon_
2) Come over on Tuesday and join the mini summit
3) Both!

I'm pretty new to ALSA, so I can only realistically contribute to the 
scheduled stream trigger discussion, although the Configuration/ASoC 
stuff will be relevant to my crowd too.

If no-one has a major objection to a rep from the ALSA-newbie community, 
I'll see if I can come over :)

Either way, I'll post my VCO ideas to the list ASAP.

Cheers,
Tim
