From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Patch: YMF753 AC '97
Date: Tue, 24 Sep 2002 14:37:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209241437040.503-100000@pnote.perex-int.cz>
References: <s5hwupboej1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwupboej1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: David Shust <dshust@bemail.org>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Sep 2002, Takashi Iwai wrote:

> At Mon, 23 Sep 2002 21:28:09 -0700,
> David Shust wrote:
> > 
> > I've written a patches for the 0.9.0rc2 and 0.9.0rc3 ac97-codec
> > driver in order to support the Yamaha YMF753. This chip is used in
> > the Toshiba Satellite 5000. Support is provided for S/PDIF output,
> > enhanced (wide) stereo, and the non-standard tone controls. All
> > features appear to work. 
> > 
> > Grab it here: www.shustring.net
> 
> thanks for your patch.
> the patch looks good except for the module options for spdif.
> since ac97_codec is a generic module, it's better to avoid such device
> specific options.  isn't it detectable?
> 
> > I would be delighted to have this merged with the ALSA driver,
> > provided that my copyright notice is left intact. It is only written
> > to the console if and when the YMF753 is actually detected: ALSA
> > AC'97 patch for Yamaha YMF753 (c) David Shust <dshust@shustring.com> 
> > 
> > Is this an unreasonable request?
> 
> we can keep it if you want, but please note that we don't print any
> messages generally from the ALSA driver.

Yes, it would be good to follow this policy for users who want to spend a 
few kilobytes of memory and auto-loading modules. We will be happy to 
include your copyright to the source comments.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
