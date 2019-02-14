From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 0/2] ASoC: da7219: BCLK and TDM flexibility
	improvements
Date: Thu, 14 Feb 2019 09:33:31 +0000
Message-ID: <AM5PR1001MB099488F6A0CF887CE90C41E880670@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FCE2267482
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 10:33:34 +0100 (CET)
In-Reply-To: <cover.1550079836.git.Adam.Thomson.Opensource@diasemi.com>
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
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

On 13 February 2019 17:48, Adam Thomson wrote:

 This patch set updates the driver to be more flexible regarding the BCLK and TDM
> configurations of the device.
> 
> Previously the BCLK rate was fixed at 64 periods per WCLK, when the codec is DAI
> clock master, but to satisfy devices which prefer a lower rate, and to save power,
> the BCLK rate is now calculated based on hw_params() data.
> 
> As a fallout of the BCLK efforts it was also apparent that the TDM code could be
> made more flexible as well. The device is capable of automatically detecting the
> BCLK rate when it is clock slave, so previous limitations imposed were not
> necessary. The mask handling is now used as an input to determine the BCLK
> offset to align closer with other examples within ALSA.

Spotted a silly '&' instead of '&&' error in the 1st patch. Functionally will work
but technically should be updated. Will send V2 soon.

> 
> Adam Thomson (2):
>   ASoC: da7219: Add support for master mode BCLK rate adjustment
>   ASoC: da7219: Update TDM usage to be more flexible
> 
>  sound/soc/codecs/da7219.c | 116 +++++++++++++++++++++++++++++----------
> -------
>  sound/soc/codecs/da7219.h |   1 +
>  2 files changed, 74 insertions(+), 43 deletions(-)
> 
> --
> 1.9.1
