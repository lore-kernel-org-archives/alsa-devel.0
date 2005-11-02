From: Davin McCall <davmac@davmac.org>
Subject: Re: mmap_commit() and hardware buffering
Date: Wed, 2 Nov 2005 23:00:38 +1100
Message-ID: <20051102230038.6ef1f7be.davmac@davmac.org>
References: <20051101165651.2a5f125b.davmac@davmac.org>
	<s5h3bmf8gu4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3bmf8gu4.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 02 Nov 2005 11:49:39 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> > Despite snd_pcm_hw_params_is_batch() and is_double() both returning false, the hardware seems to be double buffering the mmap buffer. That is, if I snd_pcm_mmap_commit() the whole buffer, and then immediately modify the buffer, the modification doesn't take effect - the sound hardware just outputs the original contents of the buffer.
> 
> To be sure, do you call snd_pcm_mmap_begin() at each time?

Yes.


> 
> > Can anyone confirm whether these cards actually do double buffering?
> 
> No, it's not.

Ok, thanks. I actually ended up reading the datasheet and came to the same conclusion, but it's good that someone else can verify this.

> 
> > Or is there something else going on here? 
> 
> Basically no double-buffer should happen with mmap mode.
> Although the mmap buffer provided though alsa-lib plugin isn't
> always the real hardware buffer.  That is, the data ranged by
> snd_pcm_mmap_begin() is processed/transferred manually after
> mmap_commit().

Yes, that's the problem - it's using the plughw device instead of the hw device. Thanks again.

Davin


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
