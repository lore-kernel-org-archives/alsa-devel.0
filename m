From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v3][RESEND] media: i2c: tda1997: replace codec to component
Date: Mon, 23 Apr 2018 13:59:32 -0700
Message-ID: <CAJ+vNU35TfSLRYnkEYMkMQVC9r+XHt_pa-=+s4Dro3b-VNGULA@mail.gmail.com>
References: <87in8ibrql.wl%kuninori.morimoto.gx@renesas.com>
 <CAJ+vNU0mykhkMNNrN=Zsrj0_pv=XAkGiiQkXehQ4EWBkMDAv7w@mail.gmail.com> <20180423165213.GL19834@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423165213.GL19834@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, linux-media <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 23, 2018 at 9:52 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 23, 2018 at 09:44:17AM -0700, Tim Harvey wrote:
>
>> Could you add some detail to the commit explaining why we need to
>> replace codec to component? I don't really know what that means.
>> Please refer to a commit if the ASoC API is changing in some way we
>> need to catch up with.
>
> This is a big transition in the ASoC API which is nearing completion -
> this driver is one of the last users of the CODEC struct, we've (well,
> mainly Morimoto-san) been migrating things away from it to the more
> general purpose component.  There's no one commit to point at really as
> the two have coexisted for a while and we won't be able to finally
> remove the CODEC struct until all the drivers have transitioned away.

Mark,

Ok - thanks for the explanation!

Kuninori,

Sorry this took so long to get to. Tested on a GW5404

Tested-by: Tim Harvey <tharvey@gateworks.com>
Acked-by: Tim Harvey <tharvey@gateworks.com>

Regards,

Tim
