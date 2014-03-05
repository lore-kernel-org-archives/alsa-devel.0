From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs4271: Fix build error without
 CONFIG_SPI_MASTER
Date: Wed, 5 Mar 2014 11:03:59 -0600
Message-ID: <alpine.DEB.2.02.1403051103261.16441@heelrod>
References: <1394038411-11045-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1282489265-1394039040=:16441"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 38F7E2650FE
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 18:03:58 +0100 (CET)
In-Reply-To: <1394038411-11045-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

--8323329-1282489265-1394039040=:16441
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2014, Takashi Iwai wrote:

> cs4271_common_probe() is called from cs4271_i2c_probe() but defined in
> CONFIG_SPI_MASTER block, thus it results in a build error when
> CONFIG_SPI_MASTER=3Dn:
>  sound/soc/codecs/cs4271.c:721:2: error: implicit declaration of functi=
on =E2=80=98cs4271_common_probe=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
>
> Move the function out of #if block.
>
> Fixes: d6cf89ee07cb ('ASoC: cs4271: claim reset GPIO in bus probe funct=
ion')
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>

--8323329-1282489265-1394039040=:16441
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-1282489265-1394039040=:16441--
