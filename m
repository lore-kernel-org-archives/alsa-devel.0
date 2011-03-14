From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] omap3: alsa-soc: Remove restrictive check for cpu type
Date: Mon, 14 Mar 2011 15:55:42 +0200
Message-ID: <20110314155542.b60bd852.jhnikula@gmail.com>
References: <1300109513-29002-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1300109513-29002-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, 14 Mar 2011 19:01:53 +0530
Sanjeev Premi <premi@ti.com> wrote:

> Current check for cpu type is too restrictive leading to
> failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
There are two other cpu_is_omap343x tests as well. Care to check them
too?

-- 
Jarkko
