From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 2/4] ASoC: hdmi-codec: remove reference to the
 current substream
Date: Wed, 08 May 2019 10:08:44 +0200
Message-ID: <fd633a5597703f557d75e43c14213699efe295f0.camel@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
         <20190506095815.24578-3-jbrunet@baylibre.com>
         <20190508070058.GQ14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508070058.GQ14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-05-08 at 16:00 +0900, Mark Brown wrote:
> On Mon, May 06, 2019 at 11:58:13AM +0200, Jerome Brunet wrote:
> 
> > Remove current_substream pointer and replace the exclusive locking
> > mechanism with a simple variable and some atomic operations.
> 
> The advantage of mutexes is that they are very simple and clear to
> reason about.  It is therefore unclear that this conversion to use
> atomic variables is an improvement, they're generally more complex 
> to reason about and fragile.

The point of this patch is not to remove the mutex in favor of atomic
operations

The point was to remove the current_substream pointer in favor of a
simple 'busy' flag. After that, I ended up with a mutex protecting
a flag and it seemed a bit overkill to me. Atomic op seemed like a
good fit for this but I don't really care about that particular
point.

I can put back mutex to protect the flag if you prefer.

Another solution would be to use the mutex as the 'busy' flag.
Get the ownership of the hdmi using try_lock() in startup() and
release it in shutdown()

Would you have a preference Mark ? 
