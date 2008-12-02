From: "Grazvydas Ignotas" <notasas@gmail.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add capture source
	selection and mic gain control
Date: Tue, 2 Dec 2008 12:15:51 +0200
Message-ID: <6ed0b2680812020215l3072dee8wc47e69b5bebb6b77@mail.gmail.com>
References: <1228172848-5221-1-git-send-email-notasas@gmail.com>
	<20081201232652.GA10702@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 07A1E2459A
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 11:15:52 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so2769101rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 02 Dec 2008 02:15:51 -0800 (PST)
In-Reply-To: <20081201232652.GA10702@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 2, 2008 at 1:26 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Dec 02, 2008 at 01:07:28AM +0200, Grazvydas Ignotas wrote:
>
>> This patch adds controls for capture source controls. When a microphone
>> is selected, handlers automatically enable bias power (disable when
>> deselected). The patch also adds microphone gain control. Microphone
>> and line input recording tested on OMAP3 pandora board.
>
> Hrm.  Disabling the gain like this is likely to cause trouble for jack
> detect.  However, that's not implemented yet so not a problem currently.

Well the TRM doesn't mention jack detect at all (except headset detect
using separate switch connected to GPIO). Or is that some software
feature?

>
>> +static int twl4030_get_right_input(struct snd_kcontrol *kcontrol,
>> +     struct snd_ctl_elem_value *ucontrol)
>> +{
>> +     struct snd_soc_codec *codec = kcontrol->private_data;
>> +     u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICR);
>> +
>> +     reg &= TWL4030_SUBMIC_EN|TWL4030_AUXR_EN;
>> +     if (reg == TWL4030_SUBMIC_EN)
>> +             ucontrol->value.integer.value[0] = 0;
>> +     else if (reg == TWL4030_AUXR_EN)
>> +             ucontrol->value.integer.value[0] = 1;
>> +
>> +     return 0;
>
> This will report something undefined as selected when neither option is
> selected.  Why not include a "None" option in the mux (the same applies
> to the other path)?  A switch statement might make for clearer code here.

Sounds good, will update.

>> +
>> +     SOC_DOUBLE_TLV("Microphone Boost", TWL4030_REG_ANAMIC_GAIN,
>> +             0, 3, 5, 0, microphone_gain_tlv),
>
> Should be "Microphone Boost Volume" or possibly just "Microphone Volume".

Setting this to 0 still records from MICs, but the signal is rather
weak, so it looks more like boost to me. This control also affects
aux/line inputs if they are selected, and causes rather bad
distortions for them if control is not set to 0. Perhaps this control
could be disabled (or at least automatically set to 0) while aux/line
inputs are selected? Can that be done?
There are actually MICAMP_EN bits to enable microphone amplifiers, but
if they are not set, aux/line recording won't work too (records some
strange noise).
