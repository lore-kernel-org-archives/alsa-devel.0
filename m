From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320dac33: Support for	turning
	off the codec in BIAS_STANDBY
Date: Fri, 30 Apr 2010 10:56:37 +0100
Message-ID: <20100430095636.GC21607@sirena.org.uk>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<1272612715-13387-5-git-send-email-peter.ujfalusi@nokia.com>
	<20100430084100.GB28241@rakim.wolfsonmicro.main>
	<201004301245.38913.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A2787243FB
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 11:56:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201004301245.38913.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 12:45:38PM +0300, Peter Ujfalusi wrote:
> On Friday 30 April 2010 11:41:00 ext Mark Brown wrote:

> > Moving the playback related configuration into events on the DAC widgets
> > (or probably a supply connected to the DAC widgets) seems like a good
> > move for a lot of these scenarios?  The core will then take care of
> > ensuring that the startup sequence for the playback is called for you
> > and the states can do what they're supposed to more directly.

> This is not working.
> Actually it works, if we come from BIAS_OFF, but...
> If I restart the playback fast (within asoc timeout for BIAS change), than the 
> widget will not get event (since it is still powered). This means that I can not 
> do the needed reconfiguration for the tlv320dac33 -> audio breaks.

> I will keep the current logic, but move it a bit with the idle_bias_off change.

Hrm, you need to do this any time playback is started?  Then just use
the hooks in the normal audio stream bringup/teardown surely?  It's
possible that I'm missing something as a result of your list of use
cases but I'd expect this to flow fairly naturally from the normal call
flow.
