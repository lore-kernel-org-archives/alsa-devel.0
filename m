From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2 amplifier driver
Date: Fri, 9 Oct 2009 19:15:38 +0100
Message-ID: <20091009181538.GB20083@sirena.org.uk>
References: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F168410381B
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 20:15:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, eduardo.valentin@nokia.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 09, 2009 at 03:55:41PM +0300, Peter Ujfalusi wrote:

> +struct i2c_client *tpa6130a2_client;

This should be static.

> +void tpa6130a2_power(int power)
> +{

This should either be static or have an EXPORT_SYMBOL_GPL() - I'd expect
the former since this is being managed via DAPM.

> +	pdata = (struct tpa6130a2_platform_data *)client->dev.platform_data;

You should never need to cast away from void, and doing so can mask
actual errors.

> +fail:
> +       kfree(data);
> +       i2c_set_clientdata(tpa6130a2_client, NULL);
> +       tpa6130a2_client = 0;

The kernel coding style is to use an explict NULL.

Other than that everything looks good so I've applied this with the
fixes I noted above.  If you could send a followup patch for the
tpa6130a2_power export/static thing that'd be good.

Thanks!
