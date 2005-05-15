From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001112]: ad1816a based card with id "ADS7180" not detected
Date: Sun, 15 May 2005 08:41:37 +0200
Message-ID: <1cbcefaf4f9dadcd1a3a72188ae0e1b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D40D932F
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2005 08:41:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1112> 
======================================================================
Reported By:                sonne000ca
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1112
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-15-2005 08:41 CEST
Last Modified:              05-15-2005 08:41 CEST
======================================================================
Summary:                    ad1816a based card with id "ADS7180" not detected
Description: 
To fix, add:
{ .id = "ADS7180", .devs = { { .id = "ADS7180" }, { .id = "ADS7181" } }
},
to snd_ad1816a_pnpids[] in ad1816a,c


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-15-05 08:41 sonne000ca     New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
