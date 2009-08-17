From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: Strange div-by-zero in alsa-lib 1.0.20's
	snd_pcm_mmap_begin()
Date: Mon, 17 Aug 2009 12:16:12 -0400
Message-ID: <604760770908170916q4ef25836x25bb0c9194d00a29@mail.gmail.com>
References: <604760770908161524w207a4a44m72793fa9438c2ef4@mail.gmail.com>
	<s5h3a7rvssh.wl%tiwai@suse.de>
	<20090817143615.GA16548@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f205.google.com (mail-bw0-f205.google.com
	[209.85.218.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 80DD1103801
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 18:16:14 +0200 (CEST)
Received: by bwz1 with SMTP id 1so2705829bwz.46
	for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2009 09:16:12 -0700 (PDT)
In-Reply-To: <20090817143615.GA16548@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Daniel Chen <seven.steps@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Lennart,

On Mon, Aug 17, 2009 at 10:36 AM, Lennart Poettering<mznyfn@0pointer.de> wrote:
> Could you get us the output of the PA startup phase when running
> "pulsaudio -vvvv"? This should show us to which value the buffer_size
> is initialized in the snd_pcm_t.

The requested debug output is available at
http://launchpadlibrarian.net/30422583/pulseaudio .

Thanks,
Dan
