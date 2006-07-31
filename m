From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000324]: Audigy2 Platinum: very low
	volume (both in and out)
Date: Tue, 1 Aug 2006 01:28:55 +0200
Message-ID: <79aa98c3170fad8a75405cd307fa8754@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE0E8166
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 01:28:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=324> 
======================================================================
Reported By:                garden
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   324
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Debian sid
Kernel Version:             2.6.5
======================================================================
Date Submitted:             06-06-2004 13:17 CEST
Last Modified:              08-01-2006 01:28 CEST
======================================================================
Summary:                    Audigy2 Platinum: very low volume (both in and out)
Description: 
Both the input and output levels of my Audigy2 Platinum seem to be very low
if compared to the same card with Windows (win98se). For example, I
connected an external source (a MD player with very loud music in the
disc) to the optical input, then to the aux input, then to the aux2 input.
With the mixer settings to 100% the input level still does not go over
20-25% of the maximum amplitude (while with Windows I have to lower the
input level or it will be too high). The same thing applies to the output
level of my analog speakers. [I must be *very* careful when I reboot with
Windows and must not forget to turn the volume knob from 10 to 2]. I had
exactly the same problem when I used the emu10k1 drivers from sourceforge.
======================================================================

----------------------------------------------------------------------
 snover - 07-30-06 20:12 
----------------------------------------------------------------------
Hi jcdutton,

After some experimentation and cursing I'm afraid I probably will not be
able to build this patch to test for you. I will attempt to shake out some
people downstream with a bit more experience that might be able to do it
instead.

The reason for my inability to do this is that patches in the HG SCM
repository are failing against the copy of alsa-kernel that comes with my
OS (AMD64 Ubuntu 6.06). Unfortunately, I don't feel I have the expertise
to resolve this issue and I don't have enough time to gain the knowledge
required to fix it (unless it's something that you can instruct me to
do).

For your knowledge, here is the failure that is currently occurring:

Hacking autoconf.h...
if [ ! -d include/sound -a ! -L include/sound ]; then \
          ln -sf ../alsa-kernel/include include/sound ; \
        fi
cp -auvf include/version.h include/sound/version.h
`include/version.h' -> `include/sound/version.h'
make[1]: Entering directory
`/home/colin/software/source/modules/alsa-driver/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #3 succeeded at 122 with fuzz 1.
Hunk #7 succeeded at 484 with fuzz 1 (offset 11 lines).
Hunk #8 FAILED at 520.
Hunk #9 succeeded at 949 (offset 13 lines).
Hunk #10 succeeded at 997 with fuzz 2 (offset 12 lines).
1 out of 10 hunks FAILED -- saving rejects to file info.c.rej
make[1]: *** [info.c] Error 1
make[1]: Leaving directory
`/home/colin/software/source/modules/alsa-driver/acore'
make: *** [dep] Error 1

I prepared the source by downloading the alsa-source package provided by
Ubuntu and untarring it, then by pulling the latest sources from the HG
SCM repository and overwriting the older files from the alsa-source
package. I also tried downloading a fresh copy of the HG SCM repository
and copied over ONLY the alsa-kernel directory, and it still failed.

Again, I will try to find someone downstream to test this patch. Hopefully
someone with a bit more experience will able to do so.

Regards,

----------------------------------------------------------------------
 rlrevell - 08-01-06 01:28 
----------------------------------------------------------------------
Just don't use the Ubuntu ALSA packages, they are hacked up.  Get
everything from the HG repository, and just install it over the Ubuntu
ALSA.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-04 13:17 garden         New Issue                                    
06-06-04 13:17 garden         Distribution              => Debian sid      
06-06-04 13:17 garden         Kernel Version            => 2.6.5           
06-28-04 09:17 pzad           Status                   new => assigned     
06-28-04 09:17 pzad           Assigned To               => pzad            
09-14-04 15:24 garden         Note Added: 0001758                          
09-16-04 10:16 pzad           Note Added: 0001766                          
09-16-04 11:32 garden         File Added: amixer.out                       
09-16-04 11:37 garden         Note Added: 0001769                          
09-16-04 12:17 pzad           Note Added: 0001772                          
09-16-04 13:23 garden         Note Added: 0001773                          
08-30-05 12:23 jdthood        Note Added: 0005975                          
08-30-05 12:32 garden         Note Added: 0005978                          
08-30-05 20:21 rlrevell       Note Added: 0005981                          
08-31-05 14:01 pzad           Note Added: 0005988                          
08-31-05 18:54 rlrevell       Note Added: 0005990                          
01-26-06 21:52 pzad           Note Added: 0007789                          
01-26-06 21:55 rlrevell       Note Added: 0007790                          
01-26-06 22:03 pzad           Note Added: 0007791                          
01-28-06 23:11 andred         Issue Monitored: andred                      
06-19-06 16:33 killrbuckeye   Note Added: 0010316                          
06-19-06 16:34 killrbuckeye   Issue Monitored: killrbuckeye                    
06-21-06 23:18 snover         Note Added: 0010409                          
06-21-06 23:19 snover         Issue Monitored: snover                      
06-21-06 23:19 snover         Note Edited: 0010409                         
06-30-06 16:32 killrbuckeye   Note Added: 0010739                          
06-30-06 16:34 pzad           Assigned To              pzad =>             
06-30-06 18:22 jcdutton       Note Added: 0010750                          
06-30-06 18:23 jcdutton       Assigned To               => jcdutton        
07-06-06 07:39 L0cKd0wN       Note Added: 0010855                          
07-06-06 07:40 L0cKd0wN       Note Edited: 0010855                         
07-06-06 07:40 L0cKd0wN       Issue Monitored: L0cKd0wN                    
07-09-06 17:38 jcdutton       File Added: capture-fix.diff                    
07-09-06 17:39 jcdutton       Note Added: 0010953                          
07-09-06 17:42 jcdutton       Note Added: 0010954                          
07-09-06 17:42 jcdutton       Status                   assigned => feedback
07-13-06 23:17 killrbuckeye   Note Added: 0010996                          
07-15-06 00:26 snover         Note Added: 0011010                          
07-15-06 00:27 snover         Note Edited: 0011010                         
07-30-06 18:31 jcdutton       Note Added: 0011326                          
07-30-06 20:12 snover         Note Added: 0011329                          
08-01-06 01:28 rlrevell       Note Added: 0011357                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
