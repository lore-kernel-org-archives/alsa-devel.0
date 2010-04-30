From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320dac33: Support	for?turning
	off the codec in BIAS_STANDBY
Date: Fri, 30 Apr 2010 11:23:10 +0100
Message-ID: <20100430102309.GD21607@sirena.org.uk>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<201004301245.38913.peter.ujfalusi@nokia.com>
	<20100430095636.GC21607@sirena.org.uk>
	<201004301310.14378.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AD9C24431
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 12:23:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201004301310.14378.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 01:10:14PM +0300, Peter Ujfalusi wrote:
> On Friday 30 April 2010 12:56:37 ext Mark Brown wrote:

> > Then just use
> > the hooks in the normal audio stream bringup/teardown surely?  It's
> > possible that I'm missing something as a result of your list of use
> > cases but I'd expect this to flow fairly naturally from the normal call
> > flow.

> The thing is, that I want to handle the chip power in one place, and 
> dac33_set_bias_level is a really good place for that.

Sure, but it shouldn't need to be worrying about playback at all.

> At the time when pcm_prepare is called the codec is still in OFF.
> So I just postponed the dac33_prepare_chip call for later, when the codec 
> switches BIAS level.
> Than I enable the power and if there is a stream, than I do the preparation.
> Note: the BIAS level change is still within the pcm_prepare call chain...

Surely a much more straightforward solution to this is just to add a
post-DAPM prepare() callback to the DAI ops?  It seems like a perfectly
reasonable thing to have that callback and it means you can rely on the
existing mechanisms having taken care of the power for you.

> In this way I don't need to do any additional housekeeping while managing the 
> power of the codec.

My point here is that it seems like you need to do more housekeeping
than you should :)
