From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ARM DaVinci: Add Right-Justified mode and
	Codec clock master to davinci-i2s
Date: Mon, 10 Nov 2008 11:42:24 +0000
Message-ID: <20081110114223.GB12804@sirena.org.uk>
References: <1226168769-17776-1-git-send-email-hugo.villeneuve@lyrtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 90C24103827
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 12:42:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226168769-17776-1-git-send-email-hugo.villeneuve@lyrtech.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hugo.villeneuve@lyrtech.com
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 08, 2008 at 01:26:09PM -0500, hugo.villeneuve@lyrtech.com wrote:
> From: Hugo Villeneuve <hugo.villeneuve@lyrtech.com>

> ARM DaVinci: Add Right-Justified mode and Codec clock master to davinci-i2s

Not a big deal but you shouldn't repeat the subject line of your patch
in the body - it causes automated tools like git am to duplicate it in
the commit mesage.

> The TI DVEVM board uses the SND_SOC_DAIFMT_CBM_CFM & I2S formats, but the
> Lyrtech SFFSDR board uses the SND_SOC_DAIFMT_CBM_CFS & RIGHT-JUSTIFIED formats.

Is there any news on the progress of the new DaVinci DMA API to
mainline?

> Signed-off-by: Hugo Villeneuve <hugo.villeneuve@lyrtech.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Takashi, I'm assembling another patch queue for you - should send it out
later today.
