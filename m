From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Codec driver for Texas Instruments
 tlv320dac33 codec
Date: Tue, 13 Oct 2009 10:50:58 +0100
Message-ID: <20091013095058.GA28499@rakim.wolfsonmicro.main>
References: <1255348139-13609-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910131013.00050.peter.ujfalusi@nokia.com>
	<20091013092622.GA1230@sirena.org.uk>
	<200910131246.42861.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A105E1038A4
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Oct 2009 11:51:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200910131246.42861.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2009 at 12:46:42PM +0300, Peter Ujfalusi wrote:
> On Tuesday 13 October 2009 12:26:22 ext Mark Brown wrote:

> > I think so - it'd probably also help if the cache restore were merged
> > into one of the functions too.  I'd be inclined to keep _power too.

> You mean something like this:
> dac33_set_power -> dac33_hard_power
> dac33_soft_power -> dac33_soft_power

Yes but...

> Or keeping the old names, but make the use of these more consequent?

...also the second bit of this :)
