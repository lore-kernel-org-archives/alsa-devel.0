From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix incorrect condition check in trigger()
Date: Tue, 15 Apr 2014 10:33:26 +0800
Message-ID: <20140415023325.GE7197@MrMyself>
References: <1397225400-2769-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140414203126.GB25182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140414203126.GB25182@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 14, 2014 at 09:31:26PM +0100, Mark Brown wrote:
> On Fri, Apr 11, 2014 at 10:10:00PM +0800, Nicolin Chen wrote:
> 
> > +		/* Check if the opposite FRDE is also disabled */
> > +		if (!(tx ? rcsr & FSL_SAI_CSR_FRDE : tcsr & FSL_SAI_CSR_FRDE)) {
> 
> I've applied this since it's a fix but this is *not* a triumph of
> legibility, the ternery operator is often not helpful.

It looks like I've got a bad habit again. I'll be careful next time.

Thank you for reminding me,
Nicolin
