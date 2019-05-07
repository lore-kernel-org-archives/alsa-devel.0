From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/8] soundwire: mipi_disco: fix master/link error
Date: Mon, 6 May 2019 20:58:21 -0500
Message-ID: <42f30108-6870-d97b-7766-ce7a7f17ccf8@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504002926.28815-3-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 5/3/19 7:29 PM, Pierre-Louis Bossart wrote:
> The MIPI DisCo specification for SoundWire defines the
> "mipi-sdw-link-N-subproperties", not the master-N properties. Fix to
> parse firmware information.

Please ignore this patch for now, there is a confusion in the spec 
itself that needs to be addressed by MIPI... Either there will be an 
errata issued, or we'll have to try both master- and link-N-properties 
to reconcile spec and actual implementations.

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/soundwire/mipi_disco.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
> index c1f51d6a23d2..6df68584c963 100644
> --- a/drivers/soundwire/mipi_disco.c
> +++ b/drivers/soundwire/mipi_disco.c
> @@ -40,7 +40,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
>   
>   	/* Find master handle */
>   	snprintf(name, sizeof(name),
> -		 "mipi-sdw-master-%d-subproperties", bus->link_id);
> +		 "mipi-sdw-link-%d-subproperties", bus->link_id);
>   
>   	link = device_get_named_child_node(bus->dev, name);
>   	if (!link) {
> 
