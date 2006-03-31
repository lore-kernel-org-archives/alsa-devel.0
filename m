From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: driver-1.0.11rc4 breaks midi port 2
Date: Fri, 31 Mar 2006 18:28:17 +0100
Message-ID: <200603311828.17972.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The ice1712 midi port 2 I have been working on with -rc3 seems not to work in 
-rc4.  With my patch (pending) the correct names appear in sequencer window 
etc, and port 1 operates as before, but though midi activity is visible in 
the sequencer, no sounds are heard from the wavetable card.

I've studied the detailled changelog but have not been successful in 
identifying the change responsible. Patched files from rc4 work in rc3, and 
lib-rc4 is OK with driver-rc3 (but not the reverse).  Any quick ideas of what 
to look at??

Thanks  Alan



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
