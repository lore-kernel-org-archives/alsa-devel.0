From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Sound record on Devkit8000 with DT boot issue
Date: Mon, 11 Feb 2013 19:14:05 +0100
Message-ID: <511934ED.2020104@ti.com>
References: <CABYxbz5ECxoWZtkfL3UbZ=R4LVoNeMVxjYbPdZoarstCod-gQw@mail.gmail.com>
 <5118EF75.30107@ti.com>
 <CABYxbz7HcZTK+y20mtDR+1coRUbUMgNHNDdJ3O7Ln7U7d0LEzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 038822602F9
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 19:14:10 +0100 (CET)
In-Reply-To: <CABYxbz7HcZTK+y20mtDR+1coRUbUMgNHNDdJ3O7Ln7U7d0LEzA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anil Kumar <anilk4.v@gmail.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, tiwai@suse.de, thomas@tomweber.eu
List-Id: alsa-devel@alsa-project.org

Hi,

On 02/11/2013 06:58 PM, Anil Kumar wrote:
>> Here you should have something like:
>> ti,audio-routing =3D
>>         "Ext Spk", "PREDRIVEL",
>>         "Ext Spk", "PREDRIVER",
>>         "MAINMIC", "Main Mic",
>>         "Main Mic", "Mic Bias 1";
>>
>> So you connect the MicBias1 to Main Mic. When you start playback MicBias=
1 will
>> be turned on for you.
> =

> I tried with this routing (next-20130211 tag kernel). But it is not
> working for me.
> So i have gone through other board and found snd_soc_dapm_route for
> =

> 1) zoom2.c
>        {"MAINMIC", NULL, "Mic Bias 1"},
>        {"Mic Bias 1", NULL, "Ext Mic"},
> =

> 2) omap3pandora.c
>         {"MAINMIC", NULL, "Mic Bias 1"},
>         {"Mic Bias 1", NULL, "Mic (internal)"},
> =

> But for omap-twl4030.c it is
>         {"MAINMIC", NULL, "Main Mic"},
>         {"Main Mic", NULL, "Mic Bias 1"},
> =

>  It Should will be as ?
>         {"MAINMIC", NULL, "Mic Bias 1"},
>         {"Mic Bias 1", NULL, "Main Mic"},
> =

> Because with this i am able to get audio on Devkit8000 as
>              ti,audio-routing =3D
>                         "Ext Spk", "PREDRIVEL",
>                         "Ext Spk", "PREDRIVER",
>                         "MAINMIC", "Mic Bias 1",
>                         "Mic Bias 1", "Main Mic";

In 3.9 this should not work...

linux-next should not have zoom2 at least and I converted the machine drive=
rs
as well in regards to micbias handling:
e04d6e5 ASoC: twl4030: Convert MICBIAS to SUPPLY widget
57d61b9 ASoC: OMAP: Remove obsolete machine drivers for Zoom2 and SDP3430

-- =

P=E9ter
