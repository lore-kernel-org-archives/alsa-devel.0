From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001126]: alsa-lib 1.0.9rc4 does not compile with debugging off (--with-debug=no)
Date: Fri, 27 May 2005 11:26:14 +0200
Message-ID: <5d13ed0040863b5d8b241ac96f0752eb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B3DA1209
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 11:26:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1126> 
======================================================================
Reported By:                amir
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1126
Category:                   general
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-25-2005 21:43 CEST
Last Modified:              05-27-2005 11:26 CEST
======================================================================
Summary:                    alsa-lib 1.0.9rc4 does not compile with debugging
off (--with-debug=no)
Description: 
alsa-lib 1.0.9rc4 does not compile with debugging turned off 
using configure flag --with-debug=no 
which causes #define NDEBUG in config.h

recent code in src/pcm/pcm_params.c added dump_hw_params()
to print debugging

but the function exists only ifndef NDEBUG
my patch causes the function to be empty (optimized out)
when NDEBUG is defined.

======================================================================

----------------------------------------------------------------------
 tiwai - 05-27-05 11:26 
----------------------------------------------------------------------
Thanks for reproting.
I'd like to rather get rid of the debug dump function than enabling
always...  Fixed on CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-05 21:43 amir           New Issue                                    
05-25-05 21:43 amir           File Added: fix-dump_hw_params.diff               
    
05-27-05 11:26 tiwai          Status                   new => resolved     
05-27-05 11:26 tiwai          Resolution               open => fixed       
05-27-05 11:26 tiwai          Assigned To               => tiwai           
05-27-05 11:26 tiwai          Note Added: 0004744                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
