From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002035]: Realtek 861 card not
	functional using included alsa drivers
Date: Tue, 1 Aug 2006 00:45:11 +0200
Message-ID: <5ad1709209d26f707d84a19b88edb5bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5F9121B
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 00:45:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2035> 
======================================================================
Reported By:                vertex
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2035
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2080_FC5smp
======================================================================
Date Submitted:             04-18-2006 20:00 CEST
Last Modified:              08-01-2006 00:45 CEST
======================================================================
Summary:                    Realtek 861 card not functional using included alsa
drivers
Description: 
I am using the FC5 drivers to begin with.  The packages are labeled version
1.0.11rc2.  There are only a few options when I run alsamixer. Using the
stock drivers, I have these options:

Headphone switch
CD level
Mic level
Input Source switch(Mic/CD)

I compiled the 1.0.11rc5 drivers from source and rebooted. I now have
these channels when I run alsamixer:

Front switch
CD level
Mic level
Input Source switch(Mic/CD)

I tried compiling the 1.0.9 drivers from Realtek's website(said nothing
about the 861), but they did not build.  In fact, the install script
overwrote my asound libraries requiring a package replacement to get back
to a sane state.

Please let me know if there is something more I can provide.
======================================================================

----------------------------------------------------------------------
 vertex - 07-31-06 21:34 
----------------------------------------------------------------------
I got was able to cleanly apply the patch to the mentioned 1.0.9* version
of the alsa driver package. Of course this alsa driver version won't
compile against any modern kernels. Using FC3 or SuSE 9.3 is not an
acceptable solution for me so I haven't bothered with it any more. I
assume someone would need add the 861 specific portions of the patched
driver code to a recent version and then update the code to include
whatever api changes came about with newer kernels. Its a shame that
people making money on the alsa project sat on this patch instead of
sharing it with the community like they are supposed to have. If this made
it into alsa at 1.0.9, the updated portions would have been updated with
the next version change. Looks like none of the developers really care
about users with this problem. I have 3 machines with this audio chipset
and they are worthless to me as multimedia machines. What the hell do I
have to do to get a developer to help?

----------------------------------------------------------------------
 pwaller - 08-01-06 00:45 
----------------------------------------------------------------------
So it is possible to get it working but someone needs to port the patches
so that it functions with 2.6.x, yeah? :s

If anyone hears this plea, how long might this take? Life without sound is
agony.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-06 20:00 vertex         New Issue                                    
04-18-06 20:00 vertex         Distribution              => Fedora Core 5   
04-18-06 20:00 vertex         Kernel Version            => 2.6.16-1.2080_FC5smp
04-18-06 20:09 rlrevell       Note Added: 0009339                          
04-18-06 20:25 pzad           Note Added: 0009340                          
04-18-06 20:40 vertex         Note Added: 0009342                          
04-18-06 20:50 vertex         Note Added: 0009343                          
04-18-06 22:25 rlrevell       Note Added: 0009345                          
04-18-06 22:32 vertex         Note Added: 0009346                          
04-18-06 22:45 rlrevell       Note Added: 0009347                          
04-18-06 23:02 vertex         Note Added: 0009348                          
04-20-06 14:41 tiwai          Note Added: 0009375                          
04-20-06 20:21 vertex         File Added: modprobe.hda.intel.txt                
   
04-20-06 20:22 vertex         File Added: codec0.during.playback                
   
04-20-06 20:23 vertex         Note Added: 0009398                          
04-21-06 16:50 tiwai          Note Added: 0009416                          
04-21-06 16:51 tiwai          Note Added: 0009417                          
04-21-06 16:54 tiwai          Note Added: 0009418                          
04-21-06 18:56 vertex         Note Added: 0009428                          
04-26-06 00:37 vertex         Note Added: 0009499                          
05-11-06 00:44 vertex         Note Added: 0009755                          
05-11-06 00:46 vertex         File Added: dmesg.debug.txt                    
05-11-06 00:47 vertex         File Added: codec0.noplayback.new                 
  
05-29-06 23:33 taschenorakel  Note Added: 0010015                          
05-30-06 19:11 vertex         Note Added: 0010021                          
05-31-06 20:20 taschenorakel  Note Added: 0010028                          
05-31-06 21:02 vertex         Note Added: 0010029                          
05-31-06 21:06 vertex         Note Added: 0010030                          
05-31-06 22:43 rlrevell       Note Added: 0010032                          
05-31-06 22:51 rlrevell       Note Added: 0010033                          
05-31-06 23:23 vertex         Note Added: 0010035                          
06-01-06 00:30 taschenorakel  Note Added: 0010036                          
06-10-06 14:04 taschenorakel  Note Added: 0010146                          
06-11-06 11:56 jlpedrosa      Note Added: 0010151                          
06-12-06 18:22 jlpedrosa      Note Edited: 0010151                         
06-13-06 11:32 jlpedrosa      Note Added: 0010191                          
06-13-06 14:18 jlpedrosa      Note Edited: 0010191                         
06-19-06 14:00 jlpedrosa      Note Added: 0010311                          
06-20-06 17:45 legoguy        Issue Monitored: legoguy                     
06-22-06 21:41 vertex         Note Added: 0010429                          
06-22-06 22:25 taschenorakel  File Added: alsa-driver-1.0.9b_24a.diff.bz2       
            
06-22-06 22:28 taschenorakel  Note Added: 0010430                          
06-22-06 22:50 taschenorakel  File Added:
alsa-driver-1.0.9b_24a-with-symbols.diff.bz2                    
06-26-06 13:25 jlpedrosa      Note Added: 0010532                          
06-26-06 16:38 rlrevell       Note Added: 0010548                          
06-27-06 16:09 jlpedrosa      Note Added: 0010595                          
07-29-06 04:04 pwaller        Note Added: 0011296                          
07-29-06 04:04 pwaller        Issue Monitored: pwaller                     
07-31-06 21:34 vertex         Note Added: 0011349                          
08-01-06 00:45 pwaller        Note Added: 0011355                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
