From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000014]: No sound from headphone jack on Acer27* laptops
Date: Mon, 15 May 2006 17:55:54 +0200
Message-ID: <1d84cd8db3adba39dfd7306d083cc064@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7B9AF236
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2006 17:55:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14> 
======================================================================
Reported By:                -VoltagE-
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   14
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     confirmed
Distribution:               Debian Sid updated
Kernel Version:             2.4.24-ck1
======================================================================
Date Submitted:             01-29-2004 20:15 CET
Last Modified:              05-15-2006 17:55 CEST
======================================================================
Summary:                    No sound from headphone jack on Acer27* laptops
Description: 
On my laptop (acer272xv) I can't use external output with my Creative 2.1,
because I can't hear anything.
I've tryied with other external speaker and with other releases of
alsa-driver, but there's no difference.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000664 ac97_quirk with SIS 7012 [ALC202] don't...
======================================================================

----------------------------------------------------------------------
 dale - 05-09-06 21:48 
----------------------------------------------------------------------
Hi,

I just tested this with the latest Alsa drivers (1.0.11) and the problem
still exists.  PLEASE if you can suggest anything i can do to get sound
out of my headphone port, i would be very grateful. I am willing to help
in any way.

This issue was first reported in January 2004 and there still does not
appear to be any progress made.

----------------------------------------------------------------------
 -VoltagE- - 05-15-06 17:55 
----------------------------------------------------------------------
Just want to note that I haven't issued this bug.
Could the bug owner please correct that.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-04 20:15 user74         New Issue                                    
01-29-04 20:15 user74         File Added: details.txt                      
01-30-04 12:44 tiwai          Note Added: 0000049                          
01-30-04 17:56 sparkyva       Note Added: 0000063                          
01-30-04 17:56 sparkyva       Issue Monitored: sparkyva                    
01-30-04 20:41 sparkyva       Note Added: 0000070                          
01-30-04 22:01 jorge2         Note Added: 0000071                          
02-02-04 19:37 jorge2         Note Added: 0000119                          
02-04-04 20:00 tiwai          Note Added: 0000165                          
02-04-04 20:01 tiwai          Note Added: 0000166                          
02-04-04 20:52 jorge2         Note Added: 0000169                          
02-04-04 20:52 jorge2         Note Added: 0000170                          
02-04-04 20:53 jorge2         Note Deleted: 0000169                        
02-05-04 13:52 matsgora       Note Added: 0000181                          
02-05-04 14:05 dale           Note Added: 0000182                          
02-26-04 13:07 rocco          Note Added: 0000347                          
02-26-04 18:16 matsgora       Note Added: 0000358                          
02-26-04 18:20 tiwai          Note Added: 0000359                          
03-01-04 10:31 dale           Note Added: 0000401                          
03-05-04 19:49 tiwai          Note Added: 0000513                          
03-05-04 20:37 jorge2         Note Added: 0000515                          
03-06-04 18:20 matsgora       Note Added: 0000520                          
03-07-04 16:30 dale           Note Added: 0000524                          
03-09-04 15:15 tiwai          Note Added: 0000547                          
03-09-04 18:12 matsgora       Note Added: 0000551                          
06-08-04 20:25 jorge2         Note Added: 0001296                          
06-15-04 15:00 mcbridematt    Note Added: 0001308                          
11-22-04 18:48 tiwai          Relationship added       has duplicate 0000664
02-02-05 14:25 dale           Note Added: 0003488                          
02-04-05 13:18 tiwai          Note Added: 0003504                          
02-04-05 13:19 tiwai          File Added: ac97-alc-fix.diff                    
02-04-05 18:03 jorge2         Note Added: 0003512                          
02-05-05 13:27 jorge2         Issue Monitored: jorge2                      
02-21-05 09:16 dale           Note Added: 0003678                          
02-23-05 09:54 dale           Issue Monitored: dale                        
06-14-05 21:20 graf_eichbaum  Issue Monitored: graf_eichbaum                    
06-20-05 06:48 wenton         Note Added: 0005093                          
06-22-05 19:50 dale           Note Added: 0005145                          
06-24-05 08:54 wenton         Note Added: 0005204                          
06-28-05 10:50 dale           Note Added: 0005294                          
07-07-05 18:05 graf_eichbaum  Note Added: 0005400                          
07-16-05 16:55 jdthood        Reporter                 user74 => -VoltagE- 
07-16-05 16:55 jdthood        Status                   new => confirmed    
07-16-05 16:55 jdthood        version                  1.0.2 => 1.0.8      
07-16-05 16:55 jdthood        Summary                  No sound from external
speakers (laptop) => Sound from internal speakers but not from headphones --
Acer272xv
07-16-05 16:55 jdthood        Description Updated                          
07-16-05 19:27 dale           Issue End Monitor: dale                      
07-16-05 19:28 dale           Issue Monitored: dale                        
07-17-05 13:18 jorge2         Note Added: 0005507                          
08-02-05 21:17 ignition       Issue Monitored: ignition                    
09-29-05 12:30 jdthood        Summary                  Sound from internal
speakers but not from headphones -- Acer272xv => No sound from headphone jack on
Acer27* laptops
05-09-06 21:48 dale           Note Added: 0009689                          
05-15-06 17:55 -VoltagE-      Note Added: 0009827                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
