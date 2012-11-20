From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to create and destroy firmware components.
Date: Tue, 20 Nov 2012 15:14:30 +0000
Message-ID: <50AB9E56.5050509@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
 <20121120032659.GC4483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id ACF93265B59
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 16:14:33 +0100 (CET)
In-Reply-To: <20121120032659.GC4483@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20/11/12 03:27, Mark Brown wrote:

> One thing I'm missing is signal generator widgets - those seem like
> something that's likely to be often software defined.  It'd also be good
> to see a bit more documentation for the file format, like an explanation
> of what things like coefficients are since we're going to make it an
> ABI.

The coefficients atm can either be a vendor blob or can be a vendor blob 
attached to a generic kcontrol e.g. and EQU kcontrol with texts that 
correspond to the coefficients. I'll detail this more in documentation.

>
> With coefficeints we have been moving towards a model where we just
> expose them as binary controls rather than doing the enumeration thing.
>

For ABE we have different coefficients tied to each enumerated EQU kcontrol 
setting and just configure the ABE coefficient depending on the kcontrol 
value. We load the coefficients and EQU kcontrol at the same time since it's 
enumerated text strings are coupled to the coefficients.

>
>> +struct snd_soc_fw_ctl_tlv {
>> +	u32 numid;	/* control element numeric identification */
>> +	u32 length;	/* in bytes aligned to 4 */
>> +	/* tlv data starts here */
>> +};
>
> This is just raw ALSA TLV data (it's already an ABI after all).

True and I think it will be in the new include/uapi/sound too. I may just go 
and create and move the ASoC userspace stuff into a new ASoC userspace header 
file that can also be included by soc.h, etc (a bit like asound.h)

>
>> +struct snd_soc_fw_enum_control {
>> +	struct snd_soc_fw_control_hdr hdr;
>> +	u32 reg;
>> +	u32 reg2;
>> +	u32 shift_l;
>> +	u32 shift_r;
>> +	u32 max;
>> +	u32 mask;
>> +	union {	/* both texts and values are the same size */
>> +		char texts[SND_SOC_FW_NUM_TEXTS][SND_SOC_FW_TEXT_SIZE];
>> +		u32 values[SND_SOC_FW_NUM_TEXTS * SND_SOC_FW_TEXT_SIZE / 4];
>
> I'm having a hard time visualising how this will get filled in - I'd
> expect we'd have something more like:
>
> 	u32 num_values;
> 	struct {
> 		u32 value;
> 		char text[SND_SOC_FW_TEXT_SIZE];
> 	};
>
> - I can't visualise how something with only values would work?  But
> perhaps I'm just missing something.
>

We need to store on file, either an array of strings or an array of u32 values 
for the enumerated kcontrols (based on soc_enum). This gives us a fixed size 
file entry which is easy to read, write and count. But maybe I'm missing 
something from your question...

>
>> +static int soc_fw_widget_load(struct soc_fw *sfw, struct snd_soc_dapm_widget *w)
>> +{
>> +	if (sfw->codec && sfw->codec_ops && sfw->codec_ops->widget_load)
>> +		return sfw->codec_ops->widget_load(sfw->codec, w);
>> +
>> +	if (sfw->platform && sfw->platform_ops && sfw->platform_ops->widget_load)
>> +		return sfw->platform_ops->widget_load(sfw->platform, w);
>> +
>> +	if (sfw->card && sfw->card_ops && sfw->card_ops->widget_load)
>> +		return sfw->card_ops->widget_load(sfw->card, w);
>> +
>> +	dev_info(sfw->dev, "ASoC: no handler specified for ext widget %s\n",
>> +		w->name);
>> +	return 0;
>
> Shouldn't this be returning an error?  The same is true for a bunch of
> other functions.  Or shouild it be a dev_dbg()?

It should probably have a comment. This is an optional callback to component 
drivers in case they want to use set the widgets private data at widget init time.

>
>> +		dev_dbg(sfw->dev, "ASoC: adding mixer kcontrol %s with access"
>> +			" 0x%x\n", mc->hdr.name, mc->hdr.access);
>
> Don't split log messages like this, makes it harder to grep - just break
> the 80 columns or wrap after sfw->dev.
>
>> +			if (ext) {
>> +				dev_err(sfw->dev, "ASoC: no complete mixer IO"
>> +					"handler for %s type (g,p,i) %d:%d:%d\n",
>
> This one is going to be especially bad for example.
>
>> +	if (se->dvalues)
>> +		kfree(se->dvalues);
>> +	else {
>
> Braces on both sides if they're needed on one.
>

The last three points are personal taste, I don't mind too much so I'll change 
them ;)

Liam
