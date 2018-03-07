From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] slimbus: core: use put_device() instead of kfree()
Date: Wed, 7 Mar 2018 10:45:50 +0000
Message-ID: <55c2399e-3136-4a90-26ac-0ebcb2918a15@linaro.org>
References: <9d7f5ca30baa3a336b145a96a631a8c093f54d8b.1520418001.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9d7f5ca30baa3a336b145a96a631a8c093f54d8b.1520418001.git.arvind.yadav.cs@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, broonie@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 07/03/18 10:22, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/slimbus/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Looks good for me,

Will queue it up.

> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 4988a8f..7ddfc67 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -141,7 +141,7 @@ static struct slim_device *slim_alloc_device(struct slim_controller *ctrl,
>   	sbdev->e_addr = *eaddr;
>   	ret = slim_add_device(ctrl, sbdev, node);
>   	if (ret) {
> -		kfree(sbdev);
> +		put_device(&sbdev->dev);
>   		return NULL;
>   	}
>   
> 

thanks,
srini
