From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: DaVinci: i2s,
	reduce underruns	by combining into 1 element
Date: Tue, 1 Sep 2009 20:03:28 +0100
Message-ID: <20090901190327.GA25706@opensource.wolfsonmicro.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090901105302.GD18651@sirena.org.uk>
	<4A9D669F.6090906@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ECD0A103858
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 21:03:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A9D669F.6090906@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: avm@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 01, 2009 at 11:23:27AM -0700, Troy Kisky wrote:
> Mark Brown wrote:

> > Last time you submitted this I suggested changing this to make the
> > default the other way round so that there's no breakage on existing
> > boards which aren't designed for this channel swap behaviour.  Is there
> > some reason not to do that?

> I think that it is better to make sure that they know the possible problems
> disabling this may cause. Channels always swapped seems a lot better than
> channels randomly swapped.

Of course, the other way of looking at it is that with the channel
swapping you've got guaranteed breakage - it sounds less good if you say
it that way :) How common are the channel swaps?
