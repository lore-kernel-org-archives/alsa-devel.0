From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Monotonic timestamps
Date: Fri, 11 Apr 2008 14:16:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804111411180.13990@tm8103.perex-int.cz>
References: <20080409213602.GA2589@tango.0pointer.de>
	<Pine.LNX.4.61.0804100929390.13990@tm8103.perex-int.cz>
	<20080410142645.GB5852@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E0FC224382
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Apr 2008 14:16:21 +0200 (CEST)
In-Reply-To: <20080410142645.GB5852@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Apr 2008, Lennart Poettering wrote:

> On Thu, 10.04.08 09:48, Jaroslav Kysela (perex@perex.cz) wrote:
> 
> Hi,
> 
> > > The problem with this is that there seems to be no way to determine
> > > from an application if monotonic timestamps are enabled in an
> > > snd_pcm_t or not, ALSA just switches over to them, making the
> > > timestamps relatively useless, because we cannot reliable relate them
> > > to timestamps we query from the kernel ourselves -- because we just
> > > don't know if we need to use CLOCK_MONOTONIC or CLOCK_REALTIME.
> > 
> > Application can just do a simple comparsion between ALSA timestamp and 
> > gettimeofday() output. The gettimeofday() returns value since the Epoch, 
> > but CLOCK_MONOTONIC returns time since start of system. Thus, it's really 
> > easy to see if time matches or not (difference will be very big) to 
> > detect the time source. Value from gettimeofday() does not make much sense 
> > in audio (real time) environment.
> 
> Uh, this is a really ugly heuristic and is not compatible with the
> CLOCK_MONOTONIC docs. Quoting from http://www.opengroup.org/onlinepubs/000095399/functions/clock_getres.html:
> 
> <snip>
> If the Monotonic Clock option is supported, all implementations shall
> support a clock_id of CLOCK_MONOTONIC defined in <time.h>. This clock
> represents the monotonic clock for the system. For this clock, the
> value returned by clock_gettime() represents the amount of time (in
> seconds and nanoseconds) since an unspecified point in the past (for
> example, system start-up time, or the Epoch). This point does not
> change after system start-up time.
> </snip>

Thanks for this link. But in 2.6 linux kernel, there is only system 
start-up time initializer for CLOCK_MONOTONIC, so the check is not so 
heuristics. Anyway, I added these functions to ALSA API, so you can remove 
timestamp / rewind notes from your list:

+int snd_pcm_hw_params_is_monotonic(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_can_forward(const snd_pcm_hw_params_t *params);
+int snd_pcm_hw_params_can_rewind(const snd_pcm_hw_params_t *params);

Also note, that forward/rewind returns always 1 for current alsa-lib, 
because rewind was implemented in the dmix plugin. But I can imagine, that 
this check can be required for some compressed streams.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
