From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 01/10] ASoC: fsl_ssi: Remove unused struct device
Date: Tue, 5 Dec 2017 11:39:13 -0800
Message-ID: <20171205193912.GB11039@Asurada-Nvidia>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
 <1512420403-10164-2-git-send-email-nicoleotsuka@gmail.com>
 <20171205130446.GI11658@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171205130446.GI11658@finisterre>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org, mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 05, 2017 at 01:04:46PM +0000, Mark Brown wrote:
> On Mon, Dec 04, 2017 at 12:46:34PM -0800, Nicolin Chen wrote:
> > struct device is defined in system level header files any way.
> > As long as fsl_ssi.h is included after those header files, it
> > should be safe to remove this line.
> 
> It's better practice to either directly include those headers or have a
> forward declaration like this, it means there's no way things can go
> wrong.

I see. I will drop this patch then.
