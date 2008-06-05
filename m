From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Add WM8510 driver
Date: Thu, 5 Jun 2008 15:46:55 +0100
Message-ID: <20080605144655.GA24582@rakim.wolfsonmicro.main>
References: <1212670174-19810-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200806050917.23252.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2194324638
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 16:46:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806050917.23252.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Brett Saunders <breton.saunders@ntlworld.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 05, 2008 at 09:17:23AM -0500, Geoffrey Wossum wrote:
> On Thursday 05 June 2008 07:49:32 am Mark Brown wrote:

> > +	case SNDRV_PCM_FORMAT_S32_LE:
> > +		iface |= 0x0060;
> > +		break;
> > +	}

> This should either be changed to use SNDRV_PCM_FORMAT_S16 and friends, which I 
> think will automagically use the correct endian for the selected 
> architecture, or explicitly list both _LE and _BE formats.  Not an issue, 

It should list both.  The codec really doesn't care how the data is laid
out in memory, it's up to the other end of the link to format it into
the appropriate format for the bus and there's no reason why controllers
wouldn't be able to offer byteswapping.

> unless you're using a correct endian, I mean big endian, processor like I 
> am :)  I would think this would need to be propagated to other CODEC drivers.

Yes - I've got a change queued up to do this which applies it uniformly
over all codec drivers (as part of some other cross-driver cleanup
work I'm still working on).  For clarity it's a change which should be
applied uniformly to all codec drivers rather than over some of them
(creating confusion) so for the minute this driver does the same as all
the rest.

> Mark, were able to verify that the default value SPKMIX differs from the 
> datasheet?  Is this a datasheet mistake, or an issue in the WM8510 part I 
> have?  The full markings on the part are "WM8510G / 63AETV9", and the 
> datasheet is "February 2008, Rev 4.4".

It's most likely a typo in the datasheet; I should have confirmed this
by tomorrow.
