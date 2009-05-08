From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: Added OMAP3 EVM support in ASoC.
Date: Fri, 8 May 2009 11:20:42 +0100
Message-ID: <20090508102041.GA5654@sirena.org.uk>
References: <1241712527-16269-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1241712527-16269-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, getarunks@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2009 at 09:38:47PM +0530, Anuj Aggarwal wrote:

> +	if (!machine_is_omap3evm()) {
> +		pr_debug("Not OMAP3 EVM!\n");
> +		return -ENODEV;
> +	}

Since you've said you'll be resubmitting perhaps this should be an error
rather than debug message?
