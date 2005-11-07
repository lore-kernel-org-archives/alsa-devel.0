From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: Re: Fix for slow snd-ali5451 initialization
Date: Mon, 7 Nov 2005 17:46:26 +0200
Message-ID: <20051107154626.GA14736@tecr>
References: <Pine.LNX.4.61.0511051136400.16526@sixpak.sixpak.org> <s5hy840pw24.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hy840pw24.wl%tiwai@suse.de>
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
Cc: Vince Busam <vince@sixpak.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 11:54 Mon 07 Nov     , Takashi Iwai wrote:
> At Sat, 5 Nov 2005 11:38:03 -0800 (PST),
> Vince Busam wrote:
> > 
> > The snd-ali5451 driver takes 10 seconds to load, which is quite annoying 
> > on a laptop that boots every day.  This patch lowers that to a much more 
> > managable time, and still works fine on my laptop.
> > 
> > Vince
> > 
> >      Summary: Speed up ali5451 initialization
> > 
> >      The patch speeds up loading the ali5451 driver by lowering the
> >      wait time in snd_ali_codec_ready()
> > 
> >      Author: Vince Busam <vince@sixpak.org
> >      Signed-off-by: Vince Busam <vince@sixpak.org>
> 
> Well, it's not a good solution.  It's already strange that so many
> timeouts occur.  And, the driver works correctly after that?  That is,
> you don't get any timeouts once after the driver is initialized?

This could be initialization attempt of non-existed secondary codec. At
least such attempt was reported in the past.

Vince, could you drop the content of your /proc/asound/card0/ali5451 file?

Sasha.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
