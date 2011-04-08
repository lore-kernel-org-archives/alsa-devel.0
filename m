From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V2 1/5] sound: asoc: Adding support for
	STA529 Audio Codec
Date: Fri, 8 Apr 2011 11:09:09 +0530
Message-ID: <4D9E9F7D.2030809@st.com>
References: <1301397423-4693-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110329232750.GK30482@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog120.obsmtp.com (eu1sys200aog120.obsmtp.com
	[207.126.144.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DDC5103834
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 07:42:15 +0200 (CEST)
In-Reply-To: <20110329232750.GK30482@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark
Please find my answer inlined

On 3/30/2011 4:57 AM, Mark Brown wrote:
> On Tue, Mar 29, 2011 at 04:46:59PM +0530, Rajeev Kumar wrote:
> 
>> +static const struct snd_kcontrol_new sta529_snd_controls[] = {
>> +	SOC_SINGLE("Master Playback Volume", STA529_MVOL, 0, 127, 1),
>> +	SOC_SINGLE("Left Playback Volume", STA529_LVOL, 0, 127, 1),
>> +	SOC_SINGLE("Right Playback Volume", STA529_RVOL, 0, 127, 1),
>> +};
> 
> Left and Right should be a single stereo control (usually done with
> SOC_DOUBLE).  It'd also be better to provide gain information with the
> _TLV variants of the controls.
>
ok
 
> Does the master control actually provide a separate control or does it
> update both left and right channels simultaneously?  If the latter then
> normally you'd just omit it from the driver as the driver can easily do
> the stereo updates?

master control provide a separate control.

> 
>> +	val = snd_soc_read(codec, STA529_S2PCFG0);
>> +	val |= mode;
>> +	/*this setting will be used with actual h/w */
>> +	snd_soc_write(codec, STA529_S2PCFG0, val);
> 
> snd_soc_update_bits() - you're not clearing any bits here so if you
> change modes things will go wrong.
OK

> 
>> +	case SND_SOC_BIAS_STANDBY:
>> +	case SND_SOC_BIAS_OFF:
>> +		snd_soc_update_bits(codec, STA529_FFXCFG0, POWER_CNTLMSAK,
>> +				POWER_STDBY);
>> +		snd_soc_update_bits(codec, STA529_FFXCFG0, MUTE_ON_MASK,
>> +				MUTE_OFF);
> 
> Managing the mute in these states seems odd - could do with some
> comments in the code if nothing else.
> 
OK,Macro name in in-correct. 

>> +static void sta529_init(struct snd_soc_codec *codec)
>> +{
>> +	/* DAC default master volume */
>> +	snd_soc_write(codec, STA529_MVOL, DEFAULT_MASTER_VOL);
>> +	/* DAC default left volume */
>> +	snd_soc_write(codec, STA529_LVOL, DEFAULT_VOL);
>> +	/* DAC default right volume */
>> +	snd_soc_write(codec, STA529_RVOL, DEFAULT_VOL);
>> +	/* By default route to binary headphones */
>> +	snd_soc_write(codec, STA529_FFXCFG1, DEFAULT_BIN_HEADPHONE);
>> +	/* default value for Serial-to-parallel audio interface configuration */
> 
>> +	/* select microphone input by default*/
>> +	snd_soc_write(codec, STA529_ADCCFG, DEFAULT_MIC_SEL);
> 
> None of the above should be configured here, leave them at the default
> values (and offer them as runtime controls if they're not there
> already).  The settings appropriate for one machine may not be
> appropriate for another.
>
Ok 
 
>> +static int sta529_resume(struct snd_soc_codec *codec)
>> +{
>> +
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +	sta529_set_bias_level(codec, codec->suspend_bias_level);
>> +	return 0;
>> +}
> 
> I'd expect this to restore the register cache somewhere.
>
Ok


>> +MODULE_DESCRIPTION("ASoC STA529 codec driver");
>> +MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:sta529-codec");
> 
> This isn't a platform driver, remove the MODULE_ALIAS.
> .
Ooops, 
>
Best Regards
Rajeev
