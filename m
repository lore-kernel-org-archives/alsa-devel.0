From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [Q] ASoC: What's the real meaning of
	SND_SOC_DAIFMT_NB_NF?
Date: Thu, 23 Feb 2012 16:58:09 +0100
Message-ID: <CACKLOr23+DPp=XZ=RJEPgKYyvw3UOxkWR8xtzYG9Y9NWcicJSg@mail.gmail.com>
References: <CACKLOr1sDSEFCiAsRO-vKrk7f+r=_Ex9irog1NKDmXn7LJFCDw@mail.gmail.com>
	<20120223151934.GB4553@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 48BDB243C0
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 16:58:10 +0100 (CET)
Received: by lago2 with SMTP id o2so761500lag.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 07:58:09 -0800 (PST)
In-Reply-To: <20120223151934.GB4553@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 23 February 2012 16:19, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Feb 23, 2012 at 01:40:40PM +0100, javier Martin wrote:
>
>> As I wasn't sure about the meaning of 'normal' =A0I've dug into the code
>> of some platforms to see what they do. What I've found, however, is
>> that it doesn't seem to be an agreement about it.
>
> It's whatever is standard for the given format - the Wolfson datasheets
> are a pretty good reference, they have clear diagrams.

So, let's see if I understood properly. If I want to configure the
i.MX SSI into standard, I2S format I should do:

dai_format =3D  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF;
snd_soc_dai_set_fmt(cpu_dai, dai_format);

However, this doesn't work with the imx-ssi driver which does the following:
http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/imx-ssi.c#L83

	case SND_SOC_DAIFMT_I2S:
		/* data on rising edge of bclk, frame low 1clk before data */
		strcr |=3D SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
		scr |=3D SSI_SCR_NET;
		if (ssi->flags & IMX_SSI_USE_I2S_SLAVE) {
			scr &=3D ~SSI_I2S_MODE_MASK;
			scr |=3D SSI_SCR_I2S_MODE_SLAVE;
		}
		break;
[...]
	case SND_SOC_DAIFMT_NB_NF:
		strcr &=3D ~SSI_STCR_TFSI;
		strcr |=3D SSI_STCR_TSCKP;
		break;

While initially TFSI bit is set because of I2S flag, it is then
cleared because of the NB_NF.

Does this mean this is a bug then? If it is, I would gladly fix it but
there is at least one platform relying on this misleading behavior
that I can't test:
http://lxr.linux.no/#linux+v3.2.7/sound/soc/imx/wm1133-ev1.c#L81


-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
