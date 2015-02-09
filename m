From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] ASoC: soc-core: call
 snd_soc_remove_card() when component del
Date: Mon, 09 Feb 2015 15:11:36 +0100
Message-ID: <54D8C018.3040201@metafoo.de>
References: <87siefv54e.wl%kuninori.morimoto.gx@renesas.com>	<87mw4nv524.wl%kuninori.morimoto.gx@renesas.com>	<s5hzj8ntl5z.wl-tiwai@suse.de>	<54D8994A.5090906@metafoo.de>	<s5hpp9jtera.wl-tiwai@suse.de>	<54D8B19E.5020303@metafoo.de>
 <s5hoap3tdg3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-225.synserver.de (smtp-out-231.synserver.de
 [212.40.185.231])
 by alsa0.perex.cz (Postfix) with ESMTP id F1E15260411
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 15:11:44 +0100 (CET)
In-Reply-To: <s5hoap3tdg3.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/09/2015 02:35 PM, Takashi Iwai wrote:
[...]
> (BTW, client_mutex doesn't cover the whole places accessing the
>   component_list in soc-core.c.)

Yea, that looks pretty broken, I'll have a look.
