From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ASoC: Intel: Enabled button jack for BSW
 platform with rt5650 codec
Date: Tue, 5 May 2015 15:27:33 -0700
Message-ID: <CAEUnVG5CSbPf7cTmmDmw9CWYRf-vtwvRy3RMAMTMm+9wphZ7fw@mail.gmail.com>
References: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
 <20150505214902.GG15510@sirena.org.uk>
 <CAEUnVG7MW4z4kHipcCWEFAvkqFEu42k4ax4+S2YDvexwJjHdPw@mail.gmail.com>
 <20150505221415.GA109322@mocha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f53.google.com (mail-vn0-f53.google.com
 [209.85.216.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 18810261AA0
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:27:55 +0200 (CEST)
Received: by vnbg190 with SMTP id g190so18150724vnb.12
 for <alsa-devel@alsa-project.org>; Tue, 05 May 2015 15:27:54 -0700 (PDT)
In-Reply-To: <20150505221415.GA109322@mocha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yang Fang <yang.a.fang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srinivas.sripathi@intel.com, Vinod Koul <vinod.koul@intel.com>, Praveen K Jain <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Denny Iriawan <denny.iriawan@intel.com>, Mark Brown <broonie@kernel.org>, "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 5, 2015 at 3:14 PM, Yang Fang <yang.a.fang@intel.com> wrote:
> On Tue, May 05, 2015 at 03:02:01PM -0700, Dylan Reid wrote:
>> On Tue, May 5, 2015 at 2:49 PM, Mark Brown <broonie@kernel.org> wrote:
>> > On Mon, May 04, 2015 at 05:19:20PM -0700, yang.a.fang@intel.com wrote:
>> >> From: "Fang, Yang A" <yang.a.fang@intel.com>
>> >>
>> >> rt5650 codec supports 4 buttons detections so enabled it
>> >
>> >> @@ -43,6 +43,7 @@ struct cht_acpi_card {
>> >>  struct cht_mc_private {
>> >>       struct snd_soc_jack hp_jack;
>> >>       struct snd_soc_jack mic_jack;
>> >> +     struct snd_soc_jack btn_jack;
>> >>       struct cht_acpi_card *acpi_card;
>> >
>> > This is a bit weird - why are we adding an additional jack here, surely
>> > the button is attached to the mic jack here?  The jacks should
>> > correspond to the physical jacks on the system rather than the function
>> > so that users and applications can tie the jacks that we have in
>> > software to those physically on the system.
>> >
>> > Now I'm wondering if the headphone and microphone are expected to be a
>> > single jack here?
>>
>> At least the Chromebook version will have a single combo jack.  I
>> would expect there to be a single jack created that reports all of hp,
>> mic, and buttons.
> I recalled in Baytrail cras required hp and mic to be separated jack.
> I beleived it is changed afterwards.
>
> now rt5645_set_jack_detect in rt5645.c aleady split jack into 3 like
> below. maybe we need Bard to combine them ?

That would be ideal.  The ts3a227e driver already behaves this.

>
>  int rt5645_set_jack_detect(struct snd_soc_codec *codec,
>      struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack,
>      struct snd_soc_jack *btn_jack)
>  {
>      struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
>
>      rt5645->hp_jack = hp_jack;
>      rt5645->mic_jack = mic_jack;
>      rt5645->btn_jack = btn_jack;
>      if (rt5645->btn_jack && rt5645->codec_type ==
> CODEC_TYPE_RT5650) {
>          rt5645->en_button_func = true;
>          regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
>                  RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
>          regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
>                  RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
>          regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
>                  RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
>      }
>      rt5645_irq_detection(rt5645);
>
>      return 0;
>  }
>
> Yang
>
>>
>> >
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >
