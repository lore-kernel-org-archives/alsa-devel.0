From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 0/2] ASoC: da7219: Improvements to DAI
 clocks handling in driver
Date: Wed, 9 Jan 2019 14:38:44 +0000
Message-ID: <AM5PR1001MB099499F06884D00319A061EE808B0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.114])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FF78266875
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 15:38:49 +0100 (CET)
In-Reply-To: <cover.1546876084.git.Adam.Thomson.Opensource@diasemi.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Kurtz <djkurtz@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

On 08 January 2019 09:13, Adam Thomson wrote:

> This small patchset provides improvements to CCF based clock handling relating
> to the DAI clocks. In the first patch MCLK is made parent of DAI clocks, if MCLK
> has been provided to the driver, which means that MCLK will automatically be
> enabled as a prerequisite to DAI clocks. The second patch adds the ability to read
> the WCLK rate provided by the codec when DAI clocks are featured. This is more
> useful than the returned rate simply being the rate of the parent clock, which in
> this case would be MCLK.

Apologies for repeat submissions. Had some glitches with mail servers here.
 
> Adam Thomson (2):
>   ASoC: da7219: MCLK should be enabled before DAI clocks
>   ASoC: da7219: Add recalc_rate function to return DAI clock rate
> 
>  sound/soc/codecs/da7219.c | 77
> ++++++++++++++++++++++++++++++++++++++++-------
>  sound/soc/codecs/da7219.h |  1 +
>  2 files changed, 67 insertions(+), 11 deletions(-)
> 
> --
> 1.9.1
