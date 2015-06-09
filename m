From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH] mfd: wm8994: Fix NULL pointer exception
	on missing pdata
Date: Tue, 9 Jun 2015 14:56:06 +0100
Message-ID: <20150609135606.GF32730@opensource.wolfsonmicro.com>
References: <1433845112-371-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433845112-371-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: broonie@kernel.org, lee.jones@linaro.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 09, 2015 at 07:18:32PM +0900, Inha Song wrote:
> If we use the dev_get_platdata, pdata can be NULL in DT environments.
> Actually, NULL pointer exception is occurs with error messages like this:
> 
> [    1.226583] Unable to handle kernel NULL pointer dereference at virtual address 00000044
> [    1.467910] [<c02f1e38>] (wm8994_irq_init) from [<c02f1bd4>] (wm8994_i2c_probe+0x684/0x858)
> [    1.476241] [<c02f1bd4>] (wm8994_i2c_probe) from [<c0371c78>] (i2c_device_probe+0x11c/0x17c)
> 
> In wm8994-core, we already checked wheter platform data is NULL and set the
> wm8994->pdata to platform data if platform data is not NULL.
> So, we can use wm8994->pdata instead of platform data.
> 
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
