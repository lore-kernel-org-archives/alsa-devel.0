From: Gary Scavone <gary@ccrma.Stanford.EDU>
Subject: weird snd_ctl_open() behavior
Date: Thu, 5 Jun 2003 10:51:29 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306051041350.29666-100000@cmn24.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi all,

I'm making use of a card's id (via the snd_ctl_card_info_get_id() 
function) to access a device.  Recently, I noticed some inconsistent 
behavior.  On a machine with an OmniIO box, if no "id" is set in the 
/etc/modules.conf file, a default id of "66" is returned.  So, when I 
attempt to use the snd_ctl_open() function, my ascii identifier looks 
like "hw:66" and the function call fails.  If I provide an "id" in 
/etc/modules.conf (ex. id=omniIO), then my ascii identifier looks like 
"hw:omniIO" and the call to snd_ctl_open() works.

On my home laptop with a Maestro2e chipset, I don't have this problem
(though I need to look more carefully at this when I go home because I
don't use the value returned from snd_ctl_card_info_get_id() if the
string length is zero and that might be happening on my laptop).

Am I doing something wrong here?  Thanks.

--gary





-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
