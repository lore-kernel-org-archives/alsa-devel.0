From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH 1/4] ASoC: Add TI tlv320aic32x4 codec
	support.
Date: Tue, 1 Mar 2011 08:59:23 +0100
Message-ID: <AANLkTinjj8rZS_Y9qiHbrU2nAYSXTikTNtyU71Bk7UqL@mail.gmail.com>
References: <1298641370-17461-1-git-send-email-javier.martin@vista-silicon.com>
	<20110228150014.GI13869@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F02424728
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 08:59:26 +0100 (CET)
Received: by iwc10 with SMTP id 10so4269738iwc.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 23:59:24 -0800 (PST)
In-Reply-To: <20110228150014.GI13869@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
thank you for your review. I will try to solve every issue you pointed out.

Regarding non-default configurations:

>> +static const struct aic32x4_configs aic32x4_reg_init[] =3D {
>> + =A0 =A0 {AIC32X4_PWRCFG, AIC32X4_AVDDWEAKDISABLE},
>
> What are these "aic32x4_configs" all about? =A0They look like you're
> setting non-default configurations...

This tlv320aic32x4 codec is kind of a huge monster; it has more than
200 registers which provide more flexibility than it is needed.
For example, BCLK and MCLK are forced here to derive from internal PLL
which is needed for frequency calculation table to be valid. Bypassing
this PLL doesn't provide new or better functionality.
The same happens regarding DAC internal connections. I don't think
allowing the user to swap left and right channels makes sense here.

-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
