From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000270]: Audigy 2 ZS side surround channels not supported
Date: Thu, 28 Oct 2004 20:41:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <196ec0991407d295d11f0fa1d264f636@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AE722290
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2004 20:41:04 +0200 (MEST)
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
Last Modified:              10-28-2004 20:41 CEST
======================================================================
Summary:                    Audigy 2 ZS side surround channels not supported
Description: 
There is no Support for the side surround channels on SB Audigy 2 ZS (
Platinum Pro ) in Alsa.

I'll try to get it work and test everything you give me to test.
======================================================================

----------------------------------------------------------------------
 lee - 10-25-04 21:36 
----------------------------------------------------------------------
Well, I wouldn't quite call the detection "buggy", it worked perfectly with
the only Audigy 2 ZS we had... unless you have a list of every possible
PCI id that would qualify.  If there is a bug it is that Creative releases
the same card with different PCI ids.

----------------------------------------------------------------------
 wraiden - 10-28-04 20:41 
----------------------------------------------------------------------
well, ok ... my card is the "Audigy 2 ZS Platinum Pro" ( thats the version
with external drive ) and i think creative is not so crazy after all
because the Platinum Pro card has more chanels to mix volume for ... after
all the PCI id for my card was 0x2001 not 0x2002 and it culd be that all
versions of the ZS have different id's ... i'm hounting for the currently
not working channels ( LineIn 2 / Digital and Analog CD [ and mybe more ]
) of my card and will post patches inside new bugreports ... btw, the
current mixer for audigy 2 ZS Platium Pro is horrible ( morst chanels are
useless ) ... i post details on demand ... i'll try to get this fixed up
along with the remaining channels

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
10-28-04 20:41 wraiden        Note Added: 0002286                          
======================================================================




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
