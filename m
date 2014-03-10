From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
 register DMIC routes seperatly
Date: Mon, 10 Mar 2014 12:29:33 +0100
Message-ID: <531DA21D.5080402@metafoo.de>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
 <531D7427.5020006@ti.com> <531D756A.6000505@metafoo.de>
 <20140310091250.GD28112@sirena.org.uk> <531D84E1.8050706@metafoo.de>
 <20140310101038.GO28112@sirena.org.uk> <531D939B.4050102@metafoo.de>
 <20140310110502.GW28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 92E5526507F
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 12:28:56 +0100 (CET)
In-Reply-To: <20140310110502.GW28112@sirena.org.uk>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 12:05 PM, Mark Brown wrote:
> On Mon, Mar 10, 2014 at 11:27:39AM +0100, Lars-Peter Clausen wrote:
>> On 03/10/2014 11:10 AM, Mark Brown wrote:
>
>>> The only thing that should be registering
>>> things for other components is the card and the general idea was to
>>> register everything in late_probe().
>
>> What most machine drivers did before card table based setup is to
>> have a per-component callback in which they did register the card
>> DAPM elements associated with that component. E.g. routes from the
>> CODEC output to a speaker, etc. You couldn't register the card level
>> DAPM elements for one component in the init callback component of
>> another one since the routes depend on the widgets being registered
>> first. So those board drivers kept separate routes and widget tables
>> for separate components. With table based setup for the card the
>
> I'm sorry but this just isn't what was happening at all.  Remember that
> most of the code that you're looking at only ever had one component so
> it really never made any difference which callback people happened to
> pick so long as it was one of the ones that ran after the CODEC was up.
>
> The only driver that I can think of which did anything like what you
> describe was smdk-wm8580 and that was still only using one component,
> it's just that Jassi preferred to split the input and output paths since
> the DAIs were separate on the CODEC and he felt that was clearer.  It
> didn't make any practical difference, it certainly wasn't due to startup
> ordering.

Take a look at e.g. omap/rx51.c it's doing what I'm describing and I presume 
it does this for the reasons I described.

But it doesn't really matter. The important thing about this series is that 
card level DAPM elements and controls should be registered with the card not 
the CODEC and I think we can agree on that one.

- Lars
