From: Dave Neuer <mr_fred_smoothie@yahoo.com>
Subject: Re: [ANN] ALSA 1.0.0pre1 is released
Date: Thu, 20 Nov 2003 10:30:32 -0800 (PST)
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20031120183032.19750.qmail@web10407.mail.yahoo.com>
References: <s5hn0as1hvn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0as1hvn.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Takashi Iwai <tiwai@suse.de> wrote:
> Hi all,
> 
> - PCM OSS emulation might cause oops when you
> compile the kernel
>   without frame pointer (depending on the compiler).

Hi,

As a Gentoo user whose make.conf includes
-fomit-frame-pointer (gcc 3.3.2), I'd love it if you
could elaborate on that a little bit:

a) is this code also in the mainline kernel
(test9-bk*)?

b) any idea what would be required to fix it to allow
no frame pointer?

I just started experiencing oopsen yesterday after
installing -test9-bk24, using the older libs/utils
(0.98, I think). But I also put new hardware in (IEEE
1394 card) and added USB mouse support. I'm seeing
weird things on my earlier kernel version, too so it
could certainly be unrelated...

Dave


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
