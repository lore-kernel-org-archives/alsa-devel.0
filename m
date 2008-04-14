From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 18:48:43 +0200
Message-ID: <20080414164843.GD22115@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk> <48010F76.1070209@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id DC7F52452A
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 18:48:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48010F76.1070209@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 12.04.08 21:37, Rene Herman (rene.herman@keyaccess.nl) wrote:

> > For the master we could select say minimum dB + 12.
> > So, if the Master ranged from -70 to 0 dB, we would set Master to -70 + 
> > 12 = -58dB.
> > 
> > Would that suit everyone better.
> 
> On the aforementioned cs4236 which has a master -94.5 to +12 dB, 0dB 
> actually is the sane default (and the value I keep it at). It is an idea to 
> also init master to 0 dB iff master isn't just attenuation?

Maybe this should be considered a driver bug?

Shouldn't we require from all ALSA drivers that -30 dB on the master
is a "sane default"? Otherwise I am not sure what the dB scale is
worth anyway if humans don't have the slightest idea what they
actually could mean.

I mean, the biggest problem with integer volume scales was that nobody
had the knew what they actually meant. Now it turns out that
the dB scale exported in ALSA these days ain't any better either,
since still noone knows what 0db actually refers too.

Why not just say that -30db on master should be a "sane default"
volume level, and 0db on all others. If a driver doesn't follow this
it's a buggy driver.

It shouldn't be too difficult to fix the volume calculation in the
drivers accordingly.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
