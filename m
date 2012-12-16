From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] ASoC: cs42l52: Fix off-by-one boundary
	checking for cs42l52_get_clk()
Date: Sun, 16 Dec 2012 22:10:21 +0800
Message-ID: <CAFRkauDst+DJ-wJ51s5Ef_F7fFTmrXUQwMiFGEO6csOLzkADtA@mail.gmail.com>
References: <1355623889.9994.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 91AEC260728
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2012 15:10:23 +0100 (CET)
Received: by mail-pb0-f51.google.com with SMTP id ro12so3020901pbb.38
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2012 06:10:22 -0800 (PST)
In-Reply-To: <1355623889.9994.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2012/12/16 Axel Lin <axel.lin@ingics.com>

> The caller uses the return value of cs42l52_get_clk as array index,
> the valid array index is 0 .. ARRAY_SIZE(clk_map_table) - 1.
> Thus we need to ensure ret is less than ARRAY_SIZE(clk_map_table).
>

Just check the code again, ret is always less than ARRAY_SIZE -1.
I think what we missed here is the case no rate is matched.

Axel
