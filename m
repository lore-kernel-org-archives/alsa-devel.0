From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3 v2] sound/soc/lapis: add platform
 driver for ML7213 IOH I2S
Date: Mon, 26 Dec 2011 12:12:08 +0000
Message-ID: <20111226121207.GF8722@opensource.wolfsonmicro.com>
References: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
	<1324349144-12784-3-git-send-email-tomoya.rohm@gmail.com>
	<20111220132314.GQ2866@opensource.wolfsonmicro.com>
	<CANKRQng8N3oS2o17HPUZeonXB3KLBK9oNQj-zd9+aUUvWcTo0A@mail.gmail.com>
	<20111222005816.GB27144@opensource.wolfsonmicro.com>
	<CANKRQnjCTAX02wJt7StjB0rXkg3Q6bPBRYCbkgq6vS5NFd97Fg@mail.gmail.com>
	<20111222103946.GA4546@opensource.wolfsonmicro.com>
	<CANKRQng+H4NxaSLpZpYOCT-CdovxbToT-waz0JNMFT2AcD_gvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2337D245B1
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:12:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQng+H4NxaSLpZpYOCT-CdovxbToT-waz0JNMFT2AcD_gvA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 26, 2011 at 03:33:29PM +0900, Tomoya MORINAGA wrote:
> 2011/12/22 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> >> Not sorted but queuing only.
> >> In sound/voice control system, queuing is not rare, I think.
> >> If necessary, though this method is very common, I can send the method
> >> of the queue.

> > No, please describe the problem you're trying to fix.

> When CPU is heavy load, this buffer is useful.
> The heavy load causes delaying receiving processing.
> If there is no buffer, stream sound/voice can be broken.
> If there is the buffer, it can prevent the broken sound.

So you're just talking about standard underflows if the application
can't keep up?  There's *no* reason for your driver to do anything about
this, it's a really basic thing that affects all audio hardware.  Just
write a driver for the hardware.
