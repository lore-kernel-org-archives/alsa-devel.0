From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: : Question ASoC driver without Codec driver?
Date: Thu, 24 Feb 2011 12:46:34 +0200
Message-ID: <1298544394.29371.107.camel@masi.mnp.nokia.com>
References: <2A84145621092446B6659B8A0F28E26F4703F09682@irsmsx501.ger.corp.intel.com>
	<4D660B4A.80905@nokia.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A04E324609
	for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2011 11:47:09 +0100 (CET)
In-Reply-To: <4D660B4A.80905@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Bensaid, Selma" <selma.bensaid@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Benavoli,
	PatrickX" <patrickx.benavoli@intel.com>
List-Id: alsa-devel@alsa-project.org

Hello Selma,

On Thu, 2011-02-24 at 09:39 +0200, Peter Ujfalusi wrote:
> Hi,
> 
> On 02/23/11 11:29, ext Bensaid, Selma wrote:
> > Hi,
> > 
> > I'm trying to find out if it's possible to implement an ASoC driver 
> > without a codec driver.
> > 
> > I'm implementing a ASoC driver for BT/FM WL1273,
> 
> Well, probably you did noticed, that we already have driver for the
> WL1273 in upstream... As I recall you have sent several mails regarding
> to writing a new codec driver for the same chip.
> 
> > where the FM WL1273 control 
> > interface is based on V4L2 since since we use the Combined Interface 
> > Mode (The host controls both the BT and the FM Radio through the BT HCI host interface).
> 
> It is true, that the current implementation relies on i2c interface, but..
> AFAIK TI has the combined interface mode for this chip in the staging area.
> Recently there were a thread about the possibility of using that work,
> and offer the two interface for the wl1273 BT/FM control, so one can
> choose which to use.
> I'm not sure, of the BT driver for the wl1273 is in upstream.
> 
> What I propose is to:
> - Help TI to get the combined interface mode out from the staging
> - Work with TI, Matti, and BT guys to implement line discipline driver
> to be used by the BT, and the codec/BT/FM part of wl1273
> - Work with TI, Matti, and BT guys, and convert/add support for the
> combined interface mode in the existing MFD/codec/V4L/BT driver.

Have you taken a look at the existing wl1273 codec? Now the whole FM
radio driver should be going into the 2.6.38 version of the kernel (rc6
still contains the old stuff). It should be fairly easy to add support
for the UART control to the MFD driver (see the links below). And TI's
dual transport might be used for the audio routing also in the case
where the actual control is through I2C (but I'm not sure about the
details).

The latest patch for the wl1273 codec:
http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/29165/match=
The wl1273 MFD driver that contains the IO functions:
http://article.gmane.org/gmane.linux.alsa.devel/82235/match=

Cheers, 
Matti
