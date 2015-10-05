From: Axel Lin <axel.lin@ingics.com>
Subject: Re: Regarding ASoC: rt286: Fix the runtime error in
	the booting
Date: Mon, 5 Oct 2015 18:16:55 +0800
Message-ID: <CAFRkauDA93VtV7pcjxkMs4JRD+eUYT53D6OyDP6gHyaMtRh0xg@mail.gmail.com>
References: <1444039739.8819.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D6CD2604A4
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 12:16:56 +0200 (CEST)
Received: by lbbwt4 with SMTP id wt4so17323210lbb.1
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2015 03:16:56 -0700 (PDT)
In-Reply-To: <1444039739.8819.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -       rt286->index_cache = rt286_index_def;
>         rt286->index_cache_size = INDEX_CACHE_SIZE;
> +       rt286->index_cache = devm_kmalloc(&i2c->dev, INDEX_CACHE_SIZE,
> +                                         GFP_KERNEL);
Should be devm_kmalloc(&i2c->dev, sizeof(rt286_index_def), GFP_KERNEL);
