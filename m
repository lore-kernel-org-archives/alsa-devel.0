From: Andrew Burgess <aab@cichlid.com>
Subject: Re: Query devices in a non-blocking fashion
Date: Fri, 12 Dec 2003 10:31:35 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312121831.hBCIVZHQ024818@cichlid.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> Perhaps this could be refined in a future design of ALSA?

>We all think in the same way, but there's no simple solution for this
>problem. I prefer to have such configuration information in an user-space 
>database accessed via an alsa-lib API. It's nothing for the kernel space.

It seems like a program could be run at boot time or immediately after a
module is loaded and could query the sound device and compute this database.
Then no conflicts are possible since noone else has it open yet.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
