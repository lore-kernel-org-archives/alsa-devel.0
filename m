From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Pay attention to driver	supplied
	DAI IDs
Date: Tue, 12 Oct 2010 18:05:50 +0100
Message-ID: <20101012170550.GA10861@sirena.org.uk>
References: <1286895476-23198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E567A24472
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 19:05:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286895476-23198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 03:57:55PM +0100, Mark Brown wrote:
>  		dai->dev = dev;
> -		dai->id = i;
> +		if (dai->driver->id)
> +			dai->id = dai->driver->id;
> +		else
> +			dai->id = i;
>  		dai->driver = &dai_drv[i];

Sorry, sent the wrong version of this - obviously the new check should
go after the assignment.
