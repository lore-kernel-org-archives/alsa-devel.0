From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 07/14] ASoC: SOF: Add DSP firmware
	logger support
Date: Thu, 21 Feb 2019 14:29:57 +0200
Message-ID: <20190221122957.GF9224@smile.fi.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-8-pierre-louis.bossart@linux.intel.com>
 <20190220174403.GF9878@sirena.org.uk>
 <485cf6b0-e685-a376-711c-a3cd5c04833a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <485cf6b0-e685-a376-711c-a3cd5c04833a@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 20, 2019 at 02:18:01PM -0600, Pierre-Louis Bossart wrote:
> On 2/20/19 11:44 AM, Mark Brown wrote:
> > On Wed, Feb 13, 2019 at 04:07:27PM -0600, Pierre-Louis Bossart wrote:

> > > +	/* make sure count is <= avail */
> > > +	count = avail > count ? count : avail;
> > count = min(avail, count)?
> as discussed in the last review, we didn't use min() since it adds a number
> of obscure warnings with sparse. I haven't found any time to look into this
> so for now left the code as is. Sparse is a useful tool for the address
> checks (topology/DMAs with _le32, __iomem, etc), the fewer warnings we get
> the better.

Shouldn't be sparse itself get fixed?


-- 
With Best Regards,
Andy Shevchenko
