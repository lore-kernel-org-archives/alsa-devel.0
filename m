From: "Eloy A. Paris" <peloy@chapus.net>
Subject: Re: RC7 and CS46xx (GTXP)
Date: Sun, 2 Feb 2003 10:59:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030202155918.GA6339@chapus.net>
References: <20030201144858.0479188a.flame@home.se> <20030201170036.47cea5c3.flame@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030201170036.47cea5c3.flame@home.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Olsson <flame@home.se>
Cc: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi!

My Santa Cruz is not working with RC7 either, but in my case I
get no sound at all. I've traced the problem to changes that took
place in CVS between 1/21 and 1/22, probably to cs46xx_lib.c. See
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg06092.html
for the details.

Cheers,

Eloy.-

On Sat, Feb 01, 2003 at 05:00:36PM +0100, Richard Olsson wrote:
> > Something between CVS 2002-12-18 and RC7 seriously broke the amplifier
> > stuff for me on my GTXP - sound is very disorted and volume is very
> > low. It's different from the troubles RC6 gave me though.  I'd guess
> > it's the recent amplifier patch that was applied to the CS46xx driver.
> 
> Replying to my own mail, I know:)
> 
> I reverted the changes the recent amplifier patch did to cs46xx_lib.c
> and RC7 works perfectly - no warning in dmesg either.
> 
> -- 
> Richard Olsson
> flame@home.se
> http://www.nyo-box.net/ - http://www.aelia-studios.org/
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
