From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7 v2] ASoC: simple-card-utils: care
 endpoint reg for asoc_simple_card_get_dai_id()
Date: Thu, 13 Dec 2018 08:06:03 -0800
Message-ID: <20181213160603.GS39861@atomide.com>
References: <87ftv22p6q.wl-kuninori.morimoto.gx@renesas.com>
 <87efam2p5t.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muru.com (muru.com [72.249.23.125])
 by alsa0.perex.cz (Postfix) with ESMTP id AACBC26789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 17:06:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87efam2p5t.wl-kuninori.morimoto.gx@renesas.com>
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

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181213 01:35]:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit b6f3fc005a2c8 ("ASoC: simple-card-utils: fixup
> asoc_simple_card_get_dai_id() counting") fixuped getting DAI ID
> method. But, we need to consider about endpoint case, too.
> This patch fixup it.

Works for my test case now thanks:

Tested-by: Tony Lindgren <tony@atomide.com>
