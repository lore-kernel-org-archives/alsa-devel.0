From: Lee Revell <rlrevell@joe-job.com>
Subject: alsa makefiles don't work with -jN where N > 1
Date: Tue, 24 Aug 2004 15:44:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1093376680.817.48.camel@krustophenia.net>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Subject says it all.  Here is the relevant section from the GNU make documentation:

`warning: jobserver unavailable: using -j1. Add `+' to parent make rule.'
        In order for make processes to communicate, the parent will pass
        information to the child. Since this could result in problems if
        the child process isn't actually a make, the parent will only do
        this if it thinks the child is a make. The parent uses the
        normal algorithms to determine this (see section 5.6.1 How the
        MAKEVariable Works). If the makefile is constructed such that
        the parent doesn't know the child is a make process, then the
        child will receive only part of the information necessary. In
        this case, the child will generate this warning message and
        proceed with its build in a sequential manner.

I believe this is because some of the rules in the makefile aren't make
commands, but rm -f's.  This always seemed dangerous and sloppy to me -
why does make need to rm -f anything?  Isn't this the whole point of
makefiles, so you don't have to rm -f your tree and rebuild every time
you change something? 

Lee



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
