From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH 06/10] ASoC: wm8940: Convert to
	snd_soc_cache_sync
Date: Thu, 6 Oct 2011 19:33:29 +0800
Message-ID: <CAF+7xWnWaPB8JKepUoGmvpVw6W6pJPVNkXAdy9GTD2rf9QDUNQ@mail.gmail.com>
References: <1317881417.13399.1.camel@phoenix>
	<1317881863.13399.10.camel@phoenix> <4E8D90E9.5060208@cam.ac.uk>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EF715103810
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Oct 2011 13:33:51 +0200 (CEST)
Received: by eyh5 with SMTP id 5so2570616eyh.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Oct 2011 04:33:50 -0700 (PDT)
In-Reply-To: <4E8D90E9.5060208@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

>> +static int wm8940_volatile_register(struct snd_soc_codec *codec,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsign=
ed int reg)
>> +{
>> + =A0 =A0 switch (reg) {
>> + =A0 =A0 case WM8940_SOFTRESET:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +}
> I guess this makes sense from point of view of keeping things inline with
> more complex drivers. =A0Otherwise I'd expect to see something like:
> {
> =A0 =A0 =A0 =A0return !!(reg =3D=3D WM894_SOFTRESET);
> }

Either is ok to me.
But current syntax makes it easier to add more registers to be volatile
if necessary.

So I'll let Mark decide if I need to send a v2 for changing this.

Regards,
Axel
