From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: About ALSA SoC cpu/codec asymmetry
Date: Mon, 10 Mar 2014 07:42:28 +0100
Message-ID: <531D5ED4.4090208@metafoo.de>
References: <8738iqst0t.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-129.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id BE54D264F4A
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 07:41:56 +0100 (CET)
In-Reply-To: <8738iqst0t.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 03/10/2014 03:10 AM, Kuninori Morimoto wrote:
>
> Hi Mark, Stephen, Lars
>
> Now, ALSA SoC is using "component" style, and its image is like this.
>
> ALSA SoC
>   - platform
>   - component (as CPU)
>   - codec
>      - component
>
> It is still not symmetry, and confusable.
> I guess this is understandable.
>
> ALSA SoC
>   - platform
>   - cpu
>      - component
>   - codec
>      - component
>
> If we add "cpu", it needs "cpu name", same as current "codec name"
> on soc_bind_dai_link().
> I guess it can keep compatible if it allows "NULL" name on "cpu name" at this point.
> (but print warning ?)

There is already a cpu_name field for the DAI link struct and it is ignored 
when it is NULL. See 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/soc/soc-core.c#n870

I have a patch that makes using cpu_name mandatory for new component 
drivers. And then we can slowly start to convert old platforms.

- Lars
