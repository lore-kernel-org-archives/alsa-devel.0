From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: ALSA default buffer sizes
Date: Mon, 24 Aug 2009 20:38:15 +0200
Message-ID: <21ed1c370908241138n1fef462eoc636fe21ff444b35@mail.gmail.com>
References: <21ed1c370908221347w3b62b0ado7429382fc01945c3@mail.gmail.com>
	<4A926196.5000705@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id B3CF624457
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 20:38:16 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1616044bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2009 11:38:15 -0700 (PDT)
In-Reply-To: <4A926196.5000705@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

>> The question is, who is the entity deciding those default values ?
>
> snd_pcm_hw_params_choose() in alsa-lib/src/pcm/pcm_params.c:
> /* Choose one configuration from configuration space defined by PARAMS
> =A0 The configuration chosen is that obtained fixing in this order:
> =A0 first access
> =A0 first format
> =A0 first subformat
> =A0 min channels
> =A0 min rate
> =A0 min period time
> =A0 max buffer size
> =A0 min tick time
> */

Thanks, that information is really helpful. But why would it be a good
idea to pick to lowest period time ?
Maybe a given soundcard is able to do 4 byte periods and all those low
delay freaks will just start drooling
because of that fact, but obviously with a high interrupt trigger
rate, thus consuming more CPU. But OK,
if you want low delay, you gotta pay for that.
The fact that a soundcard is capable of doing that extreme low delay
setting, does not necessarily mean
that I want to favor that. Keep it mind that not every machine is a
x86 with 3GHz.

Can anyone tell me why choosing the smallest period size by default is
a good idea ?
Maybe it would be good to know inside the driver that the user program
does not actually care about the
period time?

The problem is, as far as I understand right now, I would have to
increase the minimum period time of the
au88x0 driver, to get a reasonable setting for audacious, but that
would limit the low delay capabilities for other
applications that might do somewhat smarter buffer settings.

As a work around, maybe I could set the minimum period bytes to 0, and
if I encounter that value
at snd_pcm_xxx_hw_params(), override that value with something useable
and reasonable ? For an mp3
player, period sizes below 576 audio samples would not make any sense
either, so I would prefer 1024
frames rather than 1.

> au88x0_pcm.c has period_bytes_min =3D 0x1 and periods_max =3D 32.
>
> Is that periods_max an actual hardware limit?

No. I considered that anything beyond 32 is just plain stupid :) The
case for period_bytes_min =3D 0x1 is only
valid for 8 bits mono audio of course. I think that needs to be changed.

Best Regards,
Manuel
