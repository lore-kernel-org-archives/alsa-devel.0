From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add AB8500 codec-driver
Date: Fri, 27 Apr 2012 12:54:59 +0200
Message-ID: <4F9A7B03.5040802@stericsson.com>
References: <1334914402-27554-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423185936.GW8318@opensource.wolfsonmicro.com>
	<4F9A649E.4000300@stericsson.com>
	<20120427093516.GB18260@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog109.obsmtp.com (eu1sys200aog109.obsmtp.com
	[207.126.144.127])
	by alsa0.perex.cz (Postfix) with ESMTP id 882642435C
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 12:55:18 +0200 (CEST)
In-Reply-To: <20120427093516.GB18260@opensource.wolfsonmicro.com>
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

On 04/27/2012 11:35 AM, Mark Brown wrote:

> On Fri, Apr 27, 2012 at 11:19:26AM +0200, Ola Lilja wrote:
>> On 04/23/2012 08:59 PM, Mark Brown wrote:
> 
>> > This won't work with probe deferral - if we need to defer then the
>> > driver will squash down the -EPROBE_DEFER and fail totally.  Not a big
>> > deal, though.
> 
>> Hmm, OK, how should I solve this?
> 
> Just passing back the first error you get should do the trick.
> 
>> > Similarly this is just a REGULATOR_SUPPLY.
> 
>> Is there already support for this in the core?
> 
> If you search the code for REGULATOR_SUPPLY... :)
> 
>> >> +static const struct soc_enum enum_mic1breg_sel = SOC_ENUM_SINGLE(0, 0, 2,
>> >> +								enum_micreg);
>> >> +static const struct snd_kcontrol_new dapm_mic1breg_mux[] = {
>> >> +				SOC_DAPM_ENUM_VIRT("Mic 1b Regulator Select",
>> >> +						enum_mic1breg_sel),
>> >> +};
> 
>> > Can you explain how this hardware works in more detail?  It seems very
>> > odd to be changing the regulator used to supply something at runtime.
> 
>> Yes, different customers have different regulators tied to the different mics.
>> E.g. VMIC1 can be used with MIC2 etc. These settings are stored in a DB in
>> userspace and therefor we have it as a control reachable from userspace, but I
>> see the point that this could also be put in the mach-folder and thus fixed
>> during build-time.
> 
> What are these regulators?  Are they internal PGA supplies or are they
> microphone biases?


These are mic-biases.

> 
>> >> +static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
>> >> +				struct snd_ctl_elem_value *ucontrol)
>> >> +{
>> >> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
>> >> +	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
>> >> +	unsigned int val;
>> >> +
>> >> +	val = (ucontrol->value.enumerated.item[0] != 0);
>> >> +	if (drvdata->mclk_sel == val)
>> >> +		return 0;
>> >> +
>> >> +	drvdata->mclk_sel = val;
>> >> +
>> >> +	return 1;
>> >> +}
> 
>> > This is really weird
> 
>> This is a way of selecting what clock is to be used during a plaback/capture.
>> It cannot direclty turn on/off the clock because this is not allowed for
>> power-saving reasons. Also, it needs to be accessible from user-space as we have
>> code in user-space which makes this decision during runtime.
> 
> Normally the clocking control is under the control of the machine driver
> and if the machine driver wants to offer any options to userspace it'd
> provide its own control - usually there's way more stuff going on here
> than just selecting a source and much more coordination needed with the
> drivers involved.


Yes, we are only selecting what clock to request to the clock-driver-code, which
then does its magic and taking decisions related to the whole platform.
More specifically, in my context (that is audio) we will act upon being in
voicecall or not, and in these cases requesting these two different clocks. By
design this request comes from audio-code in userspace down to the audio-driver
in the kernel. The clock-code will then turn of the clock not needed by us
(audio) or any other party.

> 
>> The same goes here... customers set this value in the database to match their
>> board-design. It is not a matter of being able to reconfigure this during
>> runtime but it is stored in the database, being one common place for most
>> settings; runtime or one-time-settings.
>> Also this could be put as a hard-coded parameter in the machine-driver.
> 
> Or put in platform data as I've repeatedly suggested.  This is the
> standard way of providing per-board fixed configuration to devices in
> Linux, the fact that you have a proprietary mechanism for doing this
> shouldn't really influence upstream too much.


OK, will put it in platform-data.
