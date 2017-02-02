From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8824: new codec driver
Date: Thu, 2 Feb 2017 11:33:41 +0800
Message-ID: <5892A895.1090509@nuvoton.com>
References: <1485402489-31325-1-git-send-email-KCHSU0@nuvoton.com>
 <20170201174054.egdzu5rvqyo3ka5o@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F38ED26750E
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 04:33:46 +0100 (CET)
In-Reply-To: <20170201174054.egdzu5rvqyo3ka5o@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 2/2/2017 1:40 AM, Mark Brown wrote:
> On Thu, Jan 26, 2017 at 11:48:09AM +0800, John Hsu wrote:
>
> This looks mostly good, a few fairly small things below:
>
>
>> +       SOC_SINGLE_TLV("Speaker Right Volume from DACR",
>> +               NAU8824_REG_CLASSD_GAIN_1, 8, 0x1f, 0, spk_vol_tlv),
>>
>
> Names for volume controls need to end with Volume for userspace to
> understand them properly, give these the same names that the DAPM mixer
> controls have but end with Volume instead of Switch and then userspace
> will be able to combine them when displaying.
>
>

We'll rename these controls.

>> +       case SND_SOC_DAPM_POST_PMU:
>> +               /* Prevent startup click by letting charge pump to ramp up */
>> +               usleep_range(10000, 11000);
>>
>
> I believe the current preference is to do this as just msleep(10).
>
>

Thanks for remind. Note and change it.

>> +static int nau8824_codec_probe(struct snd_soc_codec *codec)
>> +{
>> +       struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
>> +       struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
>> +
>> +       nau8824->dapm = dapm;
>> +       snd_soc_dapm_sync(nau8824->dapm);
>>
>
> This sync shouldn't do anything, just remove it.
>
>

OK, we'll remove it.

>> +static int __maybe_unused nau8824_suspend(struct snd_soc_codec *codec)
>> +{
>> +       struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
>> +
>> +       if (nau8824->irq) {
>> +               disable_irq(nau8824->irq);
>> +               snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
>> +       }
>>
>
> Why are we disabling the IRQ here?
>
>

In some cases, there is IRQ storm after resume. It's safe to
disable IRQ for the case. But the issue is happened because of
hardware defect. It's not happened for normal case.

>> +       if (nau8824->irq) {
>> +               nau8824_sema_acquire(nau8824, 0);
>> +               enable_irq(nau8824->irq);
>> +       }
>>
>
> We didn't drop this sempahore in the suspend path?  This stuff could at
> least use better comments.
>
>

The semaphore can help to arrange the sequence between playback and
jack detection. We can add comment for the purpose.

>> +       /* Boost FEPGA 20dB */
>> +       regmap_update_bits(regmap, NAU8824_REG_FEPGA_II,
>> +               NAU8824_FEPGA_GAINL_MASK | NAU8824_FEPGA_GAINR_MASK,
>> +               0xa | (0xa << NAU8824_FEPGA_GAINR_SFT));
>>
>
> Possibly something that should be controllable from userspace?
>
>

OK, the default configuration can be removed and let usersapce to
management.

>> +       nau8824_reset_chip(nau8824->regmap);
>> +       ret = regmap_read(nau8824->regmap, NAU8824_REG_I2C_DEVICE_ID, &value);
>> +       if (ret < 0) {
>> +               dev_err(dev, "Failed to read device id from the NAU8824: %d\n",
>> +                       ret);
>> +               return ret;
>> +       }
>>
>
> Perhaps check the device ID before resetting the chip (and verify that
> the device ID is what's expected)?  That way if the system is
> misconfigured then the check will be less disruptive.
>

We'll rearrange the sequence.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
