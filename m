From: Stefan Kristiansson <stefan@langante.mine.nu>
Subject: 5.1 sound with cmi8738
Date: Fri, 21 Nov 2003 23:29:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBE91AD.7010806@langante.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I had some troubles getting 5.1 sound to work with my cmi8738 based card 
and noticed that
CMI8738-MC6.conf says:

CMI8738-MC6.pcm.surround51.0 "cards.CMI8738-MC6.pcm.front.0"

this doesn't work (at least not with my card)
and it makes sense, since it's the second dac that is handling the 4/6 
channel  stuff.

this works:

CMI8738-MC6.pcm.surround51.0 "cards.CMI8738-MC6.pcm.surround40.0"

/Stefan Kristiansson



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
