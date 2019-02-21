From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 07/14] ASoC: SOF: Add DSP firmware
 logger support
Date: Thu, 21 Feb 2019 08:57:14 -0600
Message-ID: <d0ab80f4-8e64-5efa-5b50-12ec734216f0@linux.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
 <20190213220734.10471-8-pierre-louis.bossart@linux.intel.com>
 <20190220174403.GF9878@sirena.org.uk>
 <485cf6b0-e685-a376-711c-a3cd5c04833a@linux.intel.com>
 <20190221122957.GF9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190221122957.GF9224@smile.fi.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

>>>> +	/* make sure count is <= avail */
>>>> +	count = avail > count ? count : avail;
>>> count = min(avail, count)?
>> as discussed in the last review, we didn't use min() since it adds a number
>> of obscure warnings with sparse. I haven't found any time to look into this
>> so for now left the code as is. Sparse is a useful tool for the address
>> checks (topology/DMAs with _le32, __iomem, etc), the fewer warnings we get
>> the better.
> Shouldn't be sparse itself get fixed?
Absolutely. I just don't have time to even look into it given all the 
feedback on the kernel patches I have to deal with :-)
