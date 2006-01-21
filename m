From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: SBLive! subsystem 8066
Date: Fri, 20 Jan 2006 21:22:53 -0500
Message-ID: <1137810173.3241.95.camel@mindpipe>
References: <1137536331.19678.47.camel@mindpipe>
	 <s5hlkxb7xg8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkxb7xg8.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-01-20 at 16:04 +0100, Takashi Iwai wrote:
> At Tue, 17 Jan 2006 17:18:51 -0500,
> Lee Revell wrote:
> > 
> > ...is still "Unknown" by the ALSA driver.
> > 
> > Can we get something like this merged before the 1.0.11 release:
> > 
> > +       /* See ALSA bug #1036 - model is from windows driver */
> > +       {.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80661102,
> > +        .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
> > +        .id = "Live",
> > +        .emu10k1_chip = 1,
> > +        .ac97_chip = 1,
> > +        .sblive51 = 1} ,
> > 
> > It might be SB0222, I am not 100% certain.
> 
> Isn't it already in CVS?  The name is different (it's "SB Live 5.1
> Dell OEM [SB0220]", though).

I thought so too but "cvs diff" said it was not, and now ALSA CVS is
broken, AGAIN...

$ cvs diff pci/emu10k1/emu10k1_main.c
cvs [diff aborted]: end of file from server (consult above messages if
any)

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
