From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000956]: mixer devices missing & no sound
Date: Tue, 31 May 2005 18:05:05 +0200
Message-ID: <b5bf6c12d30880620ec1bb755ab4321a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8D9A11B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:05:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=956> 
======================================================================
Reported By:                calebmiles
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   956
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core
Kernel Version:             2.6.10
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-02-2005 13:09 CET
Last Modified:              05-31-2005 18:05 CEST
======================================================================
Summary:                    mixer devices missing & no sound
Description: 
after compiling the 1.0.8 alsa-driver version from source or integrating it
into the kernel sourcecode and rebooting i run alsamixer and find most of
the devices in the mixer missing such as master master mono cd aux etc 
======================================================================

----------------------------------------------------------------------
 calebmiles - 03-23-05 02:25 
----------------------------------------------------------------------
no, I was using the Planet CCRMA alsa rpms, but I just recompliled the
kernel with out its built in alsa support and installed all the alsa
packages from source and things worked fine

----------------------------------------------------------------------
 jdthood - 03-23-05 09:20 
----------------------------------------------------------------------
OK, the problem appears to have arisen from version mismatch.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-02-05 13:09 calebmiles     New Issue                                    
03-02-05 13:09 calebmiles     Distribution              => Fedora Core     
03-02-05 13:09 calebmiles     Kernel Version            => 2.6.10          
03-22-05 22:26 jdthood        Note Added: 0004141                          
03-23-05 02:25 calebmiles     Note Added: 0004148                          
03-23-05 09:20 jdthood        Note Added: 0004152                          
03-23-05 09:20 jdthood        Status                   new => resolved     
03-23-05 09:20 jdthood        Resolution               open => not an issue
05-31-05 18:05 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
