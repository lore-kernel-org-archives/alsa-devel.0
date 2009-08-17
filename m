From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Strange div-by-zero in alsa-lib
	1.0.20's	snd_pcm_mmap_begin()
Date: Mon, 17 Aug 2009 18:38:25 +0200
Message-ID: <20090817163825.GA29134@tango.0pointer.de>
References: <604760770908161524w207a4a44m72793fa9438c2ef4@mail.gmail.com>
	<s5h3a7rvssh.wl%tiwai@suse.de>
	<20090817143615.GA16548@tango.0pointer.de>
	<604760770908170916q4ef25836x25bb0c9194d00a29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A0797247B3
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 18:38:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <604760770908170916q4ef25836x25bb0c9194d00a29@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 17.08.09 12:16, Daniel Chen (seven.steps@gmail.com) wrote:

> 
> Hi Lennart,
> 
> On Mon, Aug 17, 2009 at 10:36 AM, Lennart Poettering<mznyfn@0pointer.de> wrote:
> > Could you get us the output of the PA startup phase when running
> > "pulsaudio -vvvv"? This should show us to which value the buffer_size
> > is initialized in the snd_pcm_t.
> 
> The requested debug output is available at
> http://launchpadlibrarian.net/30422583/pulseaudio .

Hmm, that output shows that buffer_size is initialized to 16384, and
the SIGFPE is not thrown.

Could you please reproduce this issue and tell us what buffer_size is
then?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
