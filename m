From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 09/11] drivers: char: axd: add sysfs setup files
Date: Tue, 28 Oct 2014 14:39:18 +0000
Message-ID: <544FAA96.9080006@imgtec.com>
References: <1414495589-8579-1-git-send-email-qais.yousef@imgtec.com> <1414495589-8579-10-git-send-email-qais.yousef@imgtec.com> <20141028141255.GC18384@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141028141255.GC18384@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/28/2014 02:12 PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 28, 2014 at 11:26:27AM +0000, Qais Yousef wrote:
>> +/* Control Device Sysfs Attributes */
>> +/* version */
>> +static ssize_t show_version(struct device *dev, struct device_attribute *attr,
>> +							char *buf)
>> +{
>> +	struct axd_cmd *cmd = (struct axd_cmd *)dev->platform_data;
>> +	int major, minor, patch;
>> +
>> +	axd_cmd_get_version(cmd, &major, &minor, &patch);
>> +	return sprintf(buf, "%u.%u.%u\n", major, minor, patch);
>> +}
>> +static DEVICE_ATTR(version, RD_PERMS, show_version, NULL);
> DEVICE_ATTR_RO() please.  Same for all other instances, you should never
> use DEVICE_ATTR() anymore.
>
> thanks,
>
> greg k-h

OK. I missed the transition to the new macro. I'll fix that.

Thanks,
Qais
