From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: aplay CVS now works. alsamixer CVS is slightly odd.
Date: Sun, 22 Sep 2002 13:54:50 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209221349340.531-100000@pnote.perex-int.cz>
References: <20020922094358.98516.qmail@web40601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020922094358.98516.qmail@web40601.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 22 Sep 2002, [iso-8859-1] Chris Rankin wrote:

>  --- Jaroslav Kysela <perex@perex.cz> wrote:
> > Note that these controls are enumerated (it's a list
> > of available 
> > options). If you have an idea for better
> > representation, let us know.
> 
> Eh? I am merely pointing out that the alsamixer-CVS
> display looks different to the alsamixer-rc3 display.
> My initial reaction was "bug"; are you saying that
> it's supposed to look like this?

Takashi added a visual representation for new controls. This control says:
We have a list of string, please, select one. There is no number
corresponding with the hardware settings in this case (I speak about 'PCM
Out Path & Mute' or 'Mic Select' bars). Anyway, it seems that numbers for
controls without "volume" settings are removed, too. It seems ok to me:
user might took a hint that up/down buttons won't work for these bars.
It would be nice to have more these hints to show that only mute 
and/or capture select will work for given bars, but I'm out of ideas to 
show this in text environment.

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
