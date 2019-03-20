From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] slimbus: ngd: Fix to avoid potential NULL pointer
 dereference
Date: Wed, 20 Mar 2019 14:47:13 +0000
Message-ID: <9508fd1e-7083-4bb7-eaa4-6986ef097d0d@linaro.org>
References: <20190319012523.14644-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319012523.14644-1-pakki001@umn.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: kjlu@umn.edu, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 19/03/2019 01:25, Aditya Pakki wrote:
> In of_qcom_slim_ngd_register, of_match_node may fail and return a NULL
> pointer. This patch avoids such a scenario leading to NULL pointer
> dereference.
> 
> Fixes: 458a445deb9c ("slimbus: ngd: Fix build error on x86")
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 71f094c9ec68..9cc7256028c9 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1332,6 +1332,8 @@ static int of_qcom_slim_ngd_register(struct device *parent,
>   	u32 id;
>   
>   	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
> +	if (!match)
> +		return -ENXIO;

We would not even enter this path without matching compatible, so I 
think a check here is not really necessary.

thanks,
srini
