From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002212]: alsa.pc's Libs shouldn't contain
	-lm -ldl -lpthread
Date: Fri, 16 Jun 2006 20:08:41 +0200
Message-ID: <3fecf5538107579e5fb5b2c573adbac7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3792F14B
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jun 2006 20:08:41 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2212> 
======================================================================
Reported By:                samuelthibault
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2212
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-16-2006 20:08 CEST
Last Modified:              06-16-2006 20:08 CEST
======================================================================
Summary:                    alsa.pc's Libs shouldn't contain -lm -ldl -lpthread
Description: 
Hi,

There are spurious dependencies in alsa.pc:

alsa.pc:Libs: -L${libdir} -lasound -lm -ldl -lpthread

-lm -ldl -lpthread are _not_ needed in Libs (since the alsa interface
doesn't depend on libm, libdl or libpthread interface) and just bring
unneeded dependencies. These should rather be put in Libs.private:

Libs: -L${libdir} -lasound
Libs.private: -lm -ldl -lpthread

(so that static compiling still works).

Samuel

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-06 20:08 samuelthibault New Issue                                    
======================================================================
