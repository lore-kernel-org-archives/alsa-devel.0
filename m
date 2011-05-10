From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] ASoC: soc-cache: Introduce raw
	bulk	write support
Date: Tue, 10 May 2011 22:13:18 +0100
Message-ID: <20110510211317.GB17589@sirena.org.uk>
References: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1300790223-13308-7-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BC3F246EE
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 23:13:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1300790223-13308-7-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 22, 2011 at 10:37:03AM +0000, Dimitris Papastamos wrote:

> +	switch (codec->control_type) {
> +	case SND_SOC_I2C:
> +		ret = i2c_master_send(codec->control_data, data, len);
> +		break;
> +	case SND_SOC_SPI:
> +		ret = do_spi_write(codec->control_data, data, len);
> +		break;

Hrm, I now realise that this doesn't actually do what I'd expect - it
only writes out the provided data, there's no inclusion of the register
address.  I'd been mislead by the fact that it is taking in the register
address as an argument and an overly hasty review it seems.  That's a
little too raw for me, we should be prefixing the data with the base
register address.
