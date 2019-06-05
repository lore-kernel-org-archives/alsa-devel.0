From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 3/6] ASoC: madera: Add common support
 for Cirrus Logic Madera codecs
Date: Wed, 5 Jun 2019 11:17:40 +0100
Message-ID: <20190605101740.GN28362@ediswmail.ad.cirrus.com>
References: <20190528154312.14435-1-ckeepax@opensource.cirrus.com>
 <20190528154312.14435-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1083F808E7
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2019 12:17:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190528154312.14435-3-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, rafael@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com, robh+dt@kernel.org, patches@opensource.cirrus.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 28, 2019 at 04:43:09PM +0100, Charles Keepax wrote:
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> The Cirrus Logic Madera codecs are a family of related codecs with
> extensive digital and analogue I/O, digital mixing and routing,
> signal processing and programmable DSPs. This patch adds common
> support code shared by all Madera codecs.
> 
> This patch also adds the pdata to the parent mfd pdata struct.
> Since there is a circular build dependency it's convenient to
> patch them both atomically.
> 
> Signed-off-by: Nariman Poushin <nariman@opensource.cirrus.com>
> Signed-off-by: Nikesh Oswal <Nikesh.Oswal@cirrus.com>
> Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
> Signed-off-by: Ajit Pandey <ajit.pandey@incubesol.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> +static int madera_inmux_put(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{

Looks like there are still some issues with the inmux handling
here, afraid I will probably need to do a v3 to fix them up.

Thanks,
Charles
