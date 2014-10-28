From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/11] drivers: char: axd: add sysfs setup files
Date: Tue, 28 Oct 2014 22:12:55 +0800
Message-ID: <20141028141255.GC18384@kroah.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com>
 <1414495589-8579-10-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414495589-8579-10-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2014 at 11:26:27AM +0000, Qais Yousef wrote:
> +/* Control Device Sysfs Attributes */
> +/* version */
> +static ssize_t show_version(struct device *dev, struct device_attribute *attr,
> +							char *buf)
> +{
> +	struct axd_cmd *cmd = (struct axd_cmd *)dev->platform_data;
> +	int major, minor, patch;
> +
> +	axd_cmd_get_version(cmd, &major, &minor, &patch);
> +	return sprintf(buf, "%u.%u.%u\n", major, minor, patch);
> +}
> +static DEVICE_ATTR(version, RD_PERMS, show_version, NULL);

DEVICE_ATTR_RO() please.  Same for all other instances, you should never
use DEVICE_ATTR() anymore.

thanks,

greg k-h
