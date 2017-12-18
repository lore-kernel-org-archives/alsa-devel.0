From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: Re: [alsa-devel][PATCH v6] ASoC: TSCS42xx: Support Tempo
 Semiconductor's TSCS42xx audio CODECs
Date: Mon, 18 Dec 2017 14:08:32 -0600
Message-ID: <20171218195843.c4pp6ntsup2o4l5y@localhost.localdomain>
References: <20171217035439.5merfdxrjz6amscd@localhost.localdomain>
 <20171218095048.e5zwla65f2qqmroj@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171218095048.e5zwla65f2qqmroj@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 18, 2017 at 09:50:48AM +0000, Charles Keepax wrote:

> Is this unused?

I apologize I missed this. These were going to be mux controls for two
differential inputs. There are two inputs, but only one can be used at
a time. We have never seen anybody use the second input, so I will
remove the mux controls since it is likely just going to be noise to
anybody configuring the chip through these controls.

> Given all users of this macro use coeff_ram_get and coeff_ram_put
> might it just be worth sticking them in here?

Good point. In the next version the callbacks will be implied through
the use of the macro.

> Other than those two very minor comments, looks ok to me so I
> think you can add:
> 
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> Thanks,
> Charles

Thank you so much for your time on this review. It has really helped
improve the driver.
