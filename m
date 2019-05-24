From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] pcm030-audio-fabric: Fix a memory leaking bug in
 pcm030_fabric_probe()
Date: Fri, 24 May 2019 10:30:09 +0100
Message-ID: <0fb5b294-99ba-bb73-a972-e1886dc6b792@nvidia.com>
References: <20190524021221.GA4753@zhanggen-UX430UQ>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524021221.GA4753@zhanggen-UX430UQ>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gen Zhang <blackgod016574@gmail.com>, broonie@kernel.org, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 24/05/2019 03:12, Gen Zhang wrote:
> In pcm030_fabric_probe(), 'pdata->codec_device' is allocated by
> platform_device_alloc(). When this allocation fails, ENOMEM is returned.
> However, 'pdata' is allocated by devm_kzalloc() before this site. We
> should free 'pdata' before function ends to prevent memory leaking.
> 
> Similarly, we should free 'pdata' when 'pdata->codec_device' is NULL.
> And we should free 'pdata->codec_device' and 'pdata' when 'ret' is error
> to prevent memory leaking.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

I have seen several of these patches now, and this is not correct. I
think you need to understand how devm_kzalloc() works.

Jon

-- 
nvpublic
