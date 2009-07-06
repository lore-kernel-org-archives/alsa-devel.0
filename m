From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 08/11] ASoc: DaVinci: i2s,
	Improve underrun, support	mono
Date: Mon, 6 Jul 2009 12:54:42 +0100
Message-ID: <20090706115442.GA8925@sirena.org.uk>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246878557.3192.25.camel@linux-1lbu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A7D0C2458F
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 13:54:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246878557.3192.25.camel@linux-1lbu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Chen <schen@mvista.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 06, 2009 at 06:09:16AM -0500, Steve Chen wrote:
> On Sat, 2009-07-04 at 19:29 -0700, Troy Kisky wrote:

> > This patch will reduce the number of underruns by
> > shifting out 32 bit values instead of 16 bit. It also
> > adds mono support.

> Doesn't ALSA already automatically handle mono-stero conversions?  I
> don't think we need to provide the same functionality in the driver.

If the hardware can natively play mono then that's less work for the CPU
to do which will improve efficiency.
