From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Thu, 23 Jun 2011 11:47:11 +0100
Message-ID: <20110623104711.GF21932@opensource.wolfsonmicro.com>
References: <20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
	<20110622114826.GD18726@opensource.wolfsonmicro.com>
	<BANLkTikGd+3_=JA5rEkpH0iNGkashgT7DQ@mail.gmail.com>
	<20110622132518.GB21802@opensource.wolfsonmicro.com>
	<BANLkTi=YE0hijDwc_7AUXd7Q0xKuAXWxig@mail.gmail.com>
	<20110622151130.GB3019@opensource.wolfsonmicro.com>
	<20110622214153.GA978@core.coreip.homeip.net>
	<20110623001501.GA20949@opensource.wolfsonmicro.com>
	<20110623084234.GB2493@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D75E2414F
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 12:47:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110623084234.GB2493@core.coreip.homeip.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 23, 2011 at 01:42:36AM -0700, Dmitry Torokhov wrote:
> On Thu, Jun 23, 2011 at 01:15:01AM +0100, Mark Brown wrote:

> > a case of reporting if things are connected, we need to group these
> > things together into bundles and link them to multiple other devices in
> > the system.

> Hmm, I am not sure I follow. We usually need to calssify and group
> devices; there is nothing new here...

Usually we do this per device type and by control path but what we need
to do here is say that a given jack has audio, video and input
functionality - it's a different grouping to our normal ones.

> > uevents are what the Android switch API uses.  I think that would have
> > some of the daemon issues that David raised, though?

> I'll have to locate original email; I am not subscribed to alsa list.

The issue was that he would really prefer PulseAudio (which runs as a
regular user) to be able to read the events directly.
