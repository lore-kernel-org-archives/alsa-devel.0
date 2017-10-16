From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [PATCH] ASoC: sgtl5000: add support for a fixed sysclk frequency
Date: Mon, 16 Oct 2017 13:17:07 +0200
Message-ID: <9A3652B7-C0ED-44DE-AC6F-9D883076E9B8@theobroma-systems.com>
References: <20171006083449.24038-1-jakob.unterwurzacher@theobroma-systems.com>
 <AM5PR0401MB2627DE7F266788214268424BE34E0@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <EA6FEF1C-263E-4529-AC8E-16F50C27030F@theobroma-systems.com>
 <CAOMZO5D-2iFsAUk2Ldo4RD5Xg71Q5HOBuasYc0t=tV3hZbaO2g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5D-2iFsAUk2Ldo4RD5Xg71Q5HOBuasYc0t=tV3hZbaO2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Richard Leitner <richard.leitner@skidata.com>, Bhumika Goyal <bhumirks@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> On 16. Oct 2017, at 12:51, Fabio Estevam <festevam@gmail.com> wrote:
> 
> Hi Jakob,
> 
> On Mon, Oct 16, 2017 at 7:46 AM, Jakob Unterwurzacher
> <jakob.unterwurzacher@theobroma-systems.com> wrote:
>> Hi Fabio, that’s interesting.
>> 
>> Looks like the fsl,imx-audio-sgtl5000 sound card driver that is used on the imx51-babbage
>> does not try to adjust MCLK in response to the playback sample rate.
>> 
>> The simple-audio-card driver does that (it calls snd_soc_dai_set_sysclk whenever playback
>> starts).
> 
> Could you please test this with linux-next tree?
> 
> Looks like that the recent b0a7043d5c2c("ASoC: fsl_ssi: Caculate bit
> clock rate using slot number and width") would avoid the issue.
> 

Hi Fabio,

if this ( https://patchwork.kernel.org/patch/9952385/ ) is the patch, then it seems to be
specific to the Freescale I2S controller. We use the SGTL5000 together with a Rockchip CPU.

I think I see a way to fix this without adding a DTS property, I’ll send out a patch later this afternoon.

Best regards,
Jakob
