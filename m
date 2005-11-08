From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: Re: Fix for slow snd-ali5451 initialization
Date: Tue, 8 Nov 2005 19:48:05 +0200
Message-ID: <20051108174805.GC11694@tecr>
References: <Pine.LNX.4.61.0511051136400.16526@sixpak.sixpak.org> <s5hy840pw24.wl%tiwai@suse.de> <20051107154626.GA14736@tecr> <437034CC.5090903@sixpak.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <437034CC.5090903@sixpak.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Vince Busam <vince@sixpak.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 21:17 Mon 07 Nov     , Vince Busam wrote:
> >
> >Vince, could you drop the content of your /proc/asound/card0/ali5451 file?
> >
> 
> 48: 03114200

This '03' indicates that secondary codec is ready. But as I am
understanding you don't have secondary codec there.
Or hw report is invalid or we are using bad method (datasheet is
unavailable).

Sasha.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
