From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Questions on locking, snd-usb-caiaq
Date: Tue, 22 Sep 2009 06:53:56 +0200
Message-ID: <20090922045354.GX9361@buzzloop.caiaq.de>
References: <alpine.BSO.2.01.0909201207350.12606@zrgural.vwaro.pbz>
	<s5h1vm0xvxx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CC66C10385B
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 06:54:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h1vm0xvxx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Mark Hills <mark@pogo.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 21, 2009 at 03:35:06PM +0200, Takashi Iwai wrote:
> At Sun, 20 Sep 2009 13:07:05 +0100 (BST),
> Mark Hills wrote:
> > 
> > I fixed some race issues in snd-usb-caiaq, but have some questions on the 
> > interface between the driver and ALSA.
> > 
> > First fix is a lock in pointer(), which caused snd_pcm_update_hw_ptr_pos() 
> > to report an out of range buffer position (even though it was sucessfully 
> > corrected to zero).
> > 
> > Second is a lock as part of trigger(). On testing, this appears to fix an 
> > issue where white noise could sometimes be transferred by the driver.
> 
> Both look fine to me.

To me as well, but I'm currently unable to test them. But I trust Mark -
he's been tracking that issue for a long time already and was the only
one so far observing this bug. If those patches fix it for him, they
should definitely go in. So assume my Acked-by: on them :)

Thanks,
Daniel
