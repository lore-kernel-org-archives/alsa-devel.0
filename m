From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [Q] ASoC: What's the real meaning of
	SND_SOC_DAIFMT_NB_NF?
Date: Fri, 24 Feb 2012 08:53:11 +0100
Message-ID: <CACKLOr10yUYpMSrebnLvMkc=XQLUXNDxwM+P6U8ysH_Xre3Tmw@mail.gmail.com>
References: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
	<20120223151934.GB4553@opensource.wolfsonmicro.com>
	<CACKLOr23+DPp=XZ=RJEPgKYyvw3UOxkWR8xtzYG9Y9NWcicJSg@mail.gmail.com>
	<20120223161446.GA7245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5B555244FA
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 08:53:13 +0100 (CET)
Received: by lago2 with SMTP id o2so1656290lag.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 23:53:11 -0800 (PST)
In-Reply-To: <20120223161446.GA7245@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On 23 February 2012 17:14, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Feb 23, 2012 at 04:58:09PM +0100, javier Martin wrote:
>
>> So, let's see if I understood properly. If I want to configure the
>> i.MX SSI into standard, I2S format I should do:
>
>> dai_format =3D =A0SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF;
>> snd_soc_dai_set_fmt(cpu_dai, dai_format);
>
> Yes.
>
>> While initially TFSI bit is set because of I2S flag, it is then
>> cleared because of the NB_NF.
>
>> Does this mean this is a bug then? If it is, I would gladly fix it but
>
> I've no idea what any of the register settings mean here...

If TFSI bit is 1, frame clock is active high.
If TFSI bit is 0, frame clock is active low.

In the piece of code I've shown to you, when someone configures
(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF) he's really selecting an
active high frame clock when the standard says just the opposite
(wm8974 datasheet p50).

>> there is at least one platform relying on this misleading behavior
>> that I can't test:
>> http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/wm1133-ev1.c#L81
>
> That was correct at the time it was written, though the code has changed
> since then and I don't know when it was last retested. =A0Of course
> depending on the signal it may interoperate well even if the setup isn't
> actually correct. =A0I'd just fix the driver and if it works for yours
> it's probably OK for that board too.

It is not one but two boards that are affected:
http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/wm1133-ev1.c#L81
http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/eukrea-tlv320.c#L32

If I fixed the bug in the SSI I would break both of them, since I
would be changing frame clock polarity.

Regards.
-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
