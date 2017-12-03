From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add tfa9879
	device
Date: Sun, 3 Dec 2017 21:53:58 +0100
Message-ID: <5ec7ae30-eeac-3cf8-15ad-f6c3a110c5d7@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
 <20171201224425.5477-2-peda@axentia.se>
 <CAOMZO5BA2ZbBnPVORALkEGV21j7H9GJW_2uVvtEEU=8qM599-w@mail.gmail.com>
 <8e295c61-089e-170d-bca2-42ded2021c99@axentia.se>
 <CAOMZO5AE++an6MnagrWoL4qwkDJaqtg_qJ5UKX3PB7sw1cTeiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40099.outbound.protection.outlook.com [40.107.4.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FDFD26710B
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 21:54:05 +0100 (CET)
In-Reply-To: <CAOMZO5AE++an6MnagrWoL4qwkDJaqtg_qJ5UKX3PB7sw1cTeiA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

On 2017-12-03 12:12, Fabio Estevam wrote:
> Hi Peter,
> 
> On Sun, Dec 3, 2017 at 4:59 AM, Peter Rosin <peda@axentia.se> wrote:
> 
>> Right. However, the patch adding that should have been sent to me, the
>> maintainer of the driver. That is carefully recorded in MAINTAINERS. So,
>> forgive me for assuming that nothing had changed in the driver behind my
>> back.
>>
>> Had that patch been sent my way as it should have been, I would have
>> insisted that maintenance of the bindings had been kept together with
>> the maintenance of the driver.
> 
> When I sent this patch ./scripts/get_maintainer.pl did lot list your
> name, so that's why I did not put you on Cc, sorry.
> 
> 4.15-rc1 still does not list you, but linux-next does.

That's funny, because I get the below on both 4.14 and 4.15-rc1. And I
expect the same ever since the driver was added some 3 years ago.

$ scripts/get_maintainer.pl your-patch-from[1].diff | grep Peter
Peter Rosin <peda@axentia.se> (maintainer:NXP TFA9879 DRIVER)

[1] https://patchwork.ozlabs.org/patch/815930/

By the way, scripts/checkpatch.pl on that patch reports
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

> Would you like me to send the following patch so that new binding
> updates go to you?

Naahh, I'll claim it myself, that way I can clean up some nits in the
actual file while at it...

Cheers,
Peter

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9808,6 +9808,7 @@ NXP TFA9879 DRIVER
>  M:     Peter Rosin <peda@axentia.se>
>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/sound/tfa9879.txt
>  F:     sound/soc/codecs/tfa9879*
> 
