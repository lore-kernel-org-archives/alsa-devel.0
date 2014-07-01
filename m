From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
	multicodec
Date: Tue, 1 Jul 2014 21:55:40 +0530
Message-ID: <20140701162540.GG2296@intel.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
 <53B2BC7F.2060909@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4123126570F
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 18:26:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53B2BC7F.2060909@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 01, 2014 at 03:49:51PM +0200, Lars-Peter Clausen wrote:
> On 07/01/2014 09:47 AM, Benoit Cousson wrote:
And you should have cced me on this patch

> [...]
> for (i = 0; i < rtd->num_codecs; i++) {
> >+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> >+		/* check client and interface hw capabilities */
> >+		snprintf(new_name, sizeof(new_name), "%s %s-%d",
> >+			 rtd->dai_link->stream_name, codec_dai->name, num);
> 
> We may need to rethink how to do the naming for multiple CODEC DAI
> links here. This implementation will just keep overwriting new_name
> with each loop iteration and end up using the last one. Vinod may
> have some insights.

I am intrugued on how we do this for pcms with multi-codec support.

Looking at the patch series I dont think the soc_pcm_new() has been updated
(please point out if i missed, it is late in night)
Shouldnt this be updated for pcm too?

I would suggest makes sense is to keep appending the codec name for the
dai-link. But yes keep a check on the size. Unless we have better ideas.

-- 
~Vinod
