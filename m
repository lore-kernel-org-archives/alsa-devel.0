From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v6 03/14] ASoC: SOF: Add driver debug
 support.
Date: Fri, 19 Apr 2019 11:09:51 -0500
Message-ID: <9a5609c3-df05-2dcc-69b7-b10fe2dc221d@linux.intel.com>
References: <20190412160519.30207-1-pierre-louis.bossart@linux.intel.com>
 <20190412160519.30207-4-pierre-louis.bossart@linux.intel.com>
 <20190419155458.GV2803@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190419155458.GV2803@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the review Mark

On 4/19/19 10:54 AM, Mark Brown wrote:
> On Fri, Apr 12, 2019 at 11:05:08AM -0500, Pierre-Louis Bossart wrote:
> 
>> +		if (pm_runtime_active(sdev->dev) ||
>> +		    dfse->access_type == SOF_DEBUGFS_ACCESS_ALWAYS) {
>> +			memcpy_fromio(buf, dfse->io_mem + pos, size);
>> +		} else {
>> +			dev_info(sdev->dev,
>> +				 "Copying cached debugfs data\n");
>> +			memcpy(buf, dfse->cache_buf + pos, size);
>> +		}
> 
> Might this get a bit noisy if we start hitting the info case?

Indeed, I recall we discussed removing this log but it's still there. We 
can fix this with a follow-up patch or in a v7 depending if there are 
other comments.
