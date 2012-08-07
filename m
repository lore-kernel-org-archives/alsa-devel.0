From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Plumbers: Please split audio topics into separate
	sessions
Date: Tue, 7 Aug 2012 14:57:36 +0100
Message-ID: <20120807135735.GG16861@opensource.wolfsonmicro.com>
References: <50201664.7000804@canonical.com> <s5hwr1bizuj.wl%tiwai@suse.de>
 <50202500.5060607@canonical.com>
 <20120806222417.GF26698@opensource.wolfsonmicro.com>
 <s5htxwfi6pb.wl%tiwai@suse.de> <5020B8AF.3090003@canonical.com>
 <s5hhasfi3b4.wl%tiwai@suse.de> <5020CD16.6020705@canonical.com>
 <20120807111519.GY16861@opensource.wolfsonmicro.com>
 <5020FB6D.6000503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0136026521F
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 17:56:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5020FB6D.6000503@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 01:26:37PM +0200, David Henningsson wrote:
> On 08/07/2012 01:15 PM, Mark Brown wrote:

> >Isn't this a fairly simple Pulse/distro issue?

> PulseAudio - no, because PulseAudio does not control *all* volumes.
> They're partially overlapping, but not completely.

Oh, that's very surprising - my understanding had been that PulseAudio
was essentially just ignoring the configuration it got on startup.  Is
there any great reason not to subsume the functionality currently done
using alsactl?

> Distro - well, a distro can do anything they/we want, but
> recommendations from upstream will reduce confusion and risk for
> distros being bonked by upstream with the "you're doing it wrong,
> stupid!" message.

What I was suggetsing was that this become our advice for the distros.

> >For
> >that I guess if Pulse does something the distros would be happy to just
> >follow that?

> Not all distros use PulseAudio either, but maybe that's beyond the
> scope of the actual discussion.

I think so, if they're replacing all the software managing the
configuration they ought to be comfortable doing their own replacement.
