From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [RFC PATCH] ASoC: au1x: platform driver
	restructuring
Date: Sat, 13 Jun 2009 22:17:15 +0200
Message-ID: <f861ec6f0906131317tc0fff56k173e0bd17765b500@mail.gmail.com>
References: <4A33BEF0.6020602@gmail.com> <20090613174424.GA19484@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EBB024390
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 22:17:16 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2787439bwz.32
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2009 13:17:15 -0700 (PDT)
In-Reply-To: <20090613174424.GA19484@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 13, 2009 at 7:44 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jun 13, 2009 at 05:00:00PM +0200, Manuel Lauss wrote:
>
>> -static int au1xpsc_ac97_suspend(struct snd_soc_dai *dai)
>> +static int au1xpsc_ac97_suspend(struct platform_device *pdev, pm_messag=
e_t m)
>> =A0{
>> =A0 =A0 =A0 /* save interesting registers and disable PSC */
>> =A0 =A0 =A0 au1xpsc_ac97_workdata->pm[0] =3D
>> @@ -328,7 +366,7 @@ static int au1xpsc_ac97_suspend(struct snd_soc_dai *=
dai)
>> =A0 =A0 =A0 return 0;
>> =A0}
>
> I'm don't think this is a good idea - it will remove any sequencing
> between the suspend of the various ASoC device components, meaning that
> the AC97 controller could suspend before the rest of ASoC. =A0This would

Reverted back,

> One other thing I'd say is that before registering the DAIs you should
> assign the dev field in the DAI structure to be the struct device that
> was used to probe the DAI.

Done.

This patch unfortunately breaks PM (no sound after suspend-to-ram), so
may take a while until I resend.

Thank you!
        Manuel Lauss
