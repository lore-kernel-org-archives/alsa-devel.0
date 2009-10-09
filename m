From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2 amplifier driver
Date: Fri, 9 Oct 2009 19:33:46 +0100
Message-ID: <20091009183346.GC20083@sirena.org.uk>
References: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
	<1255093831.30157.207.camel@eenurkka-desktop>
	<200910091636.16126.peter.ujfalusi@nokia.com>
	<20091009171941.GA20083@sirena.org.uk>
	<1FFEF31EBAA4F64B80D33027D42977600E85F0CC9A@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BF56103B4B
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 20:33:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1FFEF31EBAA4F64B80D33027D42977600E85F0CC9A@NOK-EUMSG-02.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-Eero.Nurkkala@nokia.com
Cc: eduardo.valentin@nokia.com, alsa-devel@alsa-project.org, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 09, 2009 at 08:24:49PM +0200, ext-Eero.Nurkkala@nokia.com wrote:

> I guess there's (or may be) an exception though. I think I've seen some
> strangeness with the close_delayed_work() -> and simultaneous mixer tweaking:

As I said when you posted previously that's a problem anyway and
close_delayed_work() needs to be fixed.  You had a half-posted patch,
did you manage to test it properly (even in normal operation)?  I'd been
expecting a proper posting of it to appear at some point.

> So there can and does run two dapm_power_widgets() when stars
> point to the right direction. That's when delayed work is at
> damp_power_widgets, and then preempted to
> the userspace thread.  May that isn't related to this TPA though, but
> I think I'll silently review the code so that the "stars are forced to
> point to the right direction".

This is completely unrelated to driver code, the core's data is much
more of a problem than the register cache which will generally fix
itself the next time DAPM does anything.
