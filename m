From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 3/3] ASoC: Intel: atom: Add sysfs entry
 in order to store FW version
Date: Wed, 23 Nov 2016 13:38:47 +0530
Message-ID: <20161123080847.GH2698@localhost>
References: <20161123074513.28661-1-sebastien.guiriec@intel.com>
 <20161123074513.28661-4-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 75667266731
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 08:59:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161123074513.28661-4-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2016 at 08:45:13AM +0100, Sebastien Guiriec wrote:

> +static ssize_t firmware_version_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
> +
> +	if (ctx->fw_version.type == 0 && ctx->fw_version.major == 0 &&
> +	    ctx->fw_version.minor == 0 && ctx->fw_version.build == 0)
> +		return sprintf(buf, "FW not yet loaded\n");
> +	else
> +		return sprintf(buf, "v%02x.%02x.%02x.%02x\n",
> +			       ctx->fw_version.type, ctx->fw_version.major,
> +			       ctx->fw_version.minor, ctx->fw_version.build);
> +
> +}
> +
> +DEVICE_ATTR_RO(firmware_version);
> +
> +static const struct attribute *sst_fw_version_attrs[] = {
> +	&dev_attr_firmware_version.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group sst_fw_version_attr_group = {
> +	.attrs = (struct attribute **)sst_fw_version_attrs,
> +};

Hi Seb,

With each sysfs file (which is an ABI) we are supposed to update
Documentation/ABI/ as well, can you please add it

Sorry should have told you in last rev :(

-- 
~Vinod
