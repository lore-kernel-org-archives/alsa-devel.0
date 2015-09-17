From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] audio: sai: Add Power Management support
Date: Wed, 16 Sep 2015 23:57:33 -0700
Message-ID: <20150917065732.GB54360@Asurada-CZ80>
References: <1442221404-35240-1-git-send-email-b18965@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442221404-35240-1-git-send-email-b18965@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alison Wang <b18965@freescale.com>
Cc: broonie@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@freescale.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Alison Wang <alison.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 14, 2015 at 05:03:24PM +0800, Alison Wang wrote:
> This patch adds Power Management support for SAI.
> Activate regmap cache with REGCACHE_FLAT, and use
> regmap cache code to save and restore registers in
> suspend and resume. The Transmit Control Register
> (TCSR) and Receive Control Register(RCSR) should
> be volatile registers.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>

Just to remind that there was a similar patch in review that I just
acked. Please send your improvements as an incremental patch after
that one gets applied.

Please also pay attention to the patch subject which should follow
the pattern of previous patches of the driver: ASoC: fsl_sai: xxxx

Thanks
Nicolin
