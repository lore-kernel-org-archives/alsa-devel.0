From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V3 1/2] ASoC: core: add API for registering
 DMI card names
Date: Thu, 31 Mar 2016 14:00:43 +0200
Message-ID: <56FD116B.7000703@metafoo.de>
References: <cover.1459414492.git.han.lu@intel.com>
 <79fd64c59dd44d44e018245ad411d48f5ba01b24.1459414492.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 3868E2612CC
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 14:00:51 +0200 (CEST)
In-Reply-To: <79fd64c59dd44d44e018245ad411d48f5ba01b24.1459414492.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: han.lu@intel.com, broonie@kernel.org, tiwai@suse.de, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/31/2016 10:58 AM, han.lu@intel.com wrote:
[...]
> +	name_size = strlen(card->name) + strlen(card->driver_name)
> +			+ strlen(vendor) + strlen(firmware) + 4;
> +	if (buf_size < name_size + strlen(card->snd_card->components))
> +		return -ENOMEM;
> +	name = kmalloc(buf_size, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +	snprintf(name, buf_size, "%s:%s:%s:%s", card->name,
> +			card->driver_name, vendor, firmware);

Have a look at kasprintf(). It will allow you to simplify the code here
