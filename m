From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
	for ML7213
Date: Mon, 26 Mar 2012 16:40:09 +0100
Message-ID: <20120326154009.GA17506@sirena.org.uk>
References: <1331275160-31757-1-git-send-email-tomoya.rohm@gmail.com>
	<1332158459-14880-1-git-send-email-tomoya.rohm@gmail.com>
	<20120321160913.GF3226@opensource.wolfsonmicro.com>
	<CANKRQnjoGN=uvej8B1BxPHAx7NQtOORD9yJRPUc134DrVmPzNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DA7D10408A
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 17:38:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CANKRQnjoGN=uvej8B1BxPHAx7NQtOORD9yJRPUc134DrVmPzNg@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 22, 2012 at 09:12:39AM +0900, Tomoya MORINAGA wrote:
> On Thu, Mar 22, 2012 at 1:09 AM, Mark Brown

> > So, I just said to the SPEAr guys that I really want to see support for
> > non-cyclic dmaengine added to the helper library rather than open
> > coding. ?We're seeing lots of platforms moving to dmaengine (as well as

> Do you mean you don't accept our platform/machine driver's patches
> unless your DMA library will have supported non-cyclic dmaengine ?
> Or if I'll modify your minor comments, can you accept our patches ?

I really want to see the dmaengine interaction factored out into a
library.  Like I say we've got lots of platforms doing this all being
submitted at the same time, plus most of the work already there in the
form of the base library.  It shouldn't be too much work for the various
platforms to collaborate on factoring this code out.
