From: Christian Esken <c.esken@cityweb.de>
Subject: Understanding duplicated Mixer Devices
Date: Sat, 13 Dec 2003 14:47:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312131447.45085.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

I have a question regarding "duplicated" Mixer devices. I see in various mixer 
application, that my CS46xx soundcard has 2 "Master", "PCM", "CD", "Mic", "3D 
Control Center" and several more devices with the same name.

On the other hand, there is only 1 "Surround", 1 "Headphone", and so on.

So what is the purpose of the duplicated devices? I don't want to make it too 
complicated, so lets start with "Master".
- The first "Master" is controlling Front volume
- The second "Master" does not seem to controll anything
- The "Surround" item is controlling Rear volume

Some hint in the right direction would be nice,
   Chris

PS: Currently I am wildly guessing, that the "unused" devices will get useful 
in the case when some special routing is done.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
