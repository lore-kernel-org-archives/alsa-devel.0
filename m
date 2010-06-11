From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/4] ALSA: usb-audio: parse UAC2 sample
 rate ranges correctly
Date: Fri, 11 Jun 2010 17:18:29 +0200
Message-ID: <20100611151829.GE17833@buzzloop.caiaq.de>
References: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
	<1276263191-8652-4-git-send-email-daniel@caiaq.de>
	<AANLkTin3LMCu_f2emsh6kAT8H6G3zKF8Ud-ZUMpZjbmg@mail.gmail.com>
	<20100611150435.GS2698@buzzloop.caiaq.de>
	<4C1252F1.20809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 71B4C244F0
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 17:18:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C1252F1.20809@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alex Lee <alexlee188@gmail.com>, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 05:14:57PM +0200, Clemens Ladisch wrote:
> Daniel Mack wrote:
> > On Fri, Jun 11, 2010 at 10:59:44PM +0800, Alex Lee wrote:
> > > If the device has a variable clock, it may report a RES of only 1.  So you
> > > may end up with thousands (and even millions) of sample rates.  It might be
> > > better to have separate code to cater to discrete clocks vs variable clocks.
> > 
> > AFAIK, ALSA can[...] cope with that [...]. Am I right?
> 
> Yes; set fp->rates to SNDRV_PCM_RATE_CONTINUOUS to allow all rates between
> fp->rate_min and fp->rate_max.  See, for example, parse_audio_format_rates_v1.

Ah, ok. So we should we do this for all USB devices that report a RES
value of 1. I'll respin this series then. Thanks!

Daniel
