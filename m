From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 50/54 v2] ASoC: switch over to use
 snd_soc_register_component() on tegra20 ac97
Date: Thu, 21 Mar 2013 11:20:50 -0600
Message-ID: <514B4172.5080501@wwwdotorg.org>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpca2z.wl%kuninori.morimoto.gx@renesas.com>
 <514B3D68.9080104@wwwdotorg.org> <1363886347.1846.10.camel@antimon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F1DA26600E
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 18:20:54 +0100 (CET)
In-Reply-To: <1363886347.1846.10.camel@antimon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <dev@lynxeye.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2013 11:19 AM, Lucas Stach wrote:
> Am Donnerstag, den 21.03.2013, 11:03 -0600 schrieb Stephen Warren:
>> On 03/21/2013 04:37 AM, Kuninori Morimoto wrote:
>>
>> Lucas, can you please test this to make sure that the change from
>> snd_soc_register_dais() to snd_soc_register_dai() (the latter inside
>> snd_soc_register_component()) coupled with the change to the
>> tegra_wm9712.c machine driver yields the correct results. Thanks.
>
> Can someone please FWD me the whole patch? I'm not subscribed to
> ALSA-devel and wasn't on CC for this patch.

I'll do that off-list.
