From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
 register DMIC routes seperatly
Date: Mon, 10 Mar 2014 09:18:50 +0100
Message-ID: <531D756A.6000505@metafoo.de>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
 <531D7427.5020006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F176264F29
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 09:18:14 +0100 (CET)
In-Reply-To: <531D7427.5020006@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 09:13 AM, Peter Ujfalusi wrote:
> Hi,
>
> On 03/08/2014 08:16 PM, Lars-Peter Clausen wrote:
>> When using table based DAPM setup there is no need to register DAPM elements for
>> different sub-components separately. The widgets will be registered before the
>> first sub-component is initialized, the routes are only added after the last
>> sub-component has been initialized, meaning everything will be available when it
>> is needed.
>
> The reason why we add the DMIC routes in the way we do is that not all boards
> have DMIC in use. PandaBoards does not have DMIC while SDP/Blaze have. On
> PandaBoard we do not register the dmic dai link so the widgets are not going
> to be added and also the dmic DAI and codec will be not loaded on PandaBoards.
> I think this will cause some warning because of missing "DMic" widget?
>

Hm, ok, missed that part. Makes sense. I'll respin the patch to just use the 
card's DAPM context when registering the DMIC DAPM routes.

- Lars
