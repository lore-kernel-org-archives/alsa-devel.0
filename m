From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Problems with safe API and snd-cs46xx
Date: Tue, 8 Sep 2009 00:47:00 +0200
Message-ID: <20090907224659.GA5917@tango.0pointer.de>
References: <a080dbc80909050524o7b00ceas46184b52fdac9cbc@mail.gmail.com>
	<s5hljkrrl3s.wl%tiwai@suse.de> <1252330155.3283.5.camel@localhost>
	<s5hbplmssrg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A2ECF2439C
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 00:47:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbplmssrg.wl%tiwai@suse.de>
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
Cc: Tony Vroon <tony@linx.net>, alsa-devel@alsa-project.org, Sophie Hamilton <sophie-alsa@theblob.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 07.09.09 17:01, Takashi Iwai (tiwai@suse.de) wrote:

> Maybe a bit "safer" option would be to check the period min size and
> raise to a sane value as a workaround.
> 
> Or, if the period size doesn't matter much but rather the buffer size
> is more important, you can first limit the buffer size as max.  Then
> call snd_pcm_hw_params().  Without this, the PCM core determines the
> period size first, then the buffer size.

Hmm, I wonder what this means for PulseAudio. In the past we had
various problems with the functions for setting the buffer metrics and
the order in which we called them. 

For a short while we used to call
snd_pcm_hw_params_set_buffer_size_near() first, then
snd_pcm_hw_params_set_periods_near() and then snd_pcm_hw_params().

This turned out to cause a couple of issues with some drivers (i think
CS46xx is one of them, ice1712 another, I lack the hw in question, so
i never tried to track this down further). Basically on those drivers
both _set_buffer_size_near() and _set_periods_near() would fail with
EINVAL for some reason and then causing snd_pcm_hw_params() to return
ENOENT. Removing the two calls and calling snd_pcm_hw_params() would
however work. Changing the order of the first two calls, i.e. doing
first _set_periods_near() and then _set_buffer_size_near() would make
both calls succeed and the snd_pcm_hw_params(), too.

It would be good if the ALSA docs would actually mention in which
order those functions need to be called, if the order matters, which
it apparently does.

(Hmm, and while we are at it. Ssome other driver I don't posess,
ens1371 has some issues with the buffer size: if you ask it for 65536
bytes in the playback buffer it will only agree to 65532. If the next
time you ask for 65532 right-away it will only agree to 65528, and so on...)

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
