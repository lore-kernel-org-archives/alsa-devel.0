From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] ASoC: OMAP3 Pandora: update for TWL4030
	codec changes
Date: Wed, 18 Nov 2009 12:12:38 +0200
Message-ID: <6ed0b2680911180212u563518c5of93ca0a0da9a320e@mail.gmail.com>
References: <1257628572-6049-1-git-send-email-notasas@gmail.com>
	<1257712277.15162.3.camel@vega>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 41F2D10392A
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 11:12:39 +0100 (CET)
Received: by fxm1 with SMTP id 1so2298116fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 02:12:39 -0800 (PST)
In-Reply-To: <1257712277.15162.3.camel@vega>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 8, 2009 at 10:31 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Sat, 2009-11-07 at 23:16 +0200, Grazvydas Ignotas wrote:
>> A while ago TWL4030 had it's playback stream name changed, but
>> pandora needs it for it's playback path. Update to correct stream
>> name so that playback works again.
>>
>> Also mark VIBRA output as not connected.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>> =A0sound/soc/omap/omap3pandora.c | =A0 =A03 ++-
>> =A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora=
.c
>> index ad219aa..0cd06f5 100644
>> --- a/sound/soc/omap/omap3pandora.c
>> +++ b/sound/soc/omap/omap3pandora.c
>> @@ -134,7 +134,7 @@ static int omap3pandora_hp_event(struct snd_soc_dapm=
_widget *w,
>> =A0 * =A0|P| <--- TWL4030 <--------- Line In and MICs
>> =A0 */
>> =A0static const struct snd_soc_dapm_widget omap3pandora_out_dapm_widgets=
[] =3D {
>> - =A0 =A0 SND_SOC_DAPM_DAC("PCM DAC", "Playback", SND_SOC_NOPM, 0, 0),
>> + =A0 =A0 SND_SOC_DAPM_DAC("PCM DAC", "HiFi Playback", SND_SOC_NOPM, 0, =
0),
>> =A0 =A0 =A0 SND_SOC_DAPM_PGA_E("Headphone Amplifier", SND_SOC_NOPM,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, 0, NULL, 0, omap3p=
andora_hp_event,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SOC_DAPM_POST_PMU=
 | SND_SOC_DAPM_PRE_PMD),
>> @@ -181,6 +181,7 @@ static int omap3pandora_out_init(struct snd_soc_code=
c *codec)
>> =A0 =A0 =A0 snd_soc_dapm_nc_pin(codec, "CARKITR");
>> =A0 =A0 =A0 snd_soc_dapm_nc_pin(codec, "HFL");
>> =A0 =A0 =A0 snd_soc_dapm_nc_pin(codec, "HFR");
>> + =A0 =A0 snd_soc_dapm_nc_pin(codec, "VIBRA");
>>
>> =A0 =A0 =A0 ret =3D snd_soc_dapm_new_controls(codec, omap3pandora_out_da=
pm_widgets,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(o=
map3pandora_out_dapm_widgets));
>
> Acked-by:Liam Girdwood <lrg@slimlogic.co.uk>

I wonder if this could go in as a fix, Pandora will have no working
sound playback in .32 without this.
