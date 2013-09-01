From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/5] Remove ASoC-level I/O functions from cq93vc
Date: Sun, 1 Sep 2013 16:48:47 +0200
Message-ID: <20130901144847.GM20329@zurbaran>
References: <20130831130741.GG18608@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130831130741.GG18608@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sat, Aug 31, 2013 at 02:07:41PM +0100, Mark Brown wrote:
> This patch series removes the use of the ASoC-level read and write
> functions from the cq93vc driver as part of a wider push to remove them
> completely and just use regmap for all register I/O.  Since the driver
> is essentially doing what regmap-mmio is doing this is done by adding a
> MMIO regmap to the core device and using that.  This is compile tested
> only, I don't have any hardware to run on.
> 
> Since I anticipate doing more cleanups over the CODEC drivers during the
> next release cycle it'd be good to merge via ASoC, though there
> shouldn't be any overlap with the first patch.
As I'd prefer to carry the MFD ones (Including the twl6040 one) through
mfd-next, I can build a branch for you to pull from. Would that be fine
with you ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
