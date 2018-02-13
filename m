From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: arizona: replace codec to
 component
Date: Tue, 13 Feb 2018 17:42:01 +0000
Message-ID: <20180213174201.lubz2po4n2v5yfvj@localhost.localdomain>
References: <87a7wdlkdx.wl%kuninori.morimoto.gx@renesas.com>
 <877erhlkb0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 614FA267963
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 18:42:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <877erhlkb0.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 13, 2018 at 02:03:12AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now we can replace Codec to Component. Let's do it.
> 
> Because there are many drivers which are using arizona,
> we need to update these all related drivers in same time.
> Otherwise compile error/warning happen
> 
> Note:
> 
> cs47l24
> 	xxx_codec_xxx()		->	xxx_component_xxx()
> 	.idle_bias_off = 1	->	.idle_bias_on = 0
> 	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
> 	-			->	.endianness = 1
> 	-			->	.non_legacy_dai_naming = 1
> 
> wm5102
> 	xxx_codec_xxx()		->	xxx_component_xxx()
> 	.idle_bias_off = 1	->	.idle_bias_on = 0
> 	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
> 	-			->	.endianness = 1
> 	-			->	.non_legacy_dai_naming = 1
> 
> wm5110
> 	xxx_codec_xxx()		->	xxx_component_xxx()
> 	.idle_bias_off = 1	->	.idle_bias_on = 0
> 	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
> 	-			->	.endianness = 1
> 	-			->	.non_legacy_dai_naming = 1
> 
> wm8997
> 	xxx_codec_xxx()		->	xxx_component_xxx()
> 	.idle_bias_off = 1	->	.idle_bias_on = 0
> 	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
> 	-			->	.endianness = 1
> 	-			->	.non_legacy_dai_naming = 1
> 
> wm8998
> 	xxx_codec_xxx()		->	xxx_component_xxx()
> 	.idle_bias_off = 1	->	.idle_bias_on = 0
> 	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
> 	-			->	.endianness = 1
> 	-			->	.non_legacy_dai_naming = 1
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Please make sure you are at least putting
patches@opensource.cirrus.com on the CC for patches to the Arizona
CODECs, in this case I probably would have expected a direct CC
since it has my tested-by on it.

I would have really liked to see the formatting fix ups going
along with this, even if in a separate patch to easy our diff
concerns. But I guess I can apply those myself, and since
this is the last one in the chain waiting to go in:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
