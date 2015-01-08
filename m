From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RESEND PATCH] mfd: wm8994: set mfd id-base for
	regulator devs creation to avoid conflicts
Date: Thu, 8 Jan 2015 09:33:13 +0000
Message-ID: <20150108093313.GT14516@opensource.wolfsonmicro.com>
References: <1420679073-3316-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420679073-3316-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 08, 2015 at 10:04:33AM +0900, Inha Song wrote:
> After commit: 6e3f62f0793e ("mfd: core: Fix platform-device id generation")
> We must set the id base when register a duplicate name of mfd_cell.
> If not, duplicate filename error was reported.
> 
> - sysfs: cannot create duplicate filename '/devices/.../wm8994-ldo'
> 
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
