From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 5/6] ASoC: fsl_ssi: instantiate AC'97 CODEC
Date: Fri, 31 Jul 2015 16:39:20 +0200
Message-ID: <55BB8898.7000909@maciej.szmigiero.name>
References: <55BA362B.1010706@maciej.szmigiero.name>
 <20150731054617.GV30895@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id C0770265DD8
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 16:39:26 +0200 (CEST)
In-Reply-To: <20150731054617.GV30895@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 31.07.2015 07:46, Markus Pargmann wrote:
> On Thu, Jul 30, 2015 at 04:35:23PM +0200, Maciej S. Szmigiero wrote:
>> Instantiate AC'97 CODEC in fsl_ssi driver AC'97 mode.
>>
>> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>  sound/soc/fsl/fsl_ssi.c |   21 +++++++++++++++++++++
>>  1 files changed, 21 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> index 154bcf6..8e5ff5e 100644
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -1460,6 +1460,27 @@ done:
>>  		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
>>  				     ssi_private->dai_fmt);
>>  
>> +	if (fsl_ssi_is_ac97(ssi_private)) {
>> +		u32 ssi_idx;
>> +
>> +		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
> 
> This property is not set anywhere in the imx* DTs.

That's right, but it is documented as required property in sound/fsl,ssi.txt:
> Required properties:
> (..)
> - cell-index:       The SSI, <0> = SSI1, <1> = SSI2, and so on.

> 
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "cannot get SSI index property\n");
>> +			goto error_sound_card;
>> +		}
>> +
>> +		ssi_private->pdev =
>> +			platform_device_register_data(NULL,
>> +					"ac97-codec", ssi_idx, NULL, 0);
> 
> If you really want to create a device at this point you should use
> PLATFORM_DEVID_AUTO. I would prefer something where this is created in
> DT. On the other side it is a discoverable bus..

In the original implementation the codec was instantiated in DT but
the feedback was that this is wrong since devices on discoverable
buses shouldn't be in DT.

The platform device index is based on SSI index since the sound
card driver (fsl-asoc-card) has to know CODEC device name to identify
it in DAI links - as the only identification options seem to be either
DT node of CODEC or its device name.

That's why the (platform) device name has to be deterministic
if there is no mechanism to pass it from controller driver
to sound card driver.

> Regards,
> 
> Markus

Best regards,
Maciej Szmigiero
