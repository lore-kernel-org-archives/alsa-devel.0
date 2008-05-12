From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] [ASOC]: AD1980 audio codec ASOC driver
Date: Mon, 12 May 2008 12:54:16 +0100
Message-ID: <20080512115416.GB23216@sirena.org.uk>
References: <1210589112-12208-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E66BB1037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 12 May 2008 13:54:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1210589112-12208-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: liam.girdwood@wolfsonmicro.com, Cliff Cai <cliff.cai@analog.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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
> +static int ad1980_soc_resume(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Are you sure about these?  I would expect the suspend and resume
functions to either do some register writes or be omitted if they don't
do anything.  Standard AC97 codecs would have some power management via
register 0x26 if they were doing anything.
