From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 2/3] soundwire: cadence_master: add debugfs
 register dump
Date: Mon, 12 Aug 2019 08:32:41 -0500
Message-ID: <ac9170fe-03bd-f9c4-6afb-f9978b8cd95d@linux.intel.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-3-pierre-louis.bossart@linux.intel.com>
 <20190810070308.GB6896@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190810070308.GB6896@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/10/19 2:03 AM, Greg KH wrote:
> On Fri, Aug 09, 2019 at 05:43:40PM -0500, Pierre-Louis Bossart wrote:
>> +/**
>> + * sdw_cdns_debugfs_init() - Cadence debugfs init
>> + * @cdns: Cadence instance
>> + * @root: debugfs root
>> + */
>> +void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>> +{
>> +	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
>> +}
>> +EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
> 
> You create this function but never actually call it.  Don't add apis
> that no one uses :(

it is used in the follow-up patch.

+static void intel_debugfs_init(struct sdw_intel *sdw)
+{
+	struct dentry *root = sdw->cdns.bus.debugfs;
+
+	if (!root)
+		return;
+
+	sdw->fs = debugfs_create_dir("intel-sdw", root);
+
+	debugfs_create_file("intel-registers", 0400, sdw->fs, sdw,
+			    &intel_reg_fops);
+
+	sdw_cdns_debugfs_init(&sdw->cdns, sdw->fs); <<< HERE!
+}

The Cadence IP might be used by others so having a function that can be 
exported and used by others seems useful.
