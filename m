From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Handling two audio codec in the same kernel
Date: Wed, 25 Nov 2009 11:21:01 +0000
Message-ID: <20091125112100.GA18883@opensource.wolfsonmicro.com>
References: <1253647760-32558-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090922213604.GB4736@sirena.org.uk>
	<4ABA3C52.6010509@ridgerun.com>
	<20090923154916.GA4257@sirena.org.uk>
	<4ABA4855.9080201@ridgerun.com>
	<20090923163914.GB31134@opensource.wolfsonmicro.com>
	<4B0C0BD5.9050407@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EEF42438E
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 12:21:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B0C0BD5.9050407@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 24, 2009 at 10:37:41AM -0600, Miguel Aguilar wrote:

> * How is the proper way to register both codecs in the same kernel?

At the minute you can't really.  However, if the CODEC for the voice
interface is mostly empty (which I seem to recall was the case?) then
you can skip registering the CODEC and only register the DAI.

> * If I have registered in the same kernel, How I can choose the codec 
> that will be used in the alsamixer menu?

The application layer will do this based on which DAI it chooses to play
audio down - each will appear separately to them, as you're doing below.

> The DMA logic works fine as you see in the examples above. However, only 
> the AIC works recording/playback, the voice codec doesn't work. If I 
> switch the default codec to Voice Codec it works.

Initially I'd suggest testing with hw rather than plughw to make sure
the test is isolated to the drivers.
