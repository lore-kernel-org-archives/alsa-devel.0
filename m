From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH][RESEND 5/8] uio: uio_pruss: use gen_pool_dma_alloc() to
 allocate sram memory
Date: Sun, 8 Dec 2013 17:39:56 -0800
Message-ID: <20131209013956.GA5385@kroah.com>
References: <cover.1383306365.git.b42378@freescale.com>
 <f26a7fd466d22aaaeae9cf32d3c4c43c333e0b35.1383306365.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f26a7fd466d22aaaeae9cf32d3c4c43c333e0b35.1383306365.git.b42378@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>
Cc: akpm@linux-foundation.org, joe@perches.com, nsekhar@ti.com, khilman@deeprootsystems.com, linux@arm.linux.org.uk, dan.j.williams@intel.com, vinod.koul@intel.com, m.chehab@samsung.com, hjk@hansjkoch.de, perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, rmk+kernel@arm.linux.org.uk, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 01, 2013 at 07:48:18PM +0800, Nicolin Chen wrote:
> Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
