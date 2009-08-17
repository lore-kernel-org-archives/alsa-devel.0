From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Strange div-by-zero in alsa-lib
	1.0.20's	snd_pcm_mmap_begin()
Date: Mon, 17 Aug 2009 16:36:15 +0200
Message-ID: <20090817143615.GA16548@tango.0pointer.de>
References: <604760770908161524w207a4a44m72793fa9438c2ef4@mail.gmail.com>
	<s5h3a7rvssh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C7DB24752
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 16:36:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h3a7rvssh.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Daniel Chen <seven.steps@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 17.08.09 08:49, Takashi Iwai (tiwai@suse.de) wrote:

> 
> At Sun, 16 Aug 2009 18:24:35 -0400,
> Daniel Chen wrote:
> > 
> > Hi,
> > 
> > In https://bugs.launchpad.net/ubuntu/+source/alsa-lib/+bug/412677
> > we're debugging an issue where snd_pcm_mmap_begin(), at line 6409 with
> > 
> > *offset = *pcm->appl.ptr % pcm->buffer_size;
> > 
> > appears to have pcm->buffer_size == 0. What's the correct approach in
> > handling this corner case?
> 
> We could add a sanity check in the function, of course.
> But relying on it doesn't sound nice.
> 
> At least, the caller should be surely at the certain state that the
> buffer has been set up, i.e. checking whether snd_pcm_state() returns
> SETUP or better condition.

Hmm, this bug is triggered in PA apparently. PA doesn't call
snd_pcm_mmap_begin() before the setup finished completely. Not sure
what's going on here, but this smells as if pcm->buffer_size is not
properly initialized.

Daniel, does this happen right-away on PA startup? Or does it
happen sometime while playing?

Could you get us the output of the PA startup phase when running
"pulsaudio -vvvv"? This should show us to which value the buffer_size
is initialized in the snd_pcm_t.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
