From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH][RFC] ASoC: simple-card-utils: fixup
 asoc_simple_card_get_dai_id() ID method
Date: Thu, 13 Dec 2018 08:42:06 -0800
Message-ID: <20181213164206.GV39861@atomide.com>
References: <87va3y10a0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muru.com (muru.com [72.249.23.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 53E24267C3D
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 17:42:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87va3y10a0.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181213 05:18]:
> commit b6f3fc005a2c8 ("ASoC: simple-card-utils: fixup
> asoc_simple_card_get_dai_id() counting") fixuped getting DAI ID method.
> It will get DAI ID from OF graph "port", but, we want to consider about
> "endpoint", too.
> And, we also want to keep compatibility.
> 
> This patch fixup it as
> 
> 	if (driver has specified DAI ID)
> 		use it as DAI ID
> 	else if (OF graph endpoint has reg)
> 		use it as DAI ID
> 	else if (OF graph port has reg)
> 		use it as DAI ID
> 	else
> 		use endpoint count as DAI ID

Yup I tested this instead of the earlier 1/7 patch
and things work nice for me. I also commented out
reg properties from the codec end and the mapping
worked fine. So please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
