From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000834]: alsa-utils 1.0.8 compilation failes
Date: Wed, 19 Jan 2005 14:29:01 +0100
Message-ID: <5c7d4fd765e4e5260ac99333bfc35dd1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 004C124F
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 14:29:01 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=834> 
======================================================================
Reported By:                soger
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   834
Category:                   alsaconf
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-18-2005 21:53 CET
Last Modified:              01-19-2005 14:29 CET
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
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
