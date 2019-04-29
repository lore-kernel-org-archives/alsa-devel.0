From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/1] ASoC: Intel: Skylake: change list
 empty check to warning
Date: Mon, 29 Apr 2019 08:05:22 -0500
Message-ID: <e7db2293-dda5-7aa1-f3be-8a9cdf707847@linux.intel.com>
References: <20190425215743.88673-1-patrick.waterlander@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190425215743.88673-1-patrick.waterlander@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Patrick Waterlander <patrick.waterlander@intel.com>, patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Kaczmarski,
 Filip" <filip.kaczmarski@intel.com>
List-Id: alsa-devel@alsa-project.org

On 4/25/19 4:57 PM, Patrick Waterlander wrote:
> NULL is a valid state for the module list when querying unique ID.
> Downgrade the empty condition from error to warning.
> 
> Signed-off-by: Patrick Waterlander <patrick.waterlander@intel.com>
> 
> diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
> index 5951bbdf1f1a..95e6a23538cd 100644
> --- a/sound/soc/intel/skylake/skl-sst.c
> +++ b/sound/soc/intel/skylake/skl-sst.c
> @@ -324,7 +324,7 @@ static struct skl_module_table *skl_module_get_from_id(
>   	struct skl_module_table *module;
>   
>   	if (list_empty(&ctx->module_list)) {
> -		dev_err(ctx->dev, "Module list is empty\n");
> +		dev_warn(ctx->dev, "Module list is empty\n");

Not sure what you are trying to fix here? Either it's an error and we 
can keep the message as is or it's not and that trace should go away. 
Changing the level doesn't really add much value, does it?

You should run this by Filip's team (CC:ed) and copy maintainers.

>   		return NULL;
>   	}
>   
> 
