From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: RE: [PATCH 1/1] [ASOC]: AD1980 audio codec ASOC driver
Date: Tue, 13 May 2008 11:00:58 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA01F2EF2C@chinexm1.ad.analog.com>
References: <1210589112-12208-1-git-send-email-cooloney@kernel.org> <20080512115416.GB23216@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757294AbYEMC7A@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080512115416.GB23216@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Bryan Wu <cooloney@kernel.org>
Cc: liam.girdwood@wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


 ok,we will implement these two functions later.

Best Regards
Cliff Cai

-----Original Message-----
From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
Sent: Monday, May 12, 2008 7:54 PM
To: Bryan Wu
Cc: liam.girdwood@wolfsonmicro.com; linux-kernel@vger.kernel.org; Cliff
Cai; alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/1] [ASOC]: AD1980 audio codec ASOC driver

On Mon, May 12, 2008 at 06:45:12PM +0800, Bryan Wu wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>

Thanks, I've applied this to the ASoC git tree.  CCing in
alsa-devel@alsa-project.org - ALSA patches should go via there.

> +static int ad1980_soc_suspend(struct platform_device *pdev,
> +	pm_message_t state)
> +{
> +	return 0;
> +}
> +
> +static int ad1980_soc_resume(struct platform_device *pdev) {
> +	return 0;
> +}

Are you sure about these?  I would expect the suspend and resume
functions to either do some register writes or be omitted if they don't
do anything.  Standard AC97 codecs would have some power management via
register 0x26 if they were doing anything.
