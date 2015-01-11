From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] ALSA: lx6464es: lx_core: Remove some unused functions
Date: Sun, 11 Jan 2015 12:18:06 -0800
Message-ID: <20150111201806.GA1074@thin>
References: <1420990982-20187-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <s5htwzx2txw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5htwzx2txw.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jaroslav Kysela <perex@perex.cz>, Maxime Ripard <maxime.ripard@free-electrons.com>, Rashika Kheria <rashika.kheria@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 11, 2015 at 04:55:23PM +0100, Takashi Iwai wrote:
> At Sun, 11 Jan 2015 16:43:02 +0100,
> Rickard Strandqvist wrote:
> > 
> > Removes some functions that are not used anywhere:
> > lx_buffer_cancel() lx_buffer_free() lx_stream_sample_position()
> > lx_stream_state() lx_pipe_sample_count()
> 
> We really shouldn't delete the code but keep somehow disabled for such
> a driver that has no hardware spec documents available.  Since the
> source code is the only reference, the implemented code is the only
> information if we need to change / fix anything.

Easy enough to get it back out of version control if so.

- Josh Triplett
