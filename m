From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dfbmcs320: make the driver common
 for other BT modules
Date: Thu, 16 May 2013 11:51:56 +0200
Message-ID: <5194AC3C.4080206@metafoo.de>
References: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-153.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id EC685265375
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 11:52:20 +0200 (CEST)
In-Reply-To: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <Baohua.Song@csr.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, workgroup.linux@csr.com, Graeme Gregory <graeme@openmoko.org>, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 05/16/2013 08:53 AM, Barry Song wrote:
> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
> we don't want everyone to have a seperate codec driver. anyway, the
> feature of Bluetooth handsfree is same on all platforms, so this patch
> makes the DFBM-CS320 driver become a common BT handsfree driver.
[...]
> -static struct platform_driver dfmcs320_driver = {
> +static struct platform_driver bt_handsfree_driver = {
>  	.driver = {
> -		.name = "dfbmcs320",
> +		.name = "bt-handsfree",
>  		.owner = THIS_MODULE,

In my opinion it's a good idea to keep a platform_id list of all the
supported devices.

>  	},
> -	.probe = dfbmcs320_probe,
> -	.remove = dfbmcs320_remove,
> +	.probe = bt_handsfree_probe,
> +	.remove = bt_handsfree_remove,
>  };
>  
> -module_platform_driver(dfmcs320_driver);
> +module_platform_driver(bt_handsfree_driver);
