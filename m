From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 0/2][RFC] snd_soc_codec include
	snd_soc_component
Date: Tue, 03 Sep 2013 13:26:50 +0200
Message-ID: <5225C77A.6030706@metafoo.de>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <878uzellkb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-245.synserver.de (smtp-out-246.synserver.de
 [212.40.185.246])
 by alsa0.perex.cz (Postfix) with ESMTP id AF48526168D
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2013 13:32:35 +0200 (CEST)
In-Reply-To: <878uzellkb.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/03/2013 03:51 AM, Kuninori Morimoto wrote:
> 
> Hi Mark, Lars
> 
> # Am I missed sending email ??
> # This is re-try

I got the mails from the first try as well.

> 
> This is 2nd version of codec <-> component merge patch.
> Basically, 1st patch is almost same as v1 version,
> but the differences are...
>  - "component" moves to upside of "codec" (to avoid extra declaration)
>  - register_component had "allow_single_dai" flag
>    to control dai/dais function.
>    Now, we can keep codec dai name
> 
> 2nd patch adds component_driver on wm8978 (as trial).
> It is not needed at this point, since current component doesn't
> check whether component_driver was NULL.
> But we will need/use it in the future.
> 
> What do you think about this series ?

Looks good to me. I think the only thing missing is a call to
snd_soc_component_unregister() from snd_soc_codec_unregister().

> I can send "use component" patch for all codecs
> if you want me it.

While nice to have I don't think it is a requirement to do this before we
can continue with the changes to the core. So if you want to do it go for
it, but it's also not a problem if it is not done.

- Lars
