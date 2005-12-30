From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001066]: autodetection fails
Date: Fri, 30 Dec 2005 19:38:46 +0100
Message-ID: <b445401d067dd63790d23fae5ebf6670@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2313F178
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 19:38:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1066> 
======================================================================
Reported By:                El Santo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1066
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               linux from scratch
Kernel Version:             2.6.11.7
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-19-2005 08:54 CEST
Last Modified:              12-30-2005 19:38 CET
======================================================================
Summary:                    autodetection fails
Description: 
i own a asus a8v (kt800pro) deluxe motherboard. it has a realtec alc850
ac97 codec....

i though this codec was supported

when i load the snd-via82xx dont detect it... and none of the alsa modules
say anything... not in screen, not kernel messages (dmesg), neither in
/var/log/*...

i have a bt878 tv card (bttv works perfectly) and snd-bt87x have the same
problem that snd-via82xx... doesnt identify the card... but at least i can
manually set the boot_all parameter....
this tv card was correctly detected with my last motherboard asus a7v-600
(kt600)

i alsa tried to build alsa into the kernel (not like modules), but i get
the same results

any idea?
======================================================================

----------------------------------------------------------------------
 El Santo - 12-30-05 14:13 
----------------------------------------------------------------------
ASUS response was that onboard sound is disabled when a pci sound card is
present due to chipset's limitations.... They said that is a chipset
limitation not a bios limitation (or "feature"). Personally i dont belive
that.

Finally, i gave up and removed the maxi sound isis and installed in
another machine.



----------------------------------------------------------------------
 rlrevell - 12-30-05 19:38 
----------------------------------------------------------------------
That's unfortunate.  Closed -> broken hardware.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-05 08:54 El Santo       New Issue                                    
04-19-05 08:54 El Santo       Distribution              => linux from scratch
04-19-05 08:54 El Santo       Kernel Version            => 2.6.11.7        
04-19-05 17:25 tiwai          Note Added: 0004520                          
04-20-05 20:28 El Santo       Note Added: 0004544                          
04-20-05 20:29 El Santo       File Added: lspci-vv                         
04-22-05 19:18 vsu            Note Added: 0004555                          
04-22-05 21:28 El Santo       Note Added: 0004557                          
04-22-05 21:32 rlrevell       Note Added: 0004558                          
04-22-05 21:55 El Santo       Note Added: 0004559                          
04-22-05 22:00 rlrevell       Note Added: 0004560                          
04-22-05 22:06 El Santo       Note Added: 0004561                          
12-30-05 04:42 rlrevell       Note Added: 0007220                          
12-30-05 13:35 El Santo       Note Added: 0007249                          
12-30-05 14:13 El Santo       Note Edited: 0007249                         
12-30-05 19:38 rlrevell       Status                   new => closed       
12-30-05 19:38 rlrevell       Note Added: 0007250                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
