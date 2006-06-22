From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002221]: Volume entirely too faint on
	82801g ich7
Date: Thu, 22 Jun 2006 09:00:41 +0200
Message-ID: <8adde61c192c2460db59fa2ee8968608@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A0F6021B
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jun 2006 09:00:41 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2221> 
======================================================================
Reported By:                mlfarrell
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2221
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Suse 10.1
Kernel Version:             2.6.16.13-4-smp
======================================================================
Date Submitted:             06-19-2006 02:19 CEST
Last Modified:              06-22-2006 09:00 CEST
======================================================================
Summary:                    Volume entirely too faint on 82801g ich7
Description: 
I've seen this bug online many times with a resolution of upgrading to alsa
1.0.11, but I upgaded and am still having the issue.

I'm using an hp pavilion dv8000 laptop with built-in altec lansing
speakers.

Windows reports the soundcard as conexant high definition audio, linux as
82801g (ich7).  I've tried setting every model I know in the
/etc/modprobe.d/sound file for the hda-intel driver and am still having a
lack of useful volume sliders.  The key ones that I need are "pc speaker"
to turn it down cause its way too loud and "external amplifier" to turn up
the laptop's altec lansing speakers (sound volume is decent out of the
headphone jack).

Even with the volume all the way up (both master and pcm) I'm getting
sound thats almost too faint to hear.  


======================================================================

----------------------------------------------------------------------
 nellson - 06-22-06 08:34 
----------------------------------------------------------------------
FWIW: I have an HP dv8000t, same issue, so i opened a support case with HP
to see if they will help. I have had a few Linux friendly techs in the
past.. 

Nick

----------------------------------------------------------------------
 nellson - 06-22-06 09:00 
----------------------------------------------------------------------
Well, that was fast and fruitless...

Thank you for contacting HP Total Care.

HP does not recommend that customers install Linux on their Pavilion
notebooks; however, we understand that some customers may wish to change
operating systems for their personal needs.  HP does not support Linux
on any models of HP Pavilion PCs at this time.  Information about Linux
can be located at the following Web site:

http://h10018.www1.hp.com/wwsolutions/linux/index.html

HP pre-installed the latest version of the Microsoft Windows operating
System (98, Me, XP) on your Pavilion PC.  The Warranty on your Pavilion
system does not apply to software not provided by HP and does not apply
to defects or errors in hardware resulting from software not provided by
HP with that system.  Please review your PC documentation to identify
the supported operating system.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-19-06 02:19 mlfarrell      New Issue                                    
06-19-06 02:19 mlfarrell      Distribution              => Suse 10.1       
06-19-06 02:19 mlfarrell      Kernel Version            => 2.6.16.13-4-smp 
06-19-06 21:59 mlfarrell      Issue Monitored: mlfarrell                    
06-20-06 19:49 tiwai          Note Added: 0010347                          
06-20-06 23:38 mlfarrell      Note Added: 0010358                          
06-20-06 23:42 rlrevell       Note Added: 0010360                          
06-21-06 00:46 mlfarrell      Note Added: 0010368                          
06-21-06 00:58 rlrevell       Note Added: 0010371                          
06-21-06 01:06 mlfarrell      Note Added: 0010372                          
06-21-06 01:23 rlrevell       Note Added: 0010373                          
06-22-06 05:01 mlfarrell      Note Added: 0010414                          
06-22-06 05:38 rlrevell       Note Added: 0010416                          
06-22-06 08:34 nellson        Note Added: 0010418                          
06-22-06 09:00 nellson        Note Added: 0010419                          
======================================================================



All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
