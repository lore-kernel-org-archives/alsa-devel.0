From: Petr Kulhavy <petr@barix.com>
Subject: Re: [PATCH v3 2/2] ASoC: wm8985: add support for WM8758
Date: Tue, 24 May 2016 09:24:05 +0200
Message-ID: <CAEP=dzCNe8pB1O_Pqv+46TL81zpUMN52R45_eNga1CCAm_zkhQ@mail.gmail.com>
References: <1464012685-1142-1-git-send-email-petr@barix.com>
 <1464012685-1142-3-git-send-email-petr@barix.com>
 <20160523145539.GD20422@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com
 [209.85.161.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 72A0E260631
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 09:24:26 +0200 (CEST)
Received: by mail-yw0-f170.google.com with SMTP id h19so7890291ywc.0
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 00:24:26 -0700 (PDT)
In-Reply-To: <20160523145539.GD20422@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Plamen Prodanov <plamen@barix.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi Charles,

thanks a lot for your comments.

On 23 May 2016 at 16:55, Charles Keepax
<ckeepax@opensource.wolfsonmicro.com> wrote:
> On Mon, May 23, 2016 at 04:11:25PM +0200, Petr Kulhavy wrote:
>> @@ -317,6 +326,10 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
>>       SOC_DOUBLE("ADC Inversion Switch", WM8985_ADC_CONTROL, 0, 1, 1, 0),
>>       SOC_SINGLE("ADC 128x Oversampling Switch", WM8985_ADC_CONTROL, 8, 1, 0),
>>
>> +     SOC_SINGLE("High Pass Filter Switch", WM8985_ADC_CONTROL, 8, 1, 0),
>> +     SOC_ENUM("High Pass Filter Mode", filter_mode),
>> +     SOC_SINGLE("High Pass Filter Cutoff", WM8985_ADC_CONTROL, 4, 7, 0),
>> +
>
> Why are these moving? Eases review to keep unrelated changes out
> of the patch.

I couldn't resist to sort them in and it was too tempting to keep it
in one patch ;-)
These ADC controls were originally among the DAC controls, so this
place is in my view more suitable.

>>       SOC_DOUBLE_R_TLV("Playback Volume", WM8985_LEFT_DAC_DIGITAL_VOL,
>>               WM8985_RIGHT_DAC_DIGITAL_VOL, 0, 255, 0, dac_tlv),
>>
>> @@ -344,15 +357,6 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
>>               WM8985_ROUT2_SPK_VOLUME_CTRL, 7, 1, 0),
>>       SOC_DOUBLE_R("Speaker Switch", WM8985_LOUT2_SPK_VOLUME_CTRL,
>>               WM8985_ROUT2_SPK_VOLUME_CTRL, 6, 1, 1),
>> -
>> -     SOC_SINGLE("High Pass Filter Switch", WM8985_ADC_CONTROL, 8, 1, 0),
>> -     SOC_ENUM("High Pass Filter Mode", filter_mode),
>> -     SOC_SINGLE("High Pass Filter Cutoff", WM8985_ADC_CONTROL, 4, 7, 0),
>> -
>> -     SOC_DOUBLE_R_TLV("Aux Bypass Volume",
>> -             WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 6, 7, 0,
>> -             aux_tlv),
>> -
>>       SOC_DOUBLE_R_TLV("Input PGA Bypass Volume",
>>               WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 2, 7, 0,
>>               bypass_tlv),
>> @@ -373,6 +377,12 @@ static const struct snd_kcontrol_new wm8985_snd_controls[] = {
>>       SOC_SINGLE_TLV("EQ5 Volume", WM8985_EQ5_HIGH_SHELF, 0, 24, 1, eq_tlv),
>>
>>       SOC_ENUM("3D Depth", depth_3d),
>> +};
>> +
>> +static const struct snd_kcontrol_new wm8985_specific_snd_controls[] = {
>> +     SOC_DOUBLE_R_TLV("Aux Bypass Volume",
>> +             WM8985_LEFT_MIXER_CTRL, WM8985_RIGHT_MIXER_CTRL, 6, 7, 0,
>> +             aux_tlv),
>>
>>       SOC_ENUM("Speaker Mode", speaker_mode)
>>  };
>> @@ -389,6 +399,16 @@ static const struct snd_kcontrol_new right_out_mixer[] = {
>>       SOC_DAPM_SINGLE("PCM Switch", WM8985_RIGHT_MIXER_CTRL, 0, 1, 0),
>>  };
>>
>> +static const struct snd_kcontrol_new wm8758_left_out_mixer[] = {
>> +     SOC_DAPM_SINGLE("Line Switch", WM8985_LEFT_MIXER_CTRL, 1, 1, 0),
>> +     SOC_DAPM_SINGLE("PCM Switch", WM8985_LEFT_MIXER_CTRL, 0, 1, 0),
>> +};
>> +
>> +static const struct snd_kcontrol_new wm8758_right_out_mixer[] = {
>> +     SOC_DAPM_SINGLE("Line Switch", WM8985_RIGHT_MIXER_CTRL, 1, 1, 0),
>> +     SOC_DAPM_SINGLE("PCM Switch", WM8985_RIGHT_MIXER_CTRL, 0, 1, 0),
>> +};
>> +
>
> I would be tempted to put the "Aux Switch" at the end of the
> existing array and then just specifying different sizes for each
> part in the SND_SOC_DAPM_MIXER macro, saves the need to duplicate
> these.

That's a good idea indeed!

I'm going to send another round.

Regards
Petr
