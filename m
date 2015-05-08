From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: codecs-ac97: Remove rate constraints
Date: Fri, 8 May 2015 18:32:00 -0300
Message-ID: <CAOMZO5A=M2oW47r8_MPrxkd9z6kDj6FG68fVAdKAzngPX0mn=Q@mail.gmail.com>
References: <554D27A6.4040602@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554D27A6.4040602@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 8, 2015 at 6:16 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> Remove rate constraints from generic ASoC AC'97 CODEC and make
> it selectable in config.

Shouldn't this be split in two patches?

>
> Supported rates should be detected and constrained anyway by
> AC'97 generic code - was tested with VT1613 CODEC and iMX6 SSI
> controller.

Nice, I would like to test this on a Udoo board. Care to share the dts
changes? (I know this is off topic for this list ;-) Apart from the
dts changes: are there still missing patches in linux-next to make
audio work in Udoo?

> This way this driver can be used for platforms which don't need
> specialized AC'97 CODEC drivers while at the same avoiding
> code duplication from implementing equivalent functionality in
> a controller driver.
>
> Resending due to no response received.

No need to put this in the commit log.

Thanks
