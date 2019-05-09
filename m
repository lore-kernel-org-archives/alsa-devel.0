From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the
 current substream
Date: Thu, 09 May 2019 10:11:48 +0200
Message-ID: <5b677f1581565bd8c915a14cd91352ec4bcabdd7.camel@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
         <20190506095815.24578-3-jbrunet@baylibre.com>
         <20190508070058.GQ14916@sirena.org.uk>
         <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
         <20190508085758.GE14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508085758.GE14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-05-08 at 17:57 +0900, Mark Brown wrote:
> > Another solution would be to use the mutex as the 'busy' flag.
> > Get the ownership of the hdmi using try_lock() in startup() and
> > release it in shutdown()
> 
> > Would you have a preference Mark ? 
> 
> Probably using a mutex for the flag is clearer.  I'd rather keep things
> as simple as absolutely possible to avoid people making mistakes in
> future.

Hi Mark,

I received a notification that you applied this patch.
Just to confirm, you expect a follow up patch to re-introduce the mutex, right ?

Thanks
Jerome
