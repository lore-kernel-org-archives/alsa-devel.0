From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: rt5640: Add support for
 rt5640 sound card found on HP Pavilion x2 10-p000 tablet.
Date: Thu, 5 Jan 2017 09:19:49 +0530
Message-ID: <20170105034948.GJ3573@localhost>
References: <cover.1483531270.git.neko@nya.ai>
 <9e2493401df1f2f0419fa175b4fc9a84eb971e28.1483531270.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 000E8266539
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 04:49:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9e2493401df1f2f0419fa175b4fc9a84eb971e28.1483531270.git.neko@nya.ai>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandrov Stansilav <neko@nya.ai>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 04, 2017 at 03:22:12PM +0300, Alexandrov Stansilav wrote:

This looks okay, but title is same for both of the patches. It would be
better to describe the change you are doing and not the outcome.

so a better title could be:

ASoC: rt5640: Add "10EC3276" ACPI ID

and in log say:

HP Pavilion x2 10-p000 comes with rt5640 with ACPI ID "10EC3276" so add
that.

> Signed-off-by: Alexandrov Stansilav <neko@nya.ai>
> ---
>  sound/soc/codecs/rt5640.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> index e29a6de..b857a71 100644
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -2313,6 +2313,7 @@ MODULE_DEVICE_TABLE(of, rt5640_of_match);
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id rt5640_acpi_match[] = {
>  	{ "INT33CA", 0 },
> +	{ "10EC3276", 0 },
>  	{ "10EC5640", 0 },
>  	{ "10EC5642", 0 },
>  	{ "INTCCFFD", 0 },
> -- 
> 2.10.2
> 

-- 
~Vinod
