From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 19/54 v2] ASoC: switch over to use
 snd_soc_register_component() on mpc5200 i2s
Date: Mon, 25 Mar 2013 09:58:13 -0600
Message-ID: <51507415.1050100@wwwdotorg.org>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <87boaddox7.wl%kuninori.morimoto.gx@renesas.com>
 <514B3B07.4030309@wwwdotorg.org>
 <87620kfcy4.wl%kuninori.morimoto.gx@renesas.com>
 <514BE645.2050409@wwwdotorg.org>
 <87txo3evtu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id BB1EA26173F
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 16:58:21 +0100 (CET)
In-Reply-To: <87txo3evtu.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/24/2013 06:24 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> Thank you for your checking
> 
>>> arch/powerpc/boot/dts/lite5200.dts seems the user of this driver,
>>> but, it was comment-outed.
>>> And it is using DT, not name matching ?
> (snip)
>> Anyway, as far as I can tell from any of the in-kernel device trees,
>> this particular mpc5200-psc-i2s device isn't actually instantiated
>> anywhere. I guess the only users are removed or out-of-tree.
>>
>> Equally, of those 4 files, the compatible value they're instantiated
>> from doesn't exist in any in-kernel DT files, except for imx-sgtl5000.c,
>> and in that case the CPU phandle points at something the definitely
>> isn't the MPC5200 PSC device.
>>
>> So, I guess this if probably fine...
> 
> In my understanding,
> there are some concerns, but basically it is OK in general?

Yes, I think so.
