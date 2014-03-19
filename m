From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 04/13] ASoC: Move IO functions to soc-io.c
Date: Wed, 19 Mar 2014 12:57:57 +0100
Message-ID: <53298645.8000904@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-5-git-send-email-lars@metafoo.de>
 <20140319111057.GA11706@sirena.org.uk> <532983EF.3060704@metafoo.de>
 <20140319115347.GB11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-242.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 410AA26506D
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 12:57:15 +0100 (CET)
In-Reply-To: <20140319115347.GB11706@sirena.org.uk>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On 03/19/2014 12:53 PM, Mark Brown wrote:
> On Wed, Mar 19, 2014 at 12:47:59PM +0100, Lars-Peter Clausen wrote:
>> On 03/19/2014 12:10 PM, Mark Brown wrote:
>
>>> No, we're trying to make soc-io smaller!  Besides, if this stuff is
>>> getting cleaned up then:
>
>> We are trying to remove the ASoC level IO abstraction layer. In my opinion
>> keeping everything related to this in one file, rather than hiding it among
>> 5k lines of other code, makes it clear what is still left to do.
>
> Like I've said before it is not obvious to me that removing the wrappers
> is a win - yes, things can obtain their regmap but if enough things need
> to do it then having a convenience wrapper which does the lookup at
> least doesn't hurt.
>

It's more about things like snd_soc_update_bits. The wrappers will stay, but 
can as you said be made static inline functions and moved to the header.
