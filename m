From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [Q] ASoC: What's the real meaning of
	SND_SOC_DAIFMT_NB_NF?
Date: Fri, 24 Feb 2012 12:05:09 +0100
Message-ID: <CACKLOr14EHqGWcYCfLK0WXiVZsewDVyFPV2tpfYJK4tBZKMUXg@mail.gmail.com>
References: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
	<20120223151934.GB4553@opensource.wolfsonmicro.com>
	<CACKLOr23+DPp=XZ=RJEPgKYyvw3UOxkWR8xtzYG9Y9NWcicJSg@mail.gmail.com>
	<20120223161446.GA7245@opensource.wolfsonmicro.com>
	<CACKLOr10yUYpMSrebnLvMkc=XQLUXNDxwM+P6U8ysH_Xre3Tmw@mail.gmail.com>
	<4F474B97.6020407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 59B0424554
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 12:05:10 +0100 (CET)
Received: by obbup6 with SMTP id up6so2645136obb.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 03:05:09 -0800 (PST)
In-Reply-To: <4F474B97.6020407@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On 24 February 2012 09:34, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> On 02/24/2012 09:53 AM, javier Martin wrote:
>> If TFSI bit is 1, frame clock is active high.
>> If TFSI bit is 0, frame clock is active low.
>>
>> In the piece of code I've shown to you, when someone configures
>> (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF) he's really selecting an
>> active high frame clock when the standard says just the opposite
>> (wm8974 datasheet p50).
>
> We had similar issues on OMAP McBSP in the past. If you take a look at
> the omap-mcbsp.c: omap_mcbsp_dai_set_dai_fmt() function we have inv_fs
> variable to handle such a case.
> We do the FS/BCLK configuration only in DAIFMT_INV config phase. The FS
> active level is different in these formats. We invert the FS based on
> the used format (LEFT/RIGHT just, DSP). The DAIFMT_INV switch configures
> according to I2S, but we invert the FS if we are in DSP, Justified modes
> afterwards.

I intend to do something similar for imx-ssi. What keeps me awake is
that there are some other platforms as well that don't respect the
convention.

>>>> there is at least one platform relying on this misleading behavior
>>>> that I can't test:
>>>> http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/wm1133-ev1.c#L81
>>>
>>> That was correct at the time it was written, though the code has changed
>>> since then and I don't know when it was last retested. =A0Of course
>>> depending on the signal it may interoperate well even if the setup isn't
>>> actually correct. =A0I'd just fix the driver and if it works for yours
>>> it's probably OK for that board too.
>>
>> It is not one but two boards that are affected:
>> http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/wm1133-ev1.c#L81
>> http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/eukrea-tlv320.c#L32
>>
>> If I fixed the bug in the SSI I would break both of them, since I
>> would be changing frame clock polarity.
>
> I don't think it is going to break. I would guess that the channels are
> swapped on these machines at the moment. If you correct the CPU dai
> driver the only thing that will happen is that the channels will jump in
> their correct place.

That would be true for stereo. However, mono should not be working right no=
w.

-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
