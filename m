From: Christian Esken <c.esken@cityweb.de>
Subject: How to detect whether OSS mixer is emulated by ALSA
Date: Sat, 5 Apr 2003 18:21:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304051821.19599.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

my mixer (kmix) supports OSS and ALSA at the same time. This is good for a 
mixed-mode environment (e.g. if there is a TV card w/o ALSA support).

Unfortunately this means that kmix finds some mixers twice.
- One time the real thing (ALSA)
- One time the OSS-emulation

This will confuse users.

Is there any way to find out those OSS mixers which are just emulated?
I browsed http://www.alsa-project.org/~iwai/OSS-Emulation.html and other 
documentation but found nothing . I also tried to build the docs below 
alsa-doc/lib, but failed (Yes, I have openjade installed). 

Chris



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
