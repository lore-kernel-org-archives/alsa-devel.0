From: Mark Knecht <markknecht@comcast.net>
Subject: Re: ALSA 1.0.0rc1 released
Date: Mon, 01 Dec 2003 12:56:35 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070312195.3552.14.camel@Wizard.knechthome.com>
References: <s5hu14kabjn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu14kabjn.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
   I want to report that I've built alsa-1.0.0rc1 under Gentoo with q
2.4.20-r7 kernel. Thanks to Thomas Charbonnel for the help with the
ebuilds. If any other Gentoo users need the ebuilds, then contact me off
list.

   Unfortunately this release does not impact my loud glitch/pop noise
on the HDSP 9652 when using OSS applications. The results are the same
as I reported over the last few weeks.

   I have not run significant Alsa audio yet to talk about how that's
working. The OSS fix was the one I was most hoping for, and I haven't
had many Alsa problems anyway.

- Thanks,
Mark

On Mon, 2003-12-01 at 05:54, Takashi Iwai wrote:
> Hi,
> 
> today we reached ALSA 1.0.0rc1 release.
> as its name stands, this is the "release candidate" for 1.0.0.
> if no show-stopper bug is reported, we'll release 1.0.0 really
> soon.
> 
> this version includes the following fixes since the last 1.0.0-pre3
> release.
> 
> Drivers:
> - fixed OSS emulation on kernel.  quake and wine should work now.
<SNIP>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
