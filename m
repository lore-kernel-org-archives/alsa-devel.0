From: peloy@chapus.net (Eloy A. Paris)
Subject: Re: RC7 and CS46xx (GTXP)
Date: 05 Feb 2003 13:31:55 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87k7gefujo.fsf@canaima.chapus.net>
References: <20030201144858.0479188a.flame@home.se>
	<20030201170036.47cea5c3.flame@home.se>
	<20030202155918.GA6339@chapus.net> <s5h7kchip8i.wl@alsa2.suse.de>
	<20030203131737.00bb2c0b.flame@home.se> <s5hk7gggrro.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7gggrro.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Richard Olsson <flame@home.se>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Takashi Iwai <tiwai@suse.de> writes:

> At Mon, 3 Feb 2003 13:17:37 +0100,
> Richard Olsson wrote:
> > 
> > On Mon, 03 Feb 2003 12:21:33 +0100
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > could you try the latest cvs version?
> > > i just changed a little the code.
> > > hopefully this works for you...
> > 
> > I tried the new version just a moment ago as the CVS changelog mentioned
> > the magic word "amplifier" ;).  The warning message in dmesg is gone but
> > the sound is still disorted - sounds just like the amplifier isn't
> > turned on or something.
> 
> could you once build the alsa-driver with --with-debug=detect option
> and check the kernel messages after reloading the module?

The problem I reported in:

http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg06092.html

is fixed in the latest CVS code. Thank you.

I don't have the distortion problem that Richard Olsson reports.

Cheers,

Eloy.-


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
