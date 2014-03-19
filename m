From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 05/13] ASoC: Drop ASoC level caching from
	hw_write/hw_read
Date: Wed, 19 Mar 2014 14:01:51 +0100
Message-ID: <5329953F.500@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-6-git-send-email-lars@metafoo.de>
 <20140319125850.GF11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-242.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 8417326506D
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 14:01:07 +0100 (CET)
In-Reply-To: <20140319125850.GF11706@sirena.org.uk>
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

On 03/19/2014 01:58 PM, Mark Brown wrote:
> On Tue, Mar 18, 2014 at 09:02:08AM +0100, Lars-Peter Clausen wrote:
>> All drivers using these functions now do regmap level caching. So this is dead
>> code and can be removed.
>
> I actually have a version of this in my tree already, a cleaned up
> version of the patch I posted while I was travelling which I couldn't
> test at the time.  Since this one seems to depend on other stuff in your
> series which I don't want to apply before the merge window I'm thinking
> applying the version I have already - OK?
>

yep.
