From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Kcontrols for ASoC TWL4030 CODEC
Date: Thu, 20 Nov 2008 13:36:45 +0000
Message-ID: <20081120133644.GE4539@sirena.org.uk>
References: <ef0d8a250811200442j3146441cgc4650153974e62d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 516FC2437B
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 14:36:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250811200442j3146441cgc4650153974e62d6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 06:12:56PM +0530, naveen krishna ch wrote:

>  static const struct snd_kcontrol_new twl4030_snd_controls[] = {
> -    SOC_DOUBLE_R("Master Playback Volume",
> -         TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> -        0, 127, 0),
> -    SOC_DOUBLE_R("Capture Volume",
> -         TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
> -        0, 127, 0),
> +
> +    /* Master Playback Volume Controls */
> +        SOC_DOUBLE_R("Master PLayback Course Gain",
> +                TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> +                6, 3, 0),
> +

Please see the comments I made in response to your original posting -
there look to be problems with your indentation here and your control
names should conform to the ALSA control naming standard in:

	Documentation/sound/alsa/ControlNames.txt
