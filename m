From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 07/14] ASoC: SOF: Add DSP firmware
	logger support
Date: Wed, 20 Feb 2019 14:18:01 -0600
Message-ID: <485cf6b0-e685-a376-711c-a3cd5c04833a@linux.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-8-pierre-louis.bossart@linux.intel.com>
 <20190220174403.GF9878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190220174403.GF9878@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 2/20/19 11:44 AM, Mark Brown wrote:
> On Wed, Feb 13, 2019 at 04:07:27PM -0600, Pierre-Louis Bossart wrote:
>
>> +	/* make sure count is <= avail */
>> +	count = avail > count ? count : avail;
> count = min(avail, count)?
as discussed in the last review, we didn't use min() since it adds a 
number of obscure warnings with sparse. I haven't found any time to look 
into this so for now left the code as is. Sparse is a useful tool for 
the address checks (topology/DMAs with _le32, __iomem, etc), the fewer 
warnings we get the better.
