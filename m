From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 07/14] ASoC: SOF: Add DSP firmware
 logger support
Date: Tue, 22 Jan 2019 14:33:55 -0600
Message-ID: <17fc8892-90aa-a7b3-d9aa-23825b83fca0@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
 <20190109204427.GR10405@sirena.org.uk>
 <85d2a9dc-4800-9db7-3e6a-3671f8eef226@linux.intel.com>
 <20190122185711.GI7579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190122185711.GI7579@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>>> +	/* make sure count is <= avail */
>>>> +	count = avail > count ? count : avail;
>>> min()?
>> I tried to use min() but then Sparse started complaining so went back to an
>> explicit test+assign.
>> I don't have a strong opinion on this, but we've found so many improvements
>> with the tools that I tend to favor warning-free code.
> Why was sparse complaining - was it spotting something that is an actual
> issue here and you've just masked the warning?

It was about the use of typeof/sizeof() in min(), not an actual issue in 
the code

sound/soc/sof/trace.c:90:17: warning: expression using sizeof(void)
sound/soc/sof/trace.c:90:17: warning: expression using sizeof(void)
