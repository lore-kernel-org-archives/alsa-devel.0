From: Jeremy Hall <jhall@maoz.com>
Subject: intel8x0: sample rate problems in playback
Date: Wed, 3 Dec 2003 10:06:52 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312031506.hB3F6q9Y011232@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hello,

I tried to run realplayer after taking a massive CVS update, and now alsa 
seems to try to up-sample the material, causing a tinny effect.

and now with today's CVS, I get:

error in snd_ac97_set_rate: cidx=0, reg=0x2e, rate=48000

and no discernable difference in audio, it works ok.

_J


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
