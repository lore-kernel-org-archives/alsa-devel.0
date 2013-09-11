From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2][RFC] ASoC: simple-card: add Device
	Tree support
Date: Tue, 10 Sep 2013 21:52:12 -0300
Message-ID: <CAOMZO5A7jByAmXKp6=gy+oJRcCzhGXyn7sT=zpK+crqpiiTWiA@mail.gmail.com>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87eh94xab2.wl%kuninori.morimoto.gx@renesas.com>
 <87d2ooxa9o.wl%kuninori.morimoto.gx@renesas.com>
 <87ob80i45a.wl%kuninori.morimoto.gx@renesas.com>
 <87li34i41w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f41.google.com (mail-vb0-f41.google.com
 [209.85.212.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1577F261A4D
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 02:52:13 +0200 (CEST)
Received: by mail-vb0-f41.google.com with SMTP id g17so5814550vbg.0
 for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2013 17:52:13 -0700 (PDT)
In-Reply-To: <87li34i41w.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 10, 2013 at 9:40 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:

> +       simple-audio,codec {
> +               sound-dai = <&ak4648>;
> +               bitclock-master;
> +               frame-master;
> +               system-clock-frequency = <11289600>;

Wouldn't it be better to pass a real clock here instead?
