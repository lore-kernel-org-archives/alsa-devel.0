From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000270]: Audigy 2 ZS side surround channels not supported
Date: Mon, 25 Oct 2004 21:36:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5e954368be121cb51011772f34c75325@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5B0811D9
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2004 21:36:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=270> 
======================================================================
Reported By:                wraiden
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   270
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               LFS
Kernel Version:             2.6.9-mm1
======================================================================
Date Submitted:             05-11-2004 11:14 CEST
Last Modified:              10-25-2004 21:36 CEST
======================================================================
Summary:                    Audigy 2 ZS side surround channels not supported
Description: 
There is no Support for the side surround channels on SB Audigy 2 ZS (
Platinum Pro ) in Alsa.

I'll try to get it work and test everything you give me to test.
======================================================================

----------------------------------------------------------------------
 wraiden - 10-25-04 13:20 
----------------------------------------------------------------------
Detection is buggy ... there are other versions of this card using other
id's  out there

attached is a fix for my european version of Audigy 2 ZS Platinum Pro

please apply

----------------------------------------------------------------------
 lee - 10-25-04 21:36 
----------------------------------------------------------------------
Well, I wouldn't quite call the detection "buggy", it worked perfectly with
the only Audigy 2 ZS we had... unless you have a list of every possible
PCI id that would qualify.  If there is a bug it is that Creative releases
the same card with different PCI ids.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-04 11:14 wraiden        New Issue                                    
05-11-04 11:14 wraiden        Distribution              => LFS             
05-11-04 11:14 wraiden        Kernel Version            => 2.6.5           
05-11-04 14:41 pzad           Note Added: 0001084                          
05-21-04 16:15 wraiden        File Added: wraiden-alsa-emu10k1-side.patch       
            
05-21-04 16:21 wraiden        Note Added: 0001166                          
05-24-04 09:21 pzad           Note Added: 0001181                          
05-24-04 16:18 wraiden        Note Added: 0001188                          
05-31-04 08:32 pzad           File Added: audigy2zs_driver.diff                 
  
05-31-04 08:38 pzad           Note Added: 0001281                          
06-10-04 22:48 bryanhundven   Note Added: 0001298                          
06-15-04 15:56 wraiden        Note Added: 0001309                          
06-15-04 16:41 pzad           Note Added: 0001310                          
06-15-04 19:44 wraiden        Note Added: 0001311                          
06-15-04 19:55 wraiden        Note Edited: 0001311                         
06-22-04 13:00 pzad           Note Added: 0001328                          
06-22-04 16:39 elklein        Note Added: 0001329                          
06-27-04 22:00 wraiden        Note Added: 0001341                          
06-27-04 22:53 jcdutton       Note Added: 0001342                          
07-30-04 12:46 BiO            Issue Monitored: BiO                         
07-30-04 12:47 BiO            Issue End Monitor: BiO                       
08-27-04 20:20 jcdutton       Status                   new => closed       
08-27-04 20:20 jcdutton       Note Added: 0001656                          
10-25-04 13:20 wraiden        Kernel Version           2.6.5 => 2.6.9-mm1  
10-25-04 13:20 wraiden        Status                   closed => feedback  
10-25-04 13:20 wraiden        Resolution               open => reopened    
10-25-04 13:20 wraiden        Note Added: 0002261                          
10-25-04 13:21 wraiden        File Added: alsa-audigy2zs-detection-fix.patch    
               
10-25-04 21:36 lee            Note Added: 0002262                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
