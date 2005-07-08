From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000834]: alsa-utils 1.0.8 compilation failes
Date: Fri, 8 Jul 2005 10:35:35 +0200
Message-ID: <9a8f3371b50236f90a6d6468a15d045d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECAC717A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:35 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=834> 
======================================================================
Reported By:                soger
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   834
Category:                   alsaconf
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-18-2005 21:53 CET
Last Modified:              07-08-2005 10:35 CEST
======================================================================
Summary:                    alsa-utils 1.0.8 compilation failes
Description: 
I use the alsa driver shipped with the kernel 2.6.9, and I successfully
installed the lib and the oss-compat, but I have trouble compiling the
utils package.
`./configure' runs smoothly but when I try to `make' it says:

Making all in include
make[1]: Entering directory `/root/tmp/alsa-utils-1.0.8/include'
make  all-am
make[2]: Entering directory `/root/tmp/alsa-utils-1.0.8/include'
make[2]: Leaving directory `/root/tmp/alsa-utils-1.0.8/include'
make[1]: Leaving directory `/root/tmp/alsa-utils-1.0.8/include'
Making all in alsactl
make[1]: Entering directory `/root/tmp/alsa-utils-1.0.8/alsactl'
if gcc -DHAVE_CONFIG_H -I. -I. -I../include     -g -O2 -MT alsactl.o -MD
-MP -MF ".deps/alsactl.Tpo" \
  -c -o alsactl.o `test -f 'alsactl.c' || echo './'`alsactl.c; \
then mv -f ".deps/alsactl.Tpo" ".deps/alsactl.Po"; \
else rm -f ".deps/alsactl.Tpo"; exit 1; \
fi
gcc  -g -O2   -o alsactl  alsactl.o  -lasound -lm -ldl -lpthread
make[1]: Leaving directory `/root/tmp/alsa-utils-1.0.8/alsactl'
Making all in alsaconf
make[1]: Entering directory `/root/tmp/alsa-utils-1.0.8/alsaconf'
Making all in po
make[2]: Entering directory `/root/tmp/alsa-utils-1.0.8/alsaconf/po'
mv: cannot stat `t-ja.gmo': No such file or directory
make[2]: *** [ja.gmo] Error 1
make[2]: Leaving directory `/root/tmp/alsa-utils-1.0.8/alsaconf/po'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/tmp/alsa-utils-1.0.8/alsaconf'
make: *** [all-recursive] Error 1


I have no idea what t-ja.gmo could be, I have not once met an error
message like this before. I would appreciate any help.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 14:29 
----------------------------------------------------------------------
This is lack of gettext.
Already fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-18-05 21:53 soger          New Issue                                    
01-19-05 14:29 tiwai          Status                   new => resolved     
01-19-05 14:29 tiwai          Resolution               open => fixed       
01-19-05 14:29 tiwai          Assigned To               => tiwai           
01-19-05 14:29 tiwai          Note Added: 0003268                          
01-19-05 14:29 tiwai          Assigned To              tiwai =>            
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
