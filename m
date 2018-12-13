From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7 v2] ASoC: merge audio-graph-scu into
 audio-graph - final step
Date: Thu, 13 Dec 2018 08:05:07 -0800
Message-ID: <20181213160507.GR39861@atomide.com>
References: <87ftv22p6q.wl-kuninori.morimoto.gx@renesas.com>
 <20181213030219.GJ39861@atomide.com>
 <20181213033750.GK39861@atomide.com>
 <87zhta14la.wl-kuninori.morimoto.gx@renesas.com>
 <20181213043445.GL39861@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muru.com (muru.com [72.249.23.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AF4C26789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 17:05:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20181213043445.GL39861@atomide.com>
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

* Tony Lindgren <tony@atomide.com> [181212 20:34]:
> No idea why audio no longer works.. It's like clocks suddenly don't work
> or as if something was still mapped to a wrong codec.

OK found out that loading my WIP codec driver related
modules automatically on boot does not work. And
loading the modules manually after boot works.. So
it seems to be some -EPROBE_DEFER type issue somewhere
unrelated to the graph changes and I was able to test
this series.

Patches 1 & 3 work just great for me now, I'll
reply separately with my acks for those two.

Thanks,

Tony
