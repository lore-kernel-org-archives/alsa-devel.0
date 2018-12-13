From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/7 v2] ASoC: audio-graph-card: merge
	audio-graph-scu-card
Date: Thu, 13 Dec 2018 08:06:45 -0800
Message-ID: <20181213160645.GT39861@atomide.com>
References: <87ftv22p6q.wl-kuninori.morimoto.gx@renesas.com>
 <87bm5q2p5b.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muru.com (muru.com [72.249.23.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 6705F26789E
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 17:06:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87bm5q2p5b.wl-kuninori.morimoto.gx@renesas.com>
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

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181213 01:36]:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> audio-graph-card and audio-graph-scu-card are very similar driver,
> but the former is supporting normal sound card,
> the latter is supporting DPCM sound card.
> 
> We couldn't use normal sound and DPCM sound in same sound card by
> audio-graph-card.
> This patch merges both sound card into it.
> Now we can use both feature on same driver.

Works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
