From: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V1 08/11] ASoc: DaVinci: i2s, Improve underrun, support
	mono
Date: Mon, 06 Jul 2009 07:45:52 -0500
Message-ID: <1246884352.3192.29.camel@linux-1lbu>
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
	<20090706115442.GA8925@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090706115442.GA8925-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-07-06 at 12:54 +0100, Mark Brown wrote:
> On Mon, Jul 06, 2009 at 06:09:16AM -0500, Steve Chen wrote:
> > On Sat, 2009-07-04 at 19:29 -0700, Troy Kisky wrote:
> 
> > > This patch will reduce the number of underruns by
> > > shifting out 32 bit values instead of 16 bit. It also
> > > adds mono support.
> 
> > Doesn't ALSA already automatically handle mono-stero conversions?  I
> > don't think we need to provide the same functionality in the driver.
> 
> If the hardware can natively play mono then that's less work for the CPU
> to do which will improve efficiency.

I see.  In this case, DaVinci hardware does not support mono, but the
patch does some DMA index magic to convert between mono and stereo.  It
works just as well then...
