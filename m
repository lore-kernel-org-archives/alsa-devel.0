From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000847]: alsa-tools 1.0.8 fail to compile on ppc64
Date: Mon, 24 Jan 2005 21:09:51 +0100
Message-ID: <ea3a1293e5572b0b644d3b4e4b40dfc1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EF827212
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2005 21:09:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=847> 
======================================================================
Reported By:                Markus Rothe
Assigned To:                perex
======================================================================
Project:                    ALSA - tools
Issue ID:                   847
Category:                   ac3dec
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             01-24-2005 21:09 CET
Last Modified:              01-24-2005 21:09 CET
======================================================================
Summary:                    alsa-tools 1.0.8 fail to compile on ppc64
Description: 
Hi,

I'm just trying to compile alsa-tools 1.0.8 on my G5, which runs Gentoo
Linux.

Here comes the output:

checking for ALSA CFLAGS... 
checking for ALSA LDFLAGS...  -lasound -lm -ldl -lpthread
checking for libasound headers version >= 1.0.0... found.
checking for snd_ctl_open in -lasound... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: executing depfiles commands
if powerpc64-unknown-linux-gnu-gcc -DPACKAGE_NAME=\"\"
-DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKAGE_STRING=\"\"
-DPACKAGE_BUGREPORT=\"\" -DPACKAGE=\"cspctl\" -DVERSION=\"0.2.0\"
-DSTDC_HEADERS=1 -DHAVE_LIBASOUND=1  -I. -I.   -I/usr/include/fltk-1.1 
-mcpu=G5 -O3 -pipe -fsigned-char -mabi=altivec  -MT cspctl.o -MD -MP -MF
".deps/cspctl.Tpo" \
  -c -o cspctl.o `test -f 'cspctl.c' || echo './'`cspctl.c; \
then mv -f ".deps/cspctl.Tpo" ".deps/cspctl.Po"; \
else rm -f ".deps/cspctl.Tpo"; exit 1; \
fi
powerpc64-unknown-linux-gnu-gcc  -mcpu=G5 -O3 -pipe -fsigned-char
-mabi=altivec   -L/usr/lib/fltk-1.1  -lasound -lm -ldl -lpthread -o cspctl
 cspctl.o  -lasound -lm -ldl -lpthread
cspctl.o(.toc+0xe8): undefined reference to
`__invalid_size_argument_for_IOC'
collect2: ld returned 1 exit status
make: *** [cspctl] Error 1

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-24-05 21:09 Markus Rothe   New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
