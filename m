From: Daniel Pouzzner <douzzer@mega.nu>
Subject: Re: Waveterminal 192M Envy24HT
Date: Thu, 10 Apr 2003 12:41:17 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304101641.h3AGfHYU048669@mail.mega.nu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: cw@acidtechno.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I guess that we haven't received a reply from ESI regarding this ?

Sure enough, no response.

>is it worth trying the manufacture of the envy24ht chip (via i
>think)

My understanding is that the VIA piece of the puzzle is already in
place in ALSA (CVS at least, maybe release now).  By overriding the
EPROM version validator in that driver, I have actually gained access
to the Waveterminal's registers through amixer et al.  It just doesn't
capture or make any actual sound.

This is sortof frustrating because it suggests very little is needed
to make the card actually work.


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
