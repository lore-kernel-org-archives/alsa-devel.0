From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: fsl_ssi: AC'97 ops need regmap,
 clock and cleaning up on failure
Date: Tue, 21 Nov 2017 01:43:33 +0100
Message-ID: <52c327d2-9be2-dd7a-68d4-41d304077309@maciej.szmigiero.name>
References: <ecfcedaa-f0e9-ec1f-82c5-f0d319068a5d@maciej.szmigiero.name>
 <20171121003239.GC14136@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171121003239.GC14136@Asurada-Nvidia>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 21.11.2017 01:32, Nicolin Chen wrote:
> On Mon, Nov 20, 2017 at 11:14:55PM +0100, Maciej S. Szmigiero wrote:
(..)
>> @@ -1460,12 +1460,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>>  				sizeof(fsl_ssi_ac97_dai));
>>  
>>  		fsl_ac97_data = ssi_private;
> 
> By the way, is there any better way to register the ops for AC97
> while we could pass the ssi_private so as to remove the global
> fsl_ac97_data?

This might be possible (if SSI private data is provided to AC'97 codec in
codecs/ac97.c in platform device data which then is modified to make use
of it), but currently ASoC AC'97 only supports one controller per system
so for a real gain this limitation would have to be addressed first.

Maciej
