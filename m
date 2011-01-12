From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: Fix resource leak if soc_register_ac97_dai_link failed
Date: Wed, 12 Jan 2011 09:42:52 +0800
Message-ID: <AANLkTinxs8k2-gc03i6H_r0iONh1XtjrH-60dZ-0j+9g@mail.gmail.com>
References: <1291726590.2760.3.camel@phoenix> <AANLkTimkb4ic3G7rT-WiFtFdC+Sy5gVAikoQVXguVH4J@mail.gmail.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimkb4ic3G7rT-WiFtFdC+Sy5gVAikoQVXguVH4J@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> this isnt entirely correct. =A0soc_unregister_ac97_dai_link takes a
> pointer to a codec which card->rtd[i] is not.
> sound/soc/soc-core.c: In function =91snd_soc_instantiate_card=92:
> sound/soc/soc-core.c:1626: warning: passing argument 1 of
> =91soc_unregister_ac97_dai_link=92 from incompatible pointer type
> -mike
>

Ooops. my bad.
I will send a patch for 2.6.37 to fix it.
Thanks for report this bug.

Regards,
Axel
