From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: soc-core: add
	snd_soc_add_component()
Date: Thu, 28 Sep 2017 11:17:48 +0300
Message-ID: <CAEnQRZBeqi4ibXUCM27TZfK=vCnPVChHXSQEwQmtuaj5WPgq0Q@mail.gmail.com>
References: <87k20jvh00.wl%kuninori.morimoto.gx@renesas.com>
 <87h8vnvgxk.wl%kuninori.morimoto.gx@renesas.com>
 <CAEnQRZD=ZtdYT_SHDp6R=j2Q8ShkXoJvnUQLc2p=CYPL_ewiuQ@mail.gmail.com>
 <87a81fuu7j.wl%kuninori.morimoto.gx@renesas.com>
 <CAEnQRZDhnQgZPiajEudoB0QQDHU4KTrBKp7mZdd4Ot71MPcYBQ@mail.gmail.com>
 <878tgzutyx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id B42C326734C
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 10:17:49 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id q124so745671wmb.5
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 01:17:49 -0700 (PDT)
In-Reply-To: <878tgzutyx.wl%kuninori.morimoto.gx@renesas.com>
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

On Thu, Sep 28, 2017 at 11:15 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Daniel
>
>> >> > +       component = kzalloc(sizeof(*component), GFP_KERNEL);
>> >> > +       if (!component) {
>> >> > +               dev_err(dev, "ASoC: Failed to allocate memory\n");
>> >> > +               return -ENOMEM;
>> >>
>> >> No need to print an error message if kzalloc fails. The core will print it.
>> >
>> > Thanks. Yes I had noticed this warning from checkpatch.
>> > The main purpose of this patch is separate "register" function into
>> > "register" and "add".
>> > Thus, I keeped existing all code.
>> > I think "remove unneeded message" should be increment patch,
>> > but can you agree ?
>>
>> Makes sense. It's better to be sent as a separate patch.
>
> Thanks.
> If you have no objection, I will post it if this patch was accepted.
> Or do you do this ?

Lets have this patch reviewed & pushed and then will see. It's
not that important.
