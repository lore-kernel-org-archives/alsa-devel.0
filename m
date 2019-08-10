From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] soundwire: cadence_master: add debugfs
	register dump
Date: Sat, 10 Aug 2019 09:03:08 +0200
Message-ID: <20190810070308.GB6896@kroah.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9900F8015B
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 09:03:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190809224341.15726-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 09, 2019 at 05:43:40PM -0500, Pierre-Louis Bossart wrote:
> +/**
> + * sdw_cdns_debugfs_init() - Cadence debugfs init
> + * @cdns: Cadence instance
> + * @root: debugfs root
> + */
> +void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
> +{
> +	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> +}
> +EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);

You create this function but never actually call it.  Don't add apis
that no one uses :(

thanks,

greg k-h
