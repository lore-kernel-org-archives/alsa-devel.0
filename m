From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 18:20:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806131813150.1798@tm8103-a.perex-int.cz>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
	<s5hr6b1qrri.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131733180.1798@tm8103-a.perex-int.cz>
	<s5hmylpqq9z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 81F81103837
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 18:20:45 +0200 (CEST)
In-Reply-To: <s5hmylpqq9z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Jun 2008, Takashi Iwai wrote:

> The point is that the wake-up timing isn't defined as constant but via
> a timing queue (or a request queue).  This is more suitable for
> pull-style apps like JACK.  Which irq source is used doesn't matter.

But applications can use timers or any other wakeup source directly (for 
example from video card interrupt) - thus I'm not sure if it's good to 
complicate our API, again. If we remove period tied I/O operations and 
assumptions in alsa-lib (thus we will do only byte-stream transfers), then 
everything will be fine and possible.

Other option is to create such timing queues separately as complete new 
API without integration to PCM API. Complex apps call poll() anyway. 
Support this complex timing for read()/write() for simple apps does not 
make much sense, I think.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
