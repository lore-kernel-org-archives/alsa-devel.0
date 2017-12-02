From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 0/2] Add devicetree for Axentia Nattis
Date: Sat, 2 Dec 2017 02:05:22 +0100
Message-ID: <CABxcv=k6K8gRDSRu1r6=mELcOQLcNr6EOQGj0Q0wDXrGa58sqw@mail.gmail.com>
References: <20171201224425.5477-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E1DD2670F4
 for <alsa-devel@alsa-project.org>; Sat,  2 Dec 2017 02:05:23 +0100 (CET)
Received: by mail-io0-f180.google.com with SMTP id s19so13176736ioa.1
 for <alsa-devel@alsa-project.org>; Fri, 01 Dec 2017 17:05:23 -0800 (PST)
In-Reply-To: <20171201224425.5477-1-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hello Peter,

On Fri, Dec 1, 2017 at 11:44 PM, Peter Rosin <peda@axentia.se> wrote:
> Hi!
>
> I'd like to add a devicetree for our Nattis to the kernel. The
> Nattis is a device for showing departures for public transportation
> (optionally including a text-to-speech module for the visually
> impaired).
>
> I'm a bit unsure if the tfa9879 sound codec binding is needed,
> but I suppose it belongs in trivial-devices?
>

There's a DT binding for this device now:

https://patchwork.ozlabs.org/patch/816157/

> Cheers,
> Peter
>

Best regards,
Javier
