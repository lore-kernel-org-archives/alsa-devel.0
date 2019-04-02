From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 03/14] ASoC: SOF: Add driver debug
 support.
Date: Tue, 2 Apr 2019 08:47:52 -0500
Message-ID: <9da94302-b630-a4f9-f155-426f63a3091e@linux.intel.com>
References: <20190321161016.26515-1-pierre-louis.bossart@linux.intel.com>
 <20190321161016.26515-4-pierre-louis.bossart@linux.intel.com>
 <s5hsgv5k6ox.wl-tiwai@suse.de>
 <631c6cba-2f81-6f5f-3d5f-f9f5bbb171c7@linux.intel.com>
 <20190402054413.GA2059@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190402054413.GA2059@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>>> Doesn't pos need to be aligned to 32bit as well (at least at actually
>>> reading from iomem)?
>> Good point,  we can either return an error if the count in both a multiple
>> of 32 bits, or do some caching to allow for arbitrary size access. The
>> former is very simple but not sure if this is accepted behavior for debugfs.
> You really want something that will work with arbatrary userspace tools
> if you can rather than requiring special magic read sizes - things like
> cat and cp should probably work.  A common thing is to do reads/writes
> of the correct sizes into a buffer and then pick the relevant bits out
> of the buffer to satisfy what userspace actually asked for.

Thanks for the advice. The data is already in a buffer so it's not 
difficult to implement support for sizes that aren't multiple of 4 bytes.
