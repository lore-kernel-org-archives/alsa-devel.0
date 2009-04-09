From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: omap-mcbsp: change the DSP_B
 mode to DSP_A mode
Date: Thu, 9 Apr 2009 13:50:40 +0300
Message-ID: <20090409135040.aa09d3e2.jarkko.nikula@nokia.com>
References: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239269682-21309-3-git-send-email-peter.ujfalusi@nokia.com>
	<20090409130014.52b9319d.jarkko.nikula@nokia.com>
	<200904091316.56108.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id F2CD424408
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 12:50:09 +0200 (CEST)
In-Reply-To: <200904091316.56108.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "arunks@mistralsolutions.com" <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Apr 2009 12:16:55 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> > Are you absolutely sure on this? According to WM9713, it's the DSP_A
> > where MSB is valid after 1 bit clock period of the FS.
> 
> I think this is correct. The data is going to be valid exactly the
> same way, as the WM9713 data sheet describes.
> 
I'll try to find working commit where my Beagle is still booting since
it wasn't with the head of linux-omap and then playing a bit with
McBSP3 which is available in pin header of the Beagle so we can measure
this out easily.

> As for the DSP_B mode: I think it can be implemented like this:
> Invert the frame sync polarity, Then:
> 	case SND_SOC_DAIFMT_DSP_B:
> 		regs->srgr2	|= FPER(wlen * channels - 1);
> 		regs->srgr1	|= FWID(0); /* FS pulse width is 1

Looks nice idea. BTW, I had temporary inversion in use in the commit
da6320becf31c40b60d4b1dc6b339c9a766b671c.


Jarkko
