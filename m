From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] slimbus: fix a NULL pointer dereference in
 of_qcom_slim_ngd_register
Date: Wed, 20 Mar 2019 14:52:08 +0000
Message-ID: <6f7c2485-ef98-491f-185d-420a6373bfb3@linaro.org>
References: <20190315062048.16642-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315062048.16642-1-kjlu@umn.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 15/03/2019 06:20, Kangjie Lu wrote:
> In case platform_device_alloc fails, the fix returns an error
> code to avoid the NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
Thanks Applied.

--srini
