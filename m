From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 18:11:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806131800160.1798@tm8103-a.perex-int.cz>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<20080613142526.GB21255@tango.0pointer.de>
	<s5hod65qqhh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A629103822
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 18:11:14 +0200 (CEST)
In-Reply-To: <s5hod65qqhh.wl%tiwai@suse.de>
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

> What about just providing three pointers: curr_ptr, hw_ptr and
> appl_ptr?  curr_ptr corresponds to the point being played, and hw_ptr
> is the point where the data was already sent to h/w, and appl_ptr is
> the point where the data is filled by user.  The above definitions are
> all combinations of these pointers.

But I think that curr_ptr can be managed in drivers, thus invisible to 
user space (except for snd_pcm_delay() propagation). If driver requires 
extra handling of samples, it can allocate and manage extra buffers 
itself. I don't see the point to have "locked" samples already processed 
by hardware in the main ring buffer described by appl_ptr / hw_ptr.
Application can use this space for new samples.

The only advantage with your implementation might be zero-copy, but USB 
and PCMCIA cards have or create own buffers, so I don't think that this 
advantage can be used in actual drivers and I cannot even imagine 
hardware which work in way to use zero-copy in this situation.

> I really don't understand why we need to hide hw_ptr and appl_ptr in
> the current API.  To me, exposing these points is much more
> straightforward.
> 
> In addition, there will be an API to provide the position
> granularity as mentioned in the above.  But, this can be a different
> thing from the pointer APIs.

I agree.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
