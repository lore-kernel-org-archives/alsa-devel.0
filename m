From: Jie Jiang <jjinfo@nudt.edu.cn>
Subject: Re: Questions about alsa driver for i.Mx27 + wm8974:
 playback time shorter than the original record time
Date: Wed, 01 Sep 2010 00:21:40 +0800
Message-ID: <1283271700.10728.8.camel@UT43>
References: <1282824338.1106.44.camel@UT43>
	<20100826124137.GA3509@opensource.wolfsonmicro.com>
Reply-To: jjinfo@nudt.edu.cn
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nudt.edu.cn (unknown [61.187.54.11])
	by alsa0.perex.cz (Postfix) with SMTP id C3D3D1037F5
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 18:16:37 +0200 (CEST)
In-Reply-To: <20100826124137.GA3509@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Thanks for your advice!

On Thu, 2010-08-26 at 13:41 +0100, Mark Brown wrote:
> On Thu, Aug 26, 2010 at 08:05:38PM +0800, Jie Jiang wrote:
> 
> > The configuration of mx27 ssi1 transmission channel is as follows(using
> > ssi api from kernel 2.6.19.2):
> 
> This is an extremely old kernel version, the current kernel version is
> 2.6.35 with 2.6.36 in development.  Current mainline kernels have a
> different API for configuring the IOMUX.  I'd strongly recommend working
> with a more current kernel if you're looking for community support.
> 
> > Here I'm not very sure about the setting of frame rate and frame sync
> > length.  Is the above setting right?  But even I set frame rate to 1, it
> > does not make any difference. 
> 
> > What's the possible reason causing the incorrect faster playback speed?
> > Any suggestion is appreciated.
> 
> Normally this will be the result of either an incorrect frame rate or
> the hardware trying to play back mono data as stereo (which will cause
> data to be consumed as twice the expected rate).

Yes, it seems to be this reason that causes problem.
When I playback a stereo wav file(8kHz,16bit, stereo), everything goes
well.But when trying to playback a mono wav (8kHz,16bit, mono)file,
problem stills exist.

What's the possible reason for incorrect handling of mono file?
How to solve it so I can playback mono file correctly?

Regards,
Jie
