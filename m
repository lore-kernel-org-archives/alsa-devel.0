From: Richard Olsson <flame@home.se>
Subject: Re: RC7 and CS46xx (GTXP)
Date: Sat, 1 Feb 2003 17:00:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030201170036.47cea5c3.flame@home.se>
References: <20030201144858.0479188a.flame@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030201144858.0479188a.flame@home.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

> Something between CVS 2002-12-18 and RC7 seriously broke the amplifier
> stuff for me on my GTXP - sound is very disorted and volume is very
> low. It's different from the troubles RC6 gave me though.  I'd guess
> it's the recent amplifier patch that was applied to the CS46xx driver.

Replying to my own mail, I know:)

I reverted the changes the recent amplifier patch did to cs46xx_lib.c
and RC7 works perfectly - no warning in dmesg either.

-- 
Richard Olsson
flame@home.se
http://www.nyo-box.net/ - http://www.aelia-studios.org/


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
