From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 04/13] ASoC: Move IO functions to soc-io.c
Date: Wed, 19 Mar 2014 12:47:59 +0100
Message-ID: <532983EF.3060704@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-5-git-send-email-lars@metafoo.de>
 <20140319111057.GA11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-242.synserver.de (smtp-out-249.synserver.de
 [212.40.185.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 063EA265044
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 12:47:18 +0100 (CET)
In-Reply-To: <20140319111057.GA11706@sirena.org.uk>
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

On 03/19/2014 12:10 PM, Mark Brown wrote:
> On Tue, Mar 18, 2014 at 09:02:07AM +0100, Lars-Peter Clausen wrote:
>> soc-core.c is getting quite crowded. Move all IO related functions that are
>> still in soc-core.c to soc-io.c
>
> No, we're trying to make soc-io smaller!  Besides, if this stuff is
> getting cleaned up then:
>

We are trying to remove the ASoC level IO abstraction layer. In my opinion 
keeping everything related to this in one file, rather than hiding it among 
5k lines of other code, makes it clear what is still left to do.

>> -unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
>> -{
>> -	unsigned int ret;
>> -
>> -	ret = codec->read(codec, reg);
>> -	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
>> -	trace_snd_soc_reg_read(codec, reg, ret);
>> -
>> -	return ret;
>> -}
>> -EXPORT_SYMBOL_GPL(snd_soc_read);
>
> ...making small things like this static inlines in a header is probably a
> better move (we can probably drop the trace - I don't think anything in
> active development doesn't use regmap and it's a carrot to push people).

Ok, if we don't care of about the traces I'll remove them and make the 
function static inlines.

- Lars
