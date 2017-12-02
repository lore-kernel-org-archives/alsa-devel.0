From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/2] Add devicetree for Axentia Nattis
Date: Sat, 2 Dec 2017 08:58:38 +0100
Message-ID: <e9d88ae6-9c2c-d873-ebad-1054d29b5da8@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
 <CABxcv=k6K8gRDSRu1r6=mELcOQLcNr6EOQGj0Q0wDXrGa58sqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0122.outbound.protection.outlook.com [104.47.1.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 25B3C266B67
 for <alsa-devel@alsa-project.org>; Sat,  2 Dec 2017 08:58:47 +0100 (CET)
In-Reply-To: <CABxcv=k6K8gRDSRu1r6=mELcOQLcNr6EOQGj0Q0wDXrGa58sqw@mail.gmail.com>
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
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 2017-12-02 02:05, Javier Martinez Canillas wrote:
> Hello Peter,
> 
> On Fri, Dec 1, 2017 at 11:44 PM, Peter Rosin <peda@axentia.se> wrote:
>> Hi!
>>
>> I'd like to add a devicetree for our Nattis to the kernel. The
>> Nattis is a device for showing departures for public transportation
>> (optionally including a text-to-speech module for the visually
>> impaired).
>>
>> I'm a bit unsure if the tfa9879 sound codec binding is needed,
>> but I suppose it belongs in trivial-devices?
>>
> 
> There's a DT binding for this device now:
> 
> https://patchwork.ozlabs.org/patch/816157/

What do you know, thanks for the hint. I even reviewed a followup
patch for that one, so I guess I should have known...

Anyway, I should probably add a #sound-dai-cells entry. v2 coming up.

Cheers,
peda
