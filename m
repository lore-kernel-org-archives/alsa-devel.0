From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH 0/19] ASoC: rsnd: new module path method
 and DT support
Date: Mon, 10 Mar 2014 16:28:55 +0000
Message-ID: <20140310162855.GK4400@trinity.fluff.org>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
 by alsa0.perex.cz (Postfix) with ESMTP id D3835265772
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 17:28:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 24, 2014 at 10:13:57PM -0800, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> These are Renesas R-Car sound driver patches.
> #1 - #7 are clean up patches.
> #8 - #18 adds new module path method
> #19 adds DT support
> 
> Now, Mark's ALSA branch doesn't include SH-ARM platform branch.
> Thus, these patches are keeping compatible for it at this point.
> Compatible code will be removed after merge.

I've merged the rcar branch that Mark Brown has pushed out, which has
all of these except #19 and have been trying to get it to work.

I am currently seeing issues where the CODEC fails to start, thus there
is no audio produced due to no audio bit or word clocks on the I2S bus
(the CODEC is the clock master).

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
