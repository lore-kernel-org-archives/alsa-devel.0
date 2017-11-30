From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_ssi: add 20-bit sample
 format for AC'97 and use it for capture
Date: Thu, 30 Nov 2017 20:20:08 +0100
Message-ID: <ba46e597-6ae7-5fb4-40b3-bb2a5e08066a@maciej.szmigiero.name>
References: <5dfa7813-385e-d9c7-84e0-12cf1f7d3a5f@maciej.szmigiero.name>
 <20171130072357.GA992@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AA1F267B18
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 20:20:18 +0100 (CET)
In-Reply-To: <20171130072357.GA992@Asurada>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On 30.11.2017 08:23, Nicolin Chen wrote:
> Hi Maciej,
> 
> On Mon, Nov 27, 2017 at 11:34:44PM +0100, Maciej S. Szmigiero wrote:
>> There is no problem in using different bit widths in playback and capture
>> in AC'97 mode so allow this, too.
> 
>> @@ -1557,11 +1558,12 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>>  
>>  	/* Are the RX and the TX clocks locked? */
>>  	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
>> -		if (!fsl_ssi_is_ac97(ssi_private))
>> +		if (!fsl_ssi_is_ac97(ssi_private)) {
>>  			ssi_private->cpu_dai_drv.symmetric_rates = 1;
>> +			ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
>> +		}
>>  
>>  		ssi_private->cpu_dai_drv.symmetric_channels = 1;
>> -		ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
>>  	}
> 
> I was actually wondering how the AC97 works in the synchronous mode
> while being able to handle different bit widths. Then I found that
> the drivers does corresponding configurations for synchronous mode
> only if symmetric_rates is set -- which is unset for AC97 cases. So
> in fact AC97 case (symmetric_rates unset) is probably being treated
> as asynchronous mode by the driver -- it'd be better if you confirm
> this for me.
> 
> And I am not so sure about the physical pin connections in an AC97
> situation, but I started to think that, instead of having a change
> above, AC97 cases might be supposed to have "fsl,ssi-asynchronous"
> property in DT since it's working when the driver sets both TX and
> RX control registers (i.e. asynchronous mode), not like synchronous
> mode that only sets TX's registers
In the AC'97 mode we have to differentiate two things:
1) Bit width of the physical AC'97 interface ("AC-link"),
2) Bit width of samples that are accepted during a playback and output
during a recording by the SSI (and, so by the sound card that it driven
by this CPU).

Bit width of the physical AC'97 interface is fixed at 20 bits per sample
(both in playback and capture direction).

Bit width of samples that are accepted (or produced) by the SSI could
be set in its STCCR and SRCCR registers (although in the AC'97 mode
only settings of either 16 or 20 bits are possible).
Each direction could be set independently from the other one.

That's what the driver configures depending on what an ALSA application
had requested.

Regarding a sample rate in AC'97 mode its effective value isn't really
controlled by the CPU (that is, SSI), but by a CODEC since it is
the CODEC which tells the CPU when it should send a next sample for
playback and when a next capture sample is ready.
There are no problems if they are different (as long as the CODEC
supports this, naturally, but it's up to its driver to restrict the
sample rate space accordingly).

A comment above "fsl,ssi-asynchronous" property says that it is about
whether "the RX and the TX clocks [are] locked".
They are on the physical AC'97 interface, but they aren't on the logical
playback / capture interface.
IMHO, this configurable property simply makes no sense in the AC'97
mode.

> Thanks
> Nicolin
> 

Best regards,
Maciej
