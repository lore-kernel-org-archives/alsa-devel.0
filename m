From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: omap-mcbsp: change the DSP_B
 mode to DSP_A mode
Date: Thu, 9 Apr 2009 15:30:42 +0300
Message-ID: <20090409153042.9f6e3ab8.jarkko.nikula@nokia.com>
References: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239269682-21309-3-git-send-email-peter.ujfalusi@nokia.com>
	<20090409130014.52b9319d.jarkko.nikula@nokia.com>
	<200904091316.56108.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E0F9D103864
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 14:30:02 +0200 (CEST)
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
> As for the DSP_B mode: I think it can be implemented like this:
> Invert the frame sync polarity, Then:
> 	case SND_SOC_DAIFMT_DSP_B:
> 		regs->srgr2	|= FPER(wlen * channels - 1);
> 		regs->srgr1	|= FWID(0); /* FS pulse width is 1
> */ break;
> 
> So the MSB will be in the correct place.
> 
Peter is right. There is a bug in omap-mcbsp.c. If I play maximum
negative samples "aplay -f U8 /dev/zero", the MSB bit is then
just after the falling edge of FS like in DSP_A format... (hmm, what I
was doing in the commit bd25867a6cbe7a00ef7dbe8d9ddebc91b00b9b3f).

Is it ok to leave this over the easter to make sure next week that we'll
get this finally right? I have had already few DSP format fixes there
and still this is not correct... :-)

-- 
Jarkko
