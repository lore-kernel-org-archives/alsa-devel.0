From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA DMIX support without MMAP ?
Date: Fri, 15 Jan 2010 13:37:19 +0000
Message-ID: <20100115133718.GA21188@rakim.wolfsonmicro.main>
References: <17791994.52581263557220723.JavaMail.weblogic@epml09>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BAB5524471
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 14:37:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <17791994.52581263557220723.JavaMail.weblogic@epml09>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: maniyar@samsung.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2010 at 12:07:00PM +0000, ANISH KUMAR wrote:

> >The default linear resampler is not very good quality. You may use some 
> >sox resamplers from the alsa-plugins package, but they&#39;re more CPU 
> >intensive. Check google.
> 
> Actually i am working on soc platform(android-S3C6410) and wanted to
> use DMIX and some good resampler for my software mixing instead of
> current software mixing and resampling in upper layer(Above
> alsa-lib).DMIX is working fine but this resampling is causing some
> jitter.During rate conversion it looks for
> libasound_module_rate_speexrate.so which i don't have so its using
> default one causing the jitter.

Have you considered using PulseAudio for this?
