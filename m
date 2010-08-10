From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: amp power down event (resend with the	correct
 email)
Date: Tue, 10 Aug 2010 13:20:10 +0100
Message-ID: <20100810122010.GA6416@rakim.wolfsonmicro.main>
References: <4C604381.2080000@gandalf.sssup.it>
	<20100810103120.GA4020@sirena.org.uk>
	<4C613073.80508@gandalf.sssup.it>
	<20100810115306.GB4020@sirena.org.uk>
	<4C614177.9090708@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91569245F4
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 14:20:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C614177.9090708@gandalf.sssup.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 10, 2010 at 02:09:27PM +0200, Michael Trimarchi wrote:

> When the amp_event is supposed to be called in the speaker widget? After the
> stream is closed?

It will be called when the speaker is powered down.  For DAC to speaker
paths this will be five seconds after playback stops in the default
configuration.
