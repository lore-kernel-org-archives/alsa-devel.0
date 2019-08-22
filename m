From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire stream
 config/free callbacks
Date: Thu, 22 Aug 2019 17:11:18 +0200
Message-ID: <20190822151117.GA1200@ubuntu>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
 <20190822071835.GA30262@ubuntu>
 <f73796d6-fcfa-97c8-69ae-0a183edbbd97@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f73796d6-fcfa-97c8-69ae-0a183edbbd97@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, YueHaibing <yuehaibing@huawei.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 22, 2019 at 08:53:06AM -0500, Pierre-Louis Bossart wrote:
> Thanks for the review Guennadi
> 
> > > +static int sdw_config_stream(void *arg, void *s, void *dai,
> > > +			     void *params, int link_id, int alh_stream_id)
> > 
> > I realise, that these function prototypes aren't being introduced by these
> > patches, but just wondering whether such overly generic prototype is really
> > a good idea here, whether some of those "void *" pointers could be given
> > real types. The first one could be "struct device *" etc.
> 
> In this case the 'arg' parameter is actually a private 'struct snd_sof_dev',
> as shown below [1]. We probably want to keep this relatively opaque, this is
> a context that doesn't need to be exposed to the SoundWire code.

Right, that's why I proposed struct device and not struct snd_sof_dev, to not 
make it SOF-specific, then sdev could be obtained from dev_get_drvdata(). But 
yes, that's unrelated to this series.

Thanks
Guennadi
