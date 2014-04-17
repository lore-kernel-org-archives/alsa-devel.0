From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV
 shift values for ADC, PCM, and Analog kcontrols
Date: Thu, 17 Apr 2014 10:08:23 -0500
Message-ID: <alpine.DEB.2.02.1404171007510.9674@heelrod>
References: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
 <20140417162625.21d072e7@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0097.outbound.protection.outlook.com [157.56.110.97])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E1BB2602F3
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 17:08:05 +0200 (CEST)
In-Reply-To: <20140417162625.21d072e7@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org



On Thu, 17 Apr 2014, Thomas Petazzoni wrote:

> Dear Brian Austin,
>
> On Wed, 19 Mar 2014 10:40:02 -0500, Brian Austin wrote:
>> The shift values for the ADC,PCM, and Analog kcontrols were wrong causing wrong values for the SOC_DOUBLE_R_SX_TLV macros
>> Fixed the TLV for aout_tlv to show -102dB correctly
>>
>> Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
>> ---
>>  sound/soc/codecs/cs42l51.c |    9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> Thanks for this patch. Unfortunately, it still doesn't solve completely
> the situation. When I start alsamixer, it shows that:
>
> * PCM is at 102 (so above the maximum 100 value)
> * Both ADC Mixers are at 102
> * Analog is at 174 (so way above the maximum 100 value)
>
> Changing the value of PCM works (but of course I can then only change
> it between 0 and 100, not up to 102). However, as soon as I change the
> "Analog" value, even if I raise it up to 174, there isn't any sound
> anymore. Probably because the alsamixer range 0-100 doesn't allow to
> reach a high enough volume to be audible.
>
> Here is the amixer output right after boot (without changing any
> value) :
>
can you try this quick check please?

  static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
         SOC_DOUBLE_R_SX_TLV("PCM Playback Volume",
                         CS42L51_PCMA_VOL, CS42L51_PCMB_VOL,
-                       0, 0x19, 0x7F, adc_pcm_tlv),
+                       0, 0x19, 0x80, adc_pcm_tlv),
         SOC_DOUBLE_R("PCM Playback Switch",
                         CS42L51_PCMA_VOL, CS42L51_PCMB_VOL, 7, 1, 1),
         SOC_DOUBLE_R_SX_TLV("Analog Playback Volume",
                         CS42L51_AOUTA_VOL, CS42L51_AOUTB_VOL,
-                       0, 0x34, 0xE4, aout_tlv),
+                       0, 0x34, 0xE5, aout_tlv),
         SOC_DOUBLE_R_SX_TLV("ADC Mixer Volume",
                         CS42L51_ADCA_VOL, CS42L51_ADCB_VOL,
-                       0, 0x19, 0x7F, adc_pcm_tlv),
+                       0, 0x19, 0x80, adc_pcm_tlv),
         SOC_DOUBLE_R("ADC Mixer Switch",
                         CS42L51_ADCA_VOL, CS42L51_ADCB_VOL, 7, 1, 1),
         SOC_SINGLE("Playback Deemphasis Switch", CS42L51_DAC_CTL, 3, 1, 
0),


-Brian
