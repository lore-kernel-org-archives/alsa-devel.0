From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 19:24:47 +0200
Message-ID: <20080414172447.GA25050@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<20080412133536.GC32491@tango.0pointer.de>
	<4800FC14.3060804@superbug.co.uk>
	<200804122025.57165.faber@faberman.de>
	<48010CF9.4000600@superbug.co.uk> <48010F76.1070209@keyaccess.nl>
	<20080414164843.GD22115@tango.0pointer.de>
	<48038DB3.8060301@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B7FEE2456B
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 19:24:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48038DB3.8060301@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 14.04.08 19:00, Rene Herman (rene.herman@keyaccess.nl) wrote:

> >>> Would that suit everyone better.
> >> On the aforementioned cs4236 which has a master -94.5 to +12 dB, 0dB 
> >> actually is the sane default (and the value I keep it at). It is an idea to 
> >> also init master to 0 dB iff master isn't just attenuation?
> > 
> > Maybe this should be considered a driver bug?
> 
> No. It's a straighforward export of the hardware. If ALSA were to start 
> hiding the hardware I were to start hiding ALSA -- in a dumpster.

Good joke. ALSA applies quirks an fixes in drivers all the
time. Calling that "hiding the hardware" is stupid.

The dB scale is a _relative_ scale. To make any sense there needs to be
some reference level defined. Right now, there is not, in ALSA. And
hence, the dB scales are pretty to look at, but very useless unless you
know your hardware very, very well. Which probably 99,99% of the
people do not, because they didn't write the driver they are using, or
because they are no super-guru-pro-audio-freaks.

All I am asking for is that ALSA is fixed and and starts to define what
the reference level is supposed to be. And then, the drivers need to
be fixed to follow this reference level and apply some offsets to what
the hw specs say.

Right now the dB levels in ALSA have no value at all because the
reference level is random and unknown. If someone claims otherwise
then he probably doesn't have any clue what he's talking of but feels
like a total guru because he's looking on dB scales.

> And do not set Reply-To. You turn all CCs into To's for one and make others 
> go through the troubl;e of fixing it again. If you can't be bothered with 
> mail to your inbox stop posting to linux lists.

Oh, come one. Get a clue. I love you too.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
