From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5651: Enable jack detection on
	JD1_1
Date: Fri, 20 Oct 2017 02:10:09 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7026EDB3C@RTITMBSV02.realtek.com.tw>
References: <20171019110323.23751-1-carlo@caione.org>
 <20171019110323.23751-2-carlo@caione.org>
 <d8041bdf-8fd1-1bf3-45e1-cd3fd1b57459@linux.intel.com>
 <CAL9uMOGu+enNVkRwC7=MG_Tg8wmOGaJTaNsCxj28JCFkYeRVaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 8002326704E
 for <alsa-devel@alsa-project.org>; Fri, 20 Oct 2017 04:10:21 +0200 (CEST)
In-Reply-To: <CAL9uMOGu+enNVkRwC7=MG_Tg8wmOGaJTaNsCxj28JCFkYeRVaw@mail.gmail.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@endlessm.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Edgar Shen <edgar_shen@realtek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, Albert Chen <albertchen@realtek.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Carlo Caione [mailto:carlo@endlessm.com]
> Sent: Thursday, October 19, 2017 11:55 PM
> To: Pierre-Louis Bossart
> Cc: Carlo Caione; Linux Upstreaming Team; Bard Liao; Oder Chiou; Mark
> Brown; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> tiwai@suse.com; Albert Chen; Edgar Shen
> Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: rt5651: Enable jack detection on
> JD1_1
> 
> On Thu, Oct 19, 2017 at 4:47 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> > On 10/19/17 6:03 AM, Carlo Caione wrote:
> >>
> >> From: Carlo Caione <carlo@endlessm.com>
> >>
> >> Enable jack detection or the RT5651 codec on the JD1_1 pin.
> >
> > Nice, but the codec supports a second jack detection on JD1 and has a
> second
> > JD2 pin. I will bet that some devices will have a different routing and I
> > wonder if we could just add support for all options.
> 
> I can write support for that but I have no hardware to actually test
> it, that's why I left those cases out.
> 
> >> The codec has no means to detect the type of the jack connected so we
> >> assume that the jack is always an headset jack.
> >
> > that's odd, was this confirmed by Realtek?
> 
> The Realtek people are in CC :)
> Probably there is way but in the datasheet there is nothing about that
> (or did I miss it?)

Yes, rt5651 has the capability of jack type detection.
Please see the following code for reference.
+static int rt5651_jack_detect(struct snd_soc_codec *codec, int jack_insert)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	int jack_type;
+
+	if (jack_insert) {
+		snd_soc_dapm_force_enable_pin(dapm, "LDO");
+		snd_soc_dapm_sync(dapm);
+
+		snd_soc_update_bits(codec, RT5651_MICBIAS,
+			RT5651_MIC1_OVCD_MASK | RT5651_MIC1_OVTH_MASK |
+			RT5651_PWR_CLK12M_MASK | RT5651_PWR_MB_MASK,
+			RT5651_MIC1_OVCD_EN | RT5651_MIC1_OVTH_600UA |
+			RT5651_PWR_MB_PU | RT5651_PWR_CLK12M_PU);
+		msleep(100);
+		if (snd_soc_read(codec, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
+			jack_type = SND_JACK_HEADPHONE;
+		else
+			jack_type = SND_JACK_HEADSET;
+		snd_soc_update_bits(codec, RT5651_IRQ_CTRL2,
+			RT5651_MB1_OC_CLR, 0);
+	} else { /* jack out */
+		jack_type = 0;
+
+		snd_soc_update_bits(codec, RT5651_MICBIAS,
+			RT5651_MIC1_OVCD_MASK, RT5651_MIC1_OVCD_DIS);
+	}
+
+	return jack_type;
+}

> 
> >> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> >> ---
> >>   include/sound/rt5651.h    |  7 ++++
> >>   sound/soc/codecs/rt5651.c | 91
> >> +++++++++++++++++++++++++++++++++++++++++++++--
> >>   sound/soc/codecs/rt5651.h |  3 ++
> >>   3 files changed, 99 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
> >> index d35de758dfb5..c563383149c4 100644
> >> --- a/include/sound/rt5651.h
> >> +++ b/include/sound/rt5651.h
> >> @@ -11,11 +11,18 @@
> >>   #ifndef __LINUX_SND_RT5651_H
> >>   #define __LINUX_SND_RT5651_H
> >>   +enum rt5651_jd_src {
> >> +       RT5651_JD_NULL,
> >> +       RT5651_JD1_1,
> >> +};
> >> +
> >>   struct rt5651_platform_data {
> >>         /* IN2 can optionally be differential */
> >>         bool in2_diff;
> >>         bool dmic_en;
> >> +
> >> +       enum rt5651_jd_src jd_src;
> >
> >
> > I don't see code that sets this platform data, is there a quirk or
> > of_property missing in this patchset?
> 
> Yes, it is supposed to be enabled by a quirk. In general (personal
> taste) I prefer to post the quirk enabling code after the base code
> has been ACKed. If you feel like it I can post also the quirk code
> together with the next respin of this patchset.
> 
> Thank you,
> 
> --
> Carlo Caione  |  +39.340.80.30.096  |  Endless
> 
> ------Please consider the environment before printing this e-mail.
