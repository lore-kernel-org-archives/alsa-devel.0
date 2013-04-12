From: Stas Sergeev <stsp@list.ru>
Subject: Re: [PATCH] ASoC: define playback and capture streams
 in dummy codec
Date: Fri, 12 Apr 2013 20:37:16 +0400
Message-ID: <20130412203716.0a203b69@stas>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
 <20130412181943.0338083b@stas> <516824B4.20802@gmail.com>
 <51682633.70008@list.ru> <516828C7.5090203@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.mail.ru (smtp4.mail.ru [94.100.176.44])
 by alsa0.perex.cz (Postfix) with ESMTP id A97502616DB
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2013 18:37:35 +0200 (CEST)
In-Reply-To: <516828C7.5090203@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>, stsp@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Apr 2013 17:31:19 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:
> Well, if not explicitly initialized a field is set to 0. Which is kind of the
> most restrictive option for many of the fields. E.g. channels_max, rates,
> formats, etc. When the ASoC core creates a new PCM device it will take the
> intersection of the CPU DAI and CODEC DAI fields to initialize the fields the
> PCM. So if for example channels_max is 0 for the CODEC DAI, channels_max will
> also be 0 for the PCM, no matter what channels_max is set to for the CPU DAI.
> Same goes for formats and rates. So a dummy CODEC should have set its fields in
> a way that it is most permissive, so that the intersection of the CODEC DAI
> fields with the CPU DAI fields will be equal to the CPU DAI fields.
Thanks for an explanation!
But what happens when the DAI is considered mute
by the effect of such intersection?
>From what I can see, no callbacks from the DAI driver
are called in this case (this is expected), but no
error is returned to userspace, and, more importantly,
the playback speed is still correct, so the userspace
can get a playback position as if the playback is fine.
While during the normal playback, if I stop calling
snd_pcm_period_elapsed(), userspace is no longer getting
the right position.
That's why I am confused, I can't easily explain this
"no sound but otherwise fine playback" effect, so I am
a bit reluctant to try explaining this in a commit msg.
Are there are some fallbacks? Such as when the DAI is
considered mute, it gets somehow emulated, with the use
of the system clock for correct timing etc?
