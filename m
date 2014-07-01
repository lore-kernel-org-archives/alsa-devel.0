From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 6/8] ASoC: compress: Add support for DAI
	multicodec
Date: Tue, 01 Jul 2014 15:49:51 +0200
Message-ID: <53B2BC7F.2060909@metafoo.de>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A682265056
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 15:49:56 +0200 (CEST)
In-Reply-To: <1404200881-32253-7-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: Vinod Koul <vinod.koul@intel.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/01/2014 09:47 AM, Benoit Cousson wrote:
[...]
for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> +		/* check client and interface hw capabilities */
> +		snprintf(new_name, sizeof(new_name), "%s %s-%d",
> +			 rtd->dai_link->stream_name, codec_dai->name, num);

We may need to rethink how to do the naming for multiple CODEC DAI links 
here. This implementation will just keep overwriting new_name with each loop 
iteration and end up using the last one. Vinod may have some insights.
