From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
 register DMIC routes seperatly
Date: Mon, 10 Mar 2014 10:24:49 +0100
Message-ID: <531D84E1.8050706@metafoo.de>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
 <531D7427.5020006@ti.com> <531D756A.6000505@metafoo.de>
 <20140310091250.GD28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1C3265200
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 10:24:12 +0100 (CET)
In-Reply-To: <20140310091250.GD28112@sirena.org.uk>
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

On 03/10/2014 10:12 AM, Mark Brown wrote:
> On Mon, Mar 10, 2014 at 09:18:50AM +0100, Lars-Peter Clausen wrote:
>
>> Hm, ok, missed that part. Makes sense. I'll respin the patch to just
>> use the card's DAPM context when registering the DMIC DAPM routes.
>
> In general anything keying this stuff off DT is going to have that sort
> of thing going on - most if not all of the things that are registering
> in several chunks are doing so because some of it is conditional.
>

Before we had the support for card table based setup you'd had to register 
them in chunks, because the components became available one after another 
and you couldn't register DAPM elements for one component in the callback of 
another one. When using the table based setup the widgets are registered 
before all components are registered and the routes are registered after all 
the components have been registered.
