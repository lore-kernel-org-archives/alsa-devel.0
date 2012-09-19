From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/7] ASoC: fsl: convert pcm030-audio-fabric
 to a platform-driver
Date: Tue, 18 Sep 2012 23:03:24 -0400
Message-ID: <20120919030324.GO8832@opensource.wolfsonmicro.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5399026512E
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 05:03:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 05:43:14PM -0400, Eric Millbrandt wrote:

> +static int __devexit pcm030_fabric_remove(struct platform_device *op)
> +{
> +	struct platform_device *pdev = platform_get_drvdata(op);
> +
> +	platform_device_unregister(pdev);
> +
> +	return 0;
> +}

This seems really confused...  why is a platform device registering
another platform device?  Do you mean to convert to
snd_soc_register_card()?
