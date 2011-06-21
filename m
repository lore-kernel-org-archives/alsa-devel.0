From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 21 Jun 2011 01:29:17 +0100
Message-ID: <20110621002917.GF1905@opensource.wolfsonmicro.com>
References: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>
	<BANLkTin7K_qO3ejJhOswjSjrLVh0cN2_Wg@mail.gmail.com>
	<s5hoc1s4iu3.wl%tiwai@suse.de> <4DFF904E.3090802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D759C244B2
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 02:29:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DFF904E.3090802@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 08:24:14PM +0200, David Henningsson wrote:

> Exposing what mixers affect this port is highly desirable as well to
> get more accurate than the current name-based algorithm Pulseaudio
> currently uses.

Of course given the potential for internal routing within the card you
can only really say that about the very edge controls that are fully
committed to a given path - hence my comment about exposing the all the
routing being much better.

> Should we design something new, I think we should start with a
> pin/port concept rather than a jack concept. "Internal speaker"
> would then be a port that does not have a jack, whereas "Headphone"
> would be a port that has a jack.

I think that's too edge node focused, if we're going to define new
interfaces we may as well cover everything rather than doing half the
job.

> (Btw, I don't know much about DAPM and how well that scales to cope
> with these requirements, it looks very ASoC to me, but perhaps it's
> just the SND_SOC_DAPM_* naming that fools me. But can DAPM e g send
> events to userspace?)

No, there is no userspace visiblity of the routing map.  It's pretty
much exactly equivalent to the data HDA CODECs expose but shipped in
source rather than parsed out of the device at runtime.
