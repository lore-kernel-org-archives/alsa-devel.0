From: Marcel <shizuma@magma.ca>
Subject: Re: CMI8738-MC6 surround40 plugin on 4 SP systems]
Date: Fri, 31 Oct 2003 12:39:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031031173918.GA29835@dailyplanet.net>
References: <20031030174239.GB2771@dailyplanet.net> <s5hptgduzgs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hptgduzgs.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

* Takashi Iwai (tiwai@suse.de) wrote:
> At Thu, 30 Oct 2003 12:42:39 -0500,
> Marcel wrote:
> > 
> > 
> > I've been trying to finetune my cmipci for several weeks now.   And this is
> > the best way I've been able to get transparent operation with various audio
> > material: stereo, mono, 4.0, 5.1.  The main problem being no surround sound
> > iif "Exchange DAC" setting was not set, and sound on the rear speakers only
> > if it was.
> 
> ah, this might be true.
> does it happen both on 4.0 and 5.1 outputs?
> i don't remember that it's necessary for 5.1 at the last time i
> tested.

With surround40 plugin, 4 speakers, yes it's needed for both 4.0 and 5.1
material.  Applications such as mplayer or xine will remix 5.1 material to
4 channels.  For 6 speakers systems, I really don't know.

> perhaps we should simply remove this control from user and handle
> internally for the MC6 chip.
> 

I agree.  Its usage is confusing and may results in improper operation


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
