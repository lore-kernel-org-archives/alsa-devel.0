From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] ASoC: Replace remaining users of the
	CODEC mutex
Date: Mon, 10 Nov 2014 08:49:30 +0000
Message-ID: <20141110084930.GA23178@opensource.wolfsonmicro.com>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A857A260653
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 09:49:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1415548864-27203-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 09, 2014 at 05:00:56PM +0100, Lars-Peter Clausen wrote:
> We've stopped using the snd_soc_codec mutex in the ASoC core itself a while
> ago. There is still a handful of drivers which use the mutex to protect some
> of their data structures. This patch moves the lock for the remaining users
> to the drivers private data struct and then removes it from the
> snd_soc_codec struct.
> 
> - Lars
> 
> Lars-Peter Clausen (8):
>   ASoC: ab8500-codec: Move control lock to the driver level
>   ASoC: max98095: Move mutex to the driver level
>   ASoC: wm5102: Move ultrasonic response settings lock to the driver
>     level
>   ASoC: wm8731: Move the deemph lock to the driver level
>   ASoC: wm8903: Move the deemph lock to the driver level
>   ASoC: wm8958: Move DSP firmware lock to driver level
>   ASoC: wm8962: Move DSP enable lock to the driver level
>   ASoC: Remove CODEC mutex
> 
>  include/linux/mfd/arizona/core.h |  1 +
>  include/sound/soc.h              |  1 -
>  sound/soc/codecs/ab8500-codec.c  | 32 ++++++++++++++++----------------
>  sound/soc/codecs/arizona.c       |  4 ++--
>  sound/soc/codecs/max98095.c      | 12 ++++++++----
>  sound/soc/codecs/wm5102.c        | 16 ++++++++--------
>  sound/soc/codecs/wm8731.c        |  9 +++++++--
>  sound/soc/codecs/wm8903.c        |  8 ++++++--
>  sound/soc/codecs/wm8958-dsp2.c   | 12 ++++++------
>  sound/soc/codecs/wm8962.c        |  8 ++++++--
>  sound/soc/codecs/wm8994.c        |  2 ++
>  sound/soc/codecs/wm8994.h        |  2 ++
>  sound/soc/soc-core.c             |  1 -
>  13 files changed, 64 insertions(+), 44 deletions(-)
> 
> -- 
> 1.8.0
> 

For the Wolfson parts:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
