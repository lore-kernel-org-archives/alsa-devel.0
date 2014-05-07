From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 2/4] ASoC: Intel: Add merrifield machine
 driver
Date: Wed, 7 May 2014 10:21:17 +0530
Message-ID: <20140507045117.GF28638@intel.com>
References: <1399312908-20744-1-git-send-email-vinod.koul@intel.com>
 <1399312908-20744-3-git-send-email-vinod.koul@intel.com>
 <536905CD.4030007@metafoo.de> <20140506165820.GE28638@intel.com>
 <5369272E.5010803@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 427272652B0
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 07:04:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5369272E.5010803@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, broonie@kernel.org
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 06, 2014 at 08:17:18PM +0200, Lars-Peter Clausen wrote:
> On 05/06/2014 06:58 PM, Vinod Koul wrote:
> >On Tue, May 06, 2014 at 05:54:53PM +0200, Lars-Peter Clausen wrote:
> >>On 05/05/2014 08:01 PM, Vinod Koul wrote:
> >>[...]
> >>>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >>>+
> >>>+#include <linux/module.h>
> >>>+#include <linux/init.h>
> >>>+#include <linux/device.h>
> >>>+#include <linux/slab.h>
> >>>+#include <linux/io.h>
> >>>+#include <linux/async.h>
> >>>+#include <linux/delay.h>
> >>>+#include <linux/gpio.h>
> >>>+#include <sound/pcm.h>
> >>>+#include <sound/pcm_params.h>
> >>>+#include <sound/soc.h>
> >>>+#include <sound/jack.h>
> >>>+#include <linux/input.h>
> >>>+
> >>>+#include <linux/mfd/wm8994/core.h>
> >>>+#include <linux/mfd/wm8994/registers.h>
> >>>+#include <linux/mfd/wm8994/pdata.h>
> >>>+#include "../../codecs/wm8994.h"
> >>>+#include "../platform-libs/controls_v2.h"
> >>
> >>I don't think that include exists in upstream.
> >which one ../platform-libs/controls_v2.h is part of this patch.
> 
> I just saw it's part of patch 4 of this series. But still, it should
> added before the user is added.
Yes :)

And i dont use in below code so would remove for now...
Later additions to thsi would use these defines so would amke sense to add then.

> 
> [..]
> >>
> >>>+static struct snd_soc_dai *find_codec_dai(struct snd_soc_card *card, const char *dai_name)
> >>>+{
> >>>+	int i;
> >>>+	for (i = 0; i < card->num_rtd; i++) {
> >>>+		if (!strcmp(card->rtd[i].codec_dai->name, dai_name))
> >>>+			return card->rtd[i].codec_dai;
> >>>+	}
> >>>+	pr_err("%s: unable to find codec dai\n", __func__);
> >>>+	/* this should never occur */
> >>>+	WARN_ON(1);
> >>>+	return NULL;
> >>>+}
> >>
> >>The proper way to do this is to implement the init callback for the
> >>dai link. There you get a pointer to the codec and the dai and
> >>everything else. If you need one for later store them in the private
> >>struct of the card driver.
> >again the driver would need to store the pointers to cards (we multi codec
> >systems) and multi dais. Somehow I dont feel this might be worth thr trouble.
> >Earlier we always had card->codec pointing to _one_ codec but with multi-codec
> >systems that is not the case, so we need ot lookup, but yes am not sure if above
> >is best way or something else..
> 
> Another thing you could do is just use card->rtd[X].codec_dai. The
> rtds are in the same order as the DAI links so you know which rtd is
> for which DAI.
that should work too..
Mark, Any comments on these approaches before I modify the code?

-- 
~Vinod
