From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Tue, 28 Jun 2011 09:35:27 -0700
Message-ID: <20110628163523.GA21570@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
	<4E0A00E3.5000102@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9FA8D103896
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 18:35:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E0A00E3.5000102@canonical.com>
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

On Tue, Jun 28, 2011 at 05:27:15PM +0100, David Henningsson wrote:

> As such, it makes the most sense for me to continue working on the
> existing input layer API for the time being. If or when a new API is
> announced and finished, rewriting the pulseaudio patches to target
> that API will probably make sense. But we're not there today, and
> the time schedule for getting there is unknown.

> If upstream udev/PulseAudio would be willing to merge my (existing
> and upcoming) patches, I would appreciate that, as I believe that
> would make both our lives easier. If not, well at least make a note
> that I /tried/ to do things the right way, and to make everybody
> happy - which is not always possible.

FWIW I tend to agree that pragmatically it'd make a lot of sense to
support the current kernel interfaces in userspace even if we're also
going to decide to deprecate them, if only for the deployment reasons
you mention.
