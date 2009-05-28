From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 4/6] ARM: DaVinci: ASoC: Add dummy	codec
	support
Date: Thu, 28 May 2009 14:53:33 +0100
Message-ID: <20090528135333.GD19523@sirena.org.uk>
References: <1243501850-28531-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B9C11245DC
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 15:53:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1243501850-28531-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>, alsa-devel@alsa-project.org, Steve Chen <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2009 at 05:10:50AM -0400, Chaithrika U S wrote:

> +static int spdif_dit_probe(struct platform_device *pdev)
> +{
> +	return snd_soc_register_dai(&dit_stub_dai);
> +}

This driver is good except that the DAI should have ->dev filled in with
the struct device for the platform device.  I'll apply the patch and fix
this myself, no need to resubmit.

Thanks!
