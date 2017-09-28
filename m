From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: soc-core: add
	snd_soc_add_component()
Date: Thu, 28 Sep 2017 11:12:54 +0300
Message-ID: <CAEnQRZDhnQgZPiajEudoB0QQDHU4KTrBKp7mZdd4Ot71MPcYBQ@mail.gmail.com>
References: <87k20jvh00.wl%kuninori.morimoto.gx@renesas.com>
 <87h8vnvgxk.wl%kuninori.morimoto.gx@renesas.com>
 <CAEnQRZD=ZtdYT_SHDp6R=j2Q8ShkXoJvnUQLc2p=CYPL_ewiuQ@mail.gmail.com>
 <87a81fuu7j.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id B9F4926734C
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 10:12:55 +0200 (CEST)
Received: by mail-wm0-f51.google.com with SMTP id m72so534257wmc.1
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 01:12:55 -0700 (PDT)
In-Reply-To: <87a81fuu7j.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

>> > +       component = kzalloc(sizeof(*component), GFP_KERNEL);
>> > +       if (!component) {
>> > +               dev_err(dev, "ASoC: Failed to allocate memory\n");
>> > +               return -ENOMEM;
>>
>> No need to print an error message if kzalloc fails. The core will print it.
>
> Thanks. Yes I had noticed this warning from checkpatch.
> The main purpose of this patch is separate "register" function into
> "register" and "add".
> Thus, I keeped existing all code.
> I think "remove unneeded message" should be increment patch,
> but can you agree ?

Makes sense. It's better to be sent as a separate patch.
