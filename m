From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: am335x+tlv320aic3x
Date: Tue, 9 Sep 2014 09:57:36 +0300
Message-ID: <540EA4E0.90209@ti.com>
References: <CAPhDKbHgUcCWsdc7peSe7UdWdu68sqfObcP_fQw7bWPxJhZEPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id C45212625FE
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 08:57:40 +0200 (CEST)
In-Reply-To: <CAPhDKbHgUcCWsdc7peSe7UdWdu68sqfObcP_fQw7bWPxJhZEPg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ilya Dmitrichenko <errordeveloper@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/09/2014 03:33 AM, Ilya Dmitrichenko wrote:
> Hi List,
> =

> I am trying to get Beaglebone workign with the audio extension board
> (aka cape) that is using tlv320aic3x codec. I want it to run 3.14 and
> use vanilla kernel without dynamic DT overlay patches.
> =

> So I have take the current overlay DT [1] and made converted it [2].
> The result is that it boots and detects the Davinci module, but
> doesn't get the codec.
> =

> [1]: https://github.com/beagleboard/devicetree-source/blob/d46bcc20ef98d6=
9eea34cd6ae3897a329559ebb2/arch/arm/boot/dts/BB-BONE-AUDI-01-00A0.dts
> [2]: https://gist.github.com/errordeveloper/cba5145960bdeb0126d5

What is the revision of audio cape you have? The fragment is for RevA, RevB=
 of
the cape is significantly different.

> My kernel config includes this:
> =

> CONFIG_SND_OMAP_SOC=3Dm
> CONFIG_SND_OMAP_SOC_MCBSP=3Dm
> CONFIG_SND_OMAP_SOC_OMAP_TWL4030=3Dm
> CONFIG_SND_SOC_TWL4030=3Dm
> CONFIG_SND_DAVINCI_SOC=3Dm
> CONFIG_SND_AM33XX_SOC_EVM=3Dm
> CONFIG_SND_DAVINCI_SOC_MCASP=3Dm
> CONFIG_SND_HRTIMER=3Dm

You are missing the CONFIG_SND_SOC_TLV320AIC3X

-- =

P=E9ter
