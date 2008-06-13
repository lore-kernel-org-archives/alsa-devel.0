From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 10:14:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8173224429
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 10:14:35 +0200 (CEST)
In-Reply-To: <s5hd4mlhlau.wl%tiwai@suse.de>
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

> - Add some new API functions,

I would prefer to extend the current API than to change meaning of hw_ptr 
to handle extra latencies.

>   * To give the accuracy of the position inquiry (optional)
> 
>     This requires some new kernel <-> user-space stuff.

>   * To query the known latency
> 
>     Ditto, or we may reuse snd_pcm_hw_params_fifo_size()?

Yes, fifo_size was designed to announce possible extra latency to 
applications.

>   * To query the position being played (optionally)
> 
>     This can be simply hwptr + latency.
> 
> - Don't change snd_pcm_delay().  Keep as is now.
> 
> 
> About the period model -- it's a bit more tough problem.
> I once already made a patch to allow user-apps to use a system timer
> for more flexible period settings.  But, it was for very old version
> of ALSA.  Better to write from the scratch again...

I think that the current PCM API concept is tightly period based. You 
cannot change it easily. It would be probably better to move to 
"byte-stream" in next revision of PCM API.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
