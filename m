From: Peter Chapman <x6pe9syq02@sneakemail.com>
Subject: Re: module_init fails with OEM SoundBlaster Live!
Date: Mon, 3 Nov 2003 21:40:17 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031103214017.GA4327@gondolin.homeip.net>
References: <20031102114634.GA13679@gondolin.homeip.net> <s5h4qxlve2h.wl@alsa2.suse.de> <20031103132012.GA16956@gondolin.homeip.net> <s5h3cd5v7bz.wl@alsa2.suse.de> <20031103155606.GA17691@gondolin.homeip.net> <s5hznfdtj6o.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hznfdtj6o.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 03, 2003 at 07:12:47PM +0100, Takashi Iwai tiwai-at-suse.de |alsa-devel| wrote:
> 
> no idea.  but you can try the attached patch.
> it disables the ac97's spdif control but it still keeps the emu10k1's
> one.  if you have an spdif receiver, give it a try.
> 
> 
> Takashi

Takashi, your patch lets me load the emu10k1 module. For me that's the
most important thing. My spdif output is still dead, though (my minidisc
keeps saying "no signal" even when I enable the control with alsamixer).
The card doesn't have an spdif receiver.
Thanks again,

Pete


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
