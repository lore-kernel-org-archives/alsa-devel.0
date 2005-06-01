From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001094]: nforce4 - optical spdif out not working
Date: Wed, 1 Jun 2005 16:54:06 +0200
Message-ID: <7e77b9986460b47c3b90e1aaf3e56193@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1AF3917C
	for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2005 16:54:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1094> 
======================================================================
Reported By:                eklarson
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1094
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14_FC3
Resolution:                 duplicate
Duplicate:                  1083
Fixed in Version:           
======================================================================
Date Submitted:             05-07-2005 11:36 CEST
Last Modified:              06-01-2005 16:54 CEST
======================================================================
Summary:                    nforce4 - optical spdif out not working
Description: 
A 48K PCM optical signal is getting sent out to my receiver, however I
can't get anything to play.  I saw in the "intel8x0.c" that there is no
NFORCE4 callouts.  Does the code fully support the nforce4 yet?
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001083 NVIDIA CK8 ALC655 SPDIF passthrough
======================================================================

----------------------------------------------------------------------
 eklarson - 06-01-05 09:24 
----------------------------------------------------------------------
I compiled everything from the cvs source (1.0.9) and had no luck.  I
wonder how extensive this fix will be.  The code clearly has no mention of
nforce4...  I can't wait get mythTV pumping the AC3 through the optical
out.

----------------------------------------------------------------------
 tiwai - 06-01-05 16:51 
----------------------------------------------------------------------
SPDIF on Nforce doesn't work properly.  No technical information to support
it, unfortunately.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-05 11:36 eklarson       New Issue                                    
05-07-05 11:36 eklarson       Distribution              => Fedora Core 3   
05-07-05 11:36 eklarson       Kernel Version            => 2.6.11-1.14_FC3 
05-07-05 11:41 eklarson       Note Added: 0004604                          
05-07-05 23:44 eklarson       Note Edited: 0004604                         
05-09-05 09:56 gergap         Note Added: 0004622                          
05-28-05 09:55 jaskjok        Note Added: 0004760                          
05-30-05 09:33 gergap         Note Added: 0004796                          
05-31-05 21:10 jaskjok        Note Added: 0004855                          
05-31-05 21:11 jaskjok        Note Edited: 0004855                         
06-01-05 09:24 eklarson       Note Added: 0004857                          
06-01-05 16:51 tiwai          Note Added: 0004860                          
06-01-05 16:54 tiwai          Relationship added       duplicate of 0001083
06-01-05 16:54 tiwai          Duplicate ID             0 => 1083           
06-01-05 16:54 tiwai          Status                   new => resolved     
06-01-05 16:54 tiwai          Resolution               open => duplicate   
06-01-05 16:54 tiwai          Assigned To               => tiwai           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
