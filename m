From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 1/4] ASoC: hdmi-codec: remove function name debug
 traces
Date: Wed, 08 May 2019 10:08:58 +0200
Message-ID: <08ee1bbfb5ae15b5cb2bd421abe6979b83097553.camel@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
         <20190506095815.24578-2-jbrunet@baylibre.com>
         <20190508065016.GP14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508065016.GP14916@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-05-08 at 15:50 +0900, Mark Brown wrote:
> On Mon, May 06, 2019 at 11:58:12AM +0200, Jerome Brunet wrote:
> > Remove the debug traces only showing the function name on entry.
> > The same can be obtained using ftrace.
> 
> This is not a bug fix and so shouldn't be the first patch in the series
> in order to avoid dependencies from it on anything later in the series
> that is actually a fix.

Sure, I'll re-order
