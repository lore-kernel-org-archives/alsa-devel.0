From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [alsa-devel] [patch] ASoC: Baytrail: fix error handling in
 sst_byt_dsp_init()
Date: Wed, 05 Mar 2014 19:18:29 +0000
Message-ID: <1394047109.2314.29.camel@loki>
References: <20140305111157.GD16926@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20140305111157.GD16926@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-03-05 at 14:11 +0300, Dan Carpenter wrote:
> Calling "kfree(byt)" is a double free because that was allocated with
> devm_kzalloc().  There were a couple places which leak "byt->msg".  That
> memory is allocated in msg_empty_list_init().
> 

Thanks, we've just fixed this too but were not quicker than you for
upstreaming ;)

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>


