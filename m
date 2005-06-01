From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001094]: nforce4 - optical spdif out not working
Date: Wed, 1 Jun 2005 09:24:32 +0200
Message-ID: <07592cb57d746ceac9b9b981290fcf0b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DCA53178
	for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2005 09:24:32 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1094> 
======================================================================
Reported By:                eklarson
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1094
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14_FC3
======================================================================
Date Submitted:             05-07-2005 11:36 CEST
Last Modified:              06-01-2005 09:24 CEST
======================================================================
Summary:                    nforce4 - optical spdif out not working
Description: 
A 48K PCM optical signal is getting sent out to my receiver, however I
can't get anything to play.  I saw in the "intel8x0.c" that there is no
NFORCE4 callouts.  Does the code fully support the nforce4 yet?
======================================================================

----------------------------------------------------------------------
 jaskjok - 05-31-05 21:11 
----------------------------------------------------------------------
gergap: good for you, but i think this bugreport was for nforce4 chipset,
my
Asus A8N SLI deluxe coaxial digital out is unfortunately still dead silent
with 1.0.9 alsa :(



----------------------------------------------------------------------
 eklarson - 06-01-05 09:24 
----------------------------------------------------------------------
I compiled everything from the cvs source (1.0.9) and had no luck.  I
wonder how extensive this fix will be.  The code clearly has no mention of
nforce4...  I can't wait get mythTV pumping the AC3 through the optical
out.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
