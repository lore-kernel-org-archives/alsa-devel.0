From: Mark Knecht <markknecht@comcast.net>
Subject: Alsa-1.0.0rc2 Hammerfall Light - small bug report
Date: Sat, 06 Dec 2003 17:28:58 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070760538.5385.12.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   The Hammerfall Light driver has a couple of small bugs in the way it
identifies port status in /proc/asound where it lists the spdif port as
an ADAT port. I'm not using spdif on this machine so I cannot check to
see if it shows lock status correctly. Someone may want to look at this.

Cheers,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
