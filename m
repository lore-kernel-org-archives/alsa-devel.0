From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix DSP_B
 format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 13:31:43 +0300
Message-ID: <20090416133143.10cbd1bf.jarkko.nikula@nokia.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<1239792497-31761-2-git-send-email-jarkko.nikula@nokia.com>
	<200904151404.37003.peter.ujfalusi@nokia.com>
	<20090415115606.GB9311@sirena.org.uk>
	<dfeb90390904160308t626cfe7axc78dedca915076@mail.gmail.com>
	<20090416101216.GI16318@sirena.org.uk>
	<dfeb90390904160317r1c1bfad0ndf2370120b18c8e1@mail.gmail.com>
	<20090416101945.GJ16318@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 127B61038A9
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 12:31:07 +0200 (CEST)
In-Reply-To: <20090416101945.GJ16318@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: Arun KS <getarunks@gmail.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 16 Apr 2009 12:19:45 +0200
ext Mark Brown <broonie@sirena.org.uk> wrote:

> > > What sort of noise are you getting - is it just noise or is there
> > > some signal underneath the noise? ?Can you try playing a signal
> > > with no data on the left channel and see what effect that has?
> 
> > Its not just noise, signal is there underneath.
> 
> Could you try the test with no data on the left channel?  I suspect
> that the LSB of the left channel may be being processed as the MSB of
> the right channel.
>
I'm wondering why the left channel is still playing fine?


Jarkko
