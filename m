From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000781]: make install fails with current alsa-utils cvs.
Date: Mon, 3 Jan 2005 13:44:40 +0100
Message-ID: <277e9fb48a5209bdb7f26d8358169931@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D9C0F2CE
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 13:44:40 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=781> 
======================================================================
Reported By:                jcdutton
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   781
Category:                   alsaconf
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-03-2005 13:44 CET
Last Modified:              01-03-2005 13:44 CET
======================================================================
Summary:                    make install fails with current alsa-utils cvs.
Description: 
alsa-utils # make install
Making install in m4
make[1]: Entering directory `/u/alsacvs/alsa-utils/m4'
make[2]: Entering directory `/u/alsacvs/alsa-utils/m4'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/u/alsacvs/alsa-utils/m4'
make[1]: Leaving directory `/u/alsacvs/alsa-utils/m4'
Making install in include
make[1]: Entering directory `/u/alsacvs/alsa-utils/include'
make[2]: Entering directory `/u/alsacvs/alsa-utils/include'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/u/alsacvs/alsa-utils/include'
make[1]: Leaving directory `/u/alsacvs/alsa-utils/include'
Making install in alsactl
make[1]: Entering directory `/u/alsacvs/alsa-utils/alsactl'
make[2]: Entering directory `/u/alsacvs/alsa-utils/alsactl'
test -z "/usr/sbin" || mkdir -p -- "/usr/sbin"
  /bin/install -c 'alsactl' '/usr/sbin/alsactl'
test -z "/usr/man/man1" || mkdir -p -- "/usr/man/man1"
 /bin/install -c -m 644 './alsactl.1' '/usr/man/man1/alsactl.1'
make[2]: Leaving directory `/u/alsacvs/alsa-utils/alsactl'
make[1]: Leaving directory `/u/alsacvs/alsa-utils/alsactl'
Making install in alsaconf
make[1]: Entering directory `/u/alsacvs/alsa-utils/alsaconf'
Making install in po
make[2]: Entering directory `/u/alsacvs/alsa-utils/alsaconf/po'
../.././mkinstalldirs /usr/share
make[2]: ../.././mkinstalldirs: Command not found
make[2]: *** [install-data-yes] Error 127
make[2]: Leaving directory `/u/alsacvs/alsa-utils/alsaconf/po'
make[1]: *** [install-recursive] Error 1
make[1]: Leaving directory `/u/alsacvs/alsa-utils/alsaconf'
make: *** [install-recursive] Error 1

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-05 13:44 jcdutton       New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
