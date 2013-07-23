From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Remove unused dapm_get_snd_card()
 and dapm_get_soc_card()
Date: Tue, 23 Jul 2013 21:47:58 +0200
Message-ID: <51EEDDEE.9030701@metafoo.de>
References: <1374570745-32224-1-git-send-email-lars@metafoo.de>
 <1374583782.2475.26.camel@loki> <20130723173646.GL9858@sirena.org.uk>
 <51EEC3FB.9050701@metafoo.de> <20130723193204.GQ9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5B0265192
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 21:47:59 +0200 (CEST)
In-Reply-To: <20130723193204.GQ9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/23/2013 09:32 PM, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 07:57:15PM +0200, Lars-Peter Clausen wrote:
>> On 07/23/2013 07:36 PM, Mark Brown wrote:
>
>>> We can always add them back in later if they get a user.
>
>> If there are any out of tree users they should just use dapm->card
>> instead. It's much more simpler than this 'if (dapm->codec) return
>> dapm->codec->card; else if (dapm->platform) return
>> dapm->platform->card;' and at the same time more robust since it
>> also works for dapm contexts which don't belong to a codec or
>> platform.
>
> Right, though my thought looking at the code was that the intention was
> to also do a transition so that dapm->card isn't there any more.

In a sense the dapm context is like a common base class to both platforms and 
codecs. So it's probably better to remove 'card' from the codec and platform 
structs. codec->dapm.card is as expensive as codec->card while looking up the 
card for the dapm context by either going through the platform or codec is more 
expensive than using the direct pointer. But hopefully the component stuff will 
fix that all.

- Lars
