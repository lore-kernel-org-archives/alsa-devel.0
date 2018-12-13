From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7 v2] ASoC: merge audio-graph-scu into
 audio-graph - final step
Date: Wed, 12 Dec 2018 20:34:45 -0800
Message-ID: <20181213043445.GL39861@atomide.com>
References: <87ftv22p6q.wl-kuninori.morimoto.gx@renesas.com>
 <20181213030219.GJ39861@atomide.com>
 <20181213033750.GK39861@atomide.com>
 <87zhta14la.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muru.com (muru.com [72.249.23.125])
 by alsa0.perex.cz (Postfix) with ESMTP id EB824267C45
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 05:34:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87zhta14la.wl-kuninori.morimoto.gx@renesas.com>
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

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181213 03:45]:
> But.. Hmm...
> to keep compatibility, use previous style, make sense  ?
> 
> 	if (endpoint had reg)
> 		use it
> 	else if (port had reg)
> 		use it
> 	else
> 		use endpoint count

I guess it that works and is easy to add :) Maybe warn about needing to
add a reg property too?

> > Also audio play does not work for me with these changes  it seems.. My
> > updated codec end snippet below.
> 
> Hmm...

No idea why audio no longer works.. It's like clocks suddenly don't work
or as if something was still mapped to a wrong codec.

Regards,

Tony
