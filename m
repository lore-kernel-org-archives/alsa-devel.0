From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Thu, 15 Mar 2012 15:50:41 +0100
Message-ID: <4F6201C1.1040006@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224529.GL3177@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
	<20120314134508.GL3133@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
	[207.126.144.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CAD2104622
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 16:20:18 +0100 (CET)
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FF44B06
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 15:20:16 +0000 (GMT)
In-Reply-To: <20120314134508.GL3133@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 03/14/2012 02:45 PM, Mark Brown wrote:
> On Wed, Mar 14, 2012 at 02:27:13PM +0100, Ola LILJA2 wrote:
>
> Fix your mailer to word wrap properly, I've reflowed your text for
> legibility.
>
>>>> diff --git a/sound/soc/codecs/ab8500_audio.c
>>>> b/sound/soc/codecs/ab8500_audio.c
>>> Everything else uses -codec.
>> Could just see one codec named with "-codec". The reason for appending _audio
>> Is that the AB8500 is not only audio and we already have files elsewhere named
>> ab8500.c but I probably could rename it to ab8500-codec.c.
> The drivers for MFDs pretty much all call themselves -codec internally
> (as yours does).
OK, I thought you were comparing the namning of our file with the naming of
other codec-files in the /soc/codecs-folder.
But I guess that you are comparing the filename of our codec to the string we
user for the device in the code. I'll rename it to ab8500-codec.c
>>> Why are you doing this virtual register stuff?  It's making the code a
>>> lot more complex and doesn't look at all driver specific.
>> There is a chain of events leading up to the decision of having it
>> like this.  The HW is designed so that only one coefficient-register
>> is present and when we write a value to it the HW increases a HW-index
>> so that the next time we write to it the value will set the next
>> coefficient and so on.  Also, we don't want to be able to first set
>> all FIR/IIR-coefficients with the ALSA-controls And when we are happy
>> we write all the coefficients to the HW by committing them using the
>> strobe-control.  Furthermore, we cannot read the coefficients from the
>> HW, so to be able to provide this to userspace we use the
>> SOC_HWDEP_MULTIPLE_1R, and since these values actually is not exposed
>> as separate registers we use a set of virtual register. When we commit
>> the coefficients we then take the values from the virtual registers
>> and write them down to the HW in a loop.
> Don't do this, this just makes things a lot more complicated in the
> register I/O code and making it much more difficult to work with both
> locally and from a framework point of view.  Store the coefficients in
> your driver data rather than shoehorning them into the register cache.
>
OK...
>>>> +static const char * const enum_ena_dis[] = {"Enabled", "Disabled"};
>>>> +static const char * const enum_dis_ena[] = {"Disabled", "Enabled"};
>>> Why are the controls using these enums and not Switch controls?  UIs
>>> know how to display switches.
>> We need to make the switches virtual, as we don't want them to
>> actually set any bits, just break or complete a DAPM-chain. That is
>> why we made the as MUX:es.
> This is completely orthogonal to how the controls are displayed to
> userspace, it's an implementation detail of your driver.  Though if your
> routing control doesn't actually touch the device one has to wonder what
> it actually does...
>
I never found a way to have the playback-switch not touching any bits in the HW,
so we used muxes instead. But if you say that is possible I will look into it
again.
>>>> +/* Earpiece - Mute */
>>>> +static const struct snd_kcontrol_new dapm_ear_mute[] = {
>>>> +	SOC_DAPM_SINGLE("Playback Switch", REG_MUTECONF,
>>>> +REG_MUTECONF_MUTEAR, 1, 1), };
>>> This looks like it's just a mute rather than a mixer input enable
>>> (there's only one control...) so should be a regular sound control;
>>> unless there's a very good reason mutes other than mixer inputs
>>> normally don't affect the audio path as you might get pops and you
>>> probably don't want to do things like stop clocking just because the
>>> output is silenced.  Similar thing applies in several other places.
>> Most of the mutes need to be apart of the DAPM-chain to actually prevent
>> click-n-pops. So it cannot be used by the user as a normal ALSA-control.
>> Muting can be done by setting certain gains to -inf.
> This explanation doesn't correspond to what you've actually written -
> the code above will result in a user visible control.
That is why I said "most of", since this one was going to be converted to a
virtual type (SND_SOC_ENUM_VIRT). And then we could use the bit
REG_MUTECONF_MUTEAR in the DAPM-chain without having a userspace control setting
it before the chain is getting executed.
Also, the reason for not just changing control-types directly is because our
customers are affected by these kind of changes so we need to do those changes
at times where we can minimize the damge, have time to handle the effects and
when customers actually accept that we do it (we try to diverge as little as
possible from our main-branch).
>>>> +			unsigned int fmt,
>>>> +			unsigned int wl,
>>>> +			unsigned int delay);
>>>> +void ab8500_audio_anc_configure(struct snd_soc_codec *codec,
>>>> +			bool apply_fir, bool apply_iir);
>>> No, you shouldn't be exporting this stuff - it all looks like basic
>>> framework stuff.
>> Hmm.. ok... the power_control is needed for reasons explained before
>> (vibra-driver and Accessory-detection-magic), but I guess I have to
>> remove these features for now and I can then remove this export.
> You've not mentioned accessory detection before...  there's certainly
> no obvious excuse for doing the power management for accessory detection
> outside of DAPM, we've got a bunch of drivers in mainline already which
> manage to do this quite successfully, but since you've not explained
> what the issue you think you see is it's hard to comment.
Accessory detection is just another external user not able to go through the
user-space interface and due to the fact that the algorithms need to detect
several different headset-types by turning on/off regulators and sampling the
voltage on the input in specific sequences, we found no convenient way to do
this since DAPM was controlling the regulators. We then introduced the _inc and
_dec for the power of the audio-part (ab8500_audio_power_control), so that DAPM
one-sided would not turn of the chip if, for example, vibra is on or accessory
detection is detecting.
We could remove both vibra and acc.det from the driver and put the
regulator-control inside the codec-driver, but we would drift even further from
what we actually use internally at ST-Ericsson and what our customers use.
