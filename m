From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002207]: Arecord listing 2 MICs whereas
	i have only one MIC
Date: Thu, 29 Jun 2006 18:38:12 +0200
Message-ID: <e36bf15080053c76dc07eef8298ec03e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2E822A0
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 18:38:12 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2207> 
======================================================================
Reported By:                paragn
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   2207
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             06-14-2006 06:41 CEST
Last Modified:              06-29-2006 18:38 CEST
======================================================================
Summary:                    Arecord listing 2 MICs whereas i have only one MIC
Description: 
Hi,        
      Why am i seeing 2 mics in arecord -l  output?? i checked on Dell
Precision Workstation 370 as well as on IBM R52 laptop and found 2 mic
listed there why??
For Dell machine check=>
http://supportapj.dell.com/support/edocs/systems/ws370/en/ug/index.htm

      Also Alsamixer utility giving me 2 mic and mic selection. But i know
i have only one mic on both systems. I have on DELL RHEL4 with all ALSA
1.0.11 packages and on IBM laptop FC5 with all latest ALSA packages 1.0.11
======================================================================

----------------------------------------------------------------------
 tiwai - 06-29-06 18:38 
----------------------------------------------------------------------
Because the driver cannot know whether the system has really one mic or two
mics.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-06 06:41 paragn         New Issue                                    
06-14-06 06:41 paragn         File Added: ALSAlog.tar.gz                    
06-29-06 18:38 tiwai          Status                   new => resolved     
06-29-06 18:38 tiwai          Resolution               open => won't fix   
06-29-06 18:38 tiwai          Assigned To               => tiwai           
06-29-06 18:38 tiwai          Note Added: 0010689                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
