From: Frank Barknecht <fbar@footils.org>
Subject: Re: Build-in mixer
Date: Sun, 12 Oct 2003 18:44:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031012164410.GA5834@fliwatut.scifi>
References: <3F83C9B8.9050407@kky.zcu.cz> <200310081124.h98BOGqq018813@oud> <s5hsmm49bq5.wl@alsa2.suse.de> <1065886408.3f8822c843535@webmail.zcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1065886408.3f8822c843535@webmail.zcu.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
Daniel Tihelka hat gesagt: // Daniel Tihelka wrote:

> As I wrote some day ago, it is possible to play two or more sounds 
> simultenaously with mentioned setting. But only with 'aplay'
> 
> I tried to use xmms with ALSA 0.9 output plugin and Mplayer with ALSA-0.9.x 
> support and it is impossible to play any two sound streams at the same time (i 
> tried two xmms, xmms + mplayer, xmms + asound, mplayer + asound and two 
> mplayers, but only the first played and the second was stopped until the first 
> finished or breaked).
> 
> Where can be problem? 

The problem lies in the wrong way in which these apps try to use ALSA.
I don't use XMMS anymore, but for mplayer I can say, that it tries to
open hw:X devices and doesn't allow the user to specify a device by
name. As dmix goes beyond and extends the capabilites of the hardware
you're out of luck with these kind of apps unless the authors fix
their mistakes. For a correctly written ALSA music player try
alsaplayer. It works like a charm with dmix and since ALSA 0.9.7 it
does so even on my M-Audio Audiophile card btw.

You might have success with running these apps in OSS-mode and useing
alsa-oss.

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
