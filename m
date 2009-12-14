From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Two codecs using the same I2S bus
Date: Mon, 14 Dec 2009 10:33:03 +0000
Message-ID: <20091214103303.GA1250@sirena.org.uk>
References: <4B223B13.8050502@langendorff.nl>
	<20091212180521.GA3092@sirena.org.uk>
	<1D0FFCE9-386C-49A4-87DF-5FDBF98B6118@langendorff.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CCAD1038E6
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 11:33:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1D0FFCE9-386C-49A4-87DF-5FDBF98B6118@langendorff.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Langendorff <linux@langendorff.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 12, 2009 at 08:54:04PM +0100, Niels Langendorff wrote:
> Op 12 dec 2009, om 19:05 heeft Mark Brown het volgende geschreven:
> > On Fri, Dec 11, 2009 at 01:29:07PM +0100, Niels Langendorff wrote:

> > This should work with the kernel as-is providing the two CODECs don't
> > both need register control, just declare DAI links for each of the links
> > you need from your machine driver.  

> Both the codecs needs to be reconfigured by writing the registers for
> every playback/recording, so that is the difficulty.

I see.  The difficulty with more than one register based device is
somewhat orthogonal to the DAIs.  The current approach to such systems
is to have a driver for one of the devices which provides functions
which can be called from the machine drivers - the MAX9877 and TPA6130A2
in mainline are examples.  This doesn't scale so well, though it is
workable for the time being if the devices aren't too complex.
