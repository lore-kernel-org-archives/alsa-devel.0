From: Jinyoung Park <mcjin02@gmail.com>
Subject: errors in wm8990 codec driver
Date: Thu, 30 Apr 2009 14:03:03 +0900
Message-ID: <280b69ac0904292203y11c100f8m658a3579c33e8534@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id C00181038A3
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 07:03:04 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so1057160yxn.2
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 22:03:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I found a number of typing errors in wm8990 codec driver.
The mis-typing exist in dapm controller definitions and dapm route definiti=
ons,
so happen mis-matched error when snd_soc_dapm_add_routes().
Belows are my modified code. Please check...

Thanks.


diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index cedf3f9..ddc328e 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -729,7 +729,7 @@ SND_SOC_DAPM_MIXER_E("INMIXL", WM8990_INTDRIVBITS,
WM8990_INMIXL_P
=A0=A0=A0=A0=A0=A0=A0 inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_P=
OST_PMD),

=A0/* AINLMUX */
-SND_SOC_DAPM_MUX_E("AILNMUX", WM8990_INTDRIVBITS, WM8990_AINLMUX_PWR_BIT, =
0,
+SND_SOC_DAPM_MUX_E("AINLMUX", WM8990_INTDRIVBITS, WM8990_AINLMUX_PWR_BIT, =
0,
=A0=A0=A0=A0=A0=A0=A0 &wm8990_dapm_ainlmux_controls, inmixer_event,
=A0=A0=A0=A0=A0=A0=A0 SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),

@@ -740,7 +740,7 @@ SND_SOC_DAPM_MIXER_E("INMIXR", WM8990_INTDRIVBITS,
WM8990_INMIXR_P
=A0=A0=A0=A0=A0=A0=A0 inmixer_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_P=
OST_PMD),

=A0/* AINRMUX */
-SND_SOC_DAPM_MUX_E("AIRNMUX", WM8990_INTDRIVBITS, WM8990_AINRMUX_PWR_BIT, =
0,
+SND_SOC_DAPM_MUX_E("AINRMUX", WM8990_INTDRIVBITS, WM8990_AINRMUX_PWR_BIT, =
0,
=A0=A0=A0=A0=A0=A0=A0 &wm8990_dapm_ainrmux_controls, inmixer_event,
=A0=A0=A0=A0=A0=A0=A0 SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),

@@ -848,40 +848,40 @@ static const struct snd_soc_dapm_route audio_map[] =
=3D {
=A0=A0=A0=A0=A0=A0=A0 {"LIN12 PGA", "LIN2 Switch", "LIN2"},
=A0=A0=A0=A0=A0=A0=A0 /* LIN34 PGA */
=A0=A0=A0=A0=A0=A0=A0 {"LIN34 PGA", "LIN3 Switch", "LIN3"},
-=A0=A0=A0=A0=A0=A0 {"LIN34 PGA", "LIN4 Switch", "LIN4"},
+=A0=A0=A0=A0=A0=A0 {"LIN34 PGA", "LIN4 Switch", "LIN4/RXN"},
=A0=A0=A0=A0=A0=A0=A0 /* INMIXL */
=A0=A0=A0=A0=A0=A0=A0 {"INMIXL", "Record Left Volume", "LOMIX"},
=A0=A0=A0=A0=A0=A0=A0 {"INMIXL", "LIN2 Volume", "LIN2"},
=A0=A0=A0=A0=A0=A0=A0 {"INMIXL", "LINPGA12 Switch", "LIN12 PGA"},
=A0=A0=A0=A0=A0=A0=A0 {"INMIXL", "LINPGA34 Switch", "LIN34 PGA"},
-=A0=A0=A0=A0=A0=A0 /* AILNMUX */
-=A0=A0=A0=A0=A0=A0 {"AILNMUX", "INMIXL Mix", "INMIXL"},
-=A0=A0=A0=A0=A0=A0 {"AILNMUX", "DIFFINL Mix", "LIN12PGA"},
-=A0=A0=A0=A0=A0=A0 {"AILNMUX", "DIFFINL Mix", "LIN34PGA"},
-=A0=A0=A0=A0=A0=A0 {"AILNMUX", "RXVOICE Mix", "LIN4/RXN"},
-=A0=A0=A0=A0=A0=A0 {"AILNMUX", "RXVOICE Mix", "RIN4/RXP"},
+=A0=A0=A0=A0=A0=A0 /* AINLMUX */
+=A0=A0=A0=A0=A0=A0 {"AINLMUX", "INMIXL Mix", "INMIXL"},
+=A0=A0=A0=A0=A0=A0 {"AINLMUX", "DIFFINL Mix", "LIN12 PGA"},
+=A0=A0=A0=A0=A0=A0 {"AINLMUX", "DIFFINL Mix", "LIN34 PGA"},
+=A0=A0=A0=A0=A0=A0 {"AINLMUX", "RXVOICE Mix", "LIN4/RXN"},
+=A0=A0=A0=A0=A0=A0 {"AINLMUX", "RXVOICE Mix", "RIN4/RXP"},
=A0=A0=A0=A0=A0=A0=A0 /* ADC */
-=A0=A0=A0=A0=A0=A0 {"Left ADC", NULL, "AILNMUX"},
+=A0=A0=A0=A0=A0=A0 {"Left ADC", NULL, "AINLMUX"},

=A0=A0=A0=A0=A0=A0=A0 /* RIN12 PGA */
=A0=A0=A0=A0=A0=A0=A0 {"RIN12 PGA", "RIN1 Switch", "RIN1"},
=A0=A0=A0=A0=A0=A0=A0 {"RIN12 PGA", "RIN2 Switch", "RIN2"},
=A0=A0=A0=A0=A0=A0=A0 /* RIN34 PGA */
=A0=A0=A0=A0=A0=A0=A0 {"RIN34 PGA", "RIN3 Switch", "RIN3"},
-=A0=A0=A0=A0=A0=A0 {"RIN34 PGA", "RIN4 Switch", "RIN4"},
+=A0=A0=A0=A0=A0=A0 {"RIN34 PGA", "RIN4 Switch", "RIN4/RXP"},
=A0=A0=A0=A0=A0=A0=A0 /* INMIXL */
=A0=A0=A0=A0=A0=A0=A0 {"INMIXR", "Record Right Volume", "ROMIX"},
=A0=A0=A0=A0=A0=A0=A0 {"INMIXR", "RIN2 Volume", "RIN2"},
=A0=A0=A0=A0=A0=A0=A0 {"INMIXR", "RINPGA12 Switch", "RIN12 PGA"},
=A0=A0=A0=A0=A0=A0=A0 {"INMIXR", "RINPGA34 Switch", "RIN34 PGA"},
-=A0=A0=A0=A0=A0=A0 /* AIRNMUX */
-=A0=A0=A0=A0=A0=A0 {"AIRNMUX", "INMIXR Mix", "INMIXR"},
-=A0=A0=A0=A0=A0=A0 {"AIRNMUX", "DIFFINR Mix", "RIN12PGA"},
-=A0=A0=A0=A0=A0=A0 {"AIRNMUX", "DIFFINR Mix", "RIN34PGA"},
-=A0=A0=A0=A0=A0=A0 {"AIRNMUX", "RXVOICE Mix", "RIN4/RXN"},
-=A0=A0=A0=A0=A0=A0 {"AIRNMUX", "RXVOICE Mix", "RIN4/RXP"},
+=A0=A0=A0=A0=A0=A0 /* AINRMUX */
+=A0=A0=A0=A0=A0=A0 {"AINRMUX", "INMIXR Mix", "INMIXR"},
+=A0=A0=A0=A0=A0=A0 {"AINRMUX", "DIFFINR Mix", "RIN12 PGA"},
+=A0=A0=A0=A0=A0=A0 {"AINRMUX", "DIFFINR Mix", "RIN34 PGA"},
+=A0=A0=A0=A0=A0=A0 {"AINRMUX", "RXVOICE Mix", "LIN4/RXN"},
+=A0=A0=A0=A0=A0=A0 {"AINRMUX", "RXVOICE Mix", "RIN4/RXP"},
=A0=A0=A0=A0=A0=A0=A0 /* ADC */
-=A0=A0=A0=A0=A0=A0 {"Right ADC", NULL, "AIRNMUX"},
+=A0=A0=A0=A0=A0=A0 {"Right ADC", NULL, "AINRMUX"},

=A0=A0=A0=A0=A0=A0=A0 /* LOMIX */
=A0=A0=A0=A0=A0=A0=A0 {"LOMIX", "LOMIX RIN3 Bypass Switch", "RIN3"},
@@ -922,7 +922,7 @@ static const struct snd_soc_dapm_route audio_map[] =3D {
=A0=A0=A0=A0=A0=A0=A0 {"LOPMIX", "LOPMIX Left Mixer PGA Switch", "LOPGA"},

=A0=A0=A0=A0=A0=A0=A0 /* OUT3MIX */
-=A0=A0=A0=A0=A0=A0 {"OUT3MIX", "OUT3MIX LIN4/RXP Bypass Switch", "LIN4/RXP=
"},
+=A0=A0=A0=A0=A0=A0 {"OUT3MIX", "OUT3MIX LIN4/RXP Bypass Switch", "LIN4/RXN=
"},
=A0=A0=A0=A0=A0=A0=A0 {"OUT3MIX", "OUT3MIX Left Out PGA Switch", "LOPGA"},

=A0=A0=A0=A0=A0=A0=A0 /* OUT4MIX */
@@ -949,7 +949,7 @@ static const struct snd_soc_dapm_route audio_map[] =3D {
=A0=A0=A0=A0=A0=A0=A0 /* Output Pins */
=A0=A0=A0=A0=A0=A0=A0 {"LON", NULL, "LONMIX"},
=A0=A0=A0=A0=A0=A0=A0 {"LOP", NULL, "LOPMIX"},
-=A0=A0=A0=A0=A0=A0 {"OUT", NULL, "OUT3MIX"},
+=A0=A0=A0=A0=A0=A0 {"OUT3", NULL, "OUT3MIX"},
=A0=A0=A0=A0=A0=A0=A0 {"LOUT", NULL, "LOUT PGA"},
=A0=A0=A0=A0=A0=A0=A0 {"SPKN", NULL, "SPKMIX"},
=A0=A0=A0=A0=A0=A0=A0 {"ROUT", NULL, "ROUT PGA"},
