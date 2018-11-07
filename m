From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/1] slimbus: qcom-ctrl: simplify getting .driver_data
Date: Wed, 7 Nov 2018 09:27:58 +0000
Message-ID: <40978484-383a-6cd8-9d4d-9b3185583b69@linaro.org>
References: <20181021200045.2053-1-wsa+renesas@sang-engineering.com>
 <20181021200045.2053-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200045.2053-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 21/10/18 21:00, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang<wsa+renesas@sang-engineering.com>
> ---
Applied to slimbus tree!
