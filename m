From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000601]: Getting error while trying to insert the modules into the kernel>>cannot proceede further
Date: Sun, 20 Mar 2005 13:34:04 +0100
Message-ID: <7918cdf950528e1a5b66ef16d7cf26bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 61A3F166
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 13:34:04 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=601> 
======================================================================
Reported By:                djcobra
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   601
Category:                   alsamixer
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             10-24-2004 21:16 CEST
Last Modified:              03-20-2005 13:34 CET
======================================================================
Summary:                    Getting error while trying to insert the modules
into the kernel>>cannot proceede further
Description: 
sir,
i have followed the installation instructions of the above mentioned
driver to the letter according to what is given in the link :
http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Creative+Labs&card=Sound+Blaster+PCI128+%28earlier+model+CT4700%29.&chip=ES1370&module=ens1370
but unfortunatly>>i am not able to proceed further after the step where i
am supposed to insert the modules into the keranl>>as when i try to run
the given comand :

modprobe snd-ens1370;modprobe snd-pcm-oss;modprobe snd-mixer-oss;modprobe
snd-seq-oss

i get an error : 

/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/snd-ens1370.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/snd-ens1370.o: insmod
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/snd-ens1370.o failed
/lib/modules/2.4.22-1.2115.nptl/kernel/sound/pci/snd-ens1370.o: insmod
snd-ens1370 failed


Kindly help me solve this problem so that i too can listen to wonderful
music in the eccelent quality provided by this awesome driver that u have
created
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 19:24 
----------------------------------------------------------------------
Are you sure that snd-ens1370 is the driver for your card?
The driver for SB Live is usually snd-emu10k1.

----------------------------------------------------------------------
 jdthood - 03-20-05 13:30 
----------------------------------------------------------------------
This can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-24-04 21:16 djcobra        New Issue                                    
10-26-04 22:19 djcobra        Issue Monitored: djcobra                     
11-09-04 19:24 tiwai          Note Added: 0002347                          
03-20-05 13:30 jdthood        Note Added: 0004086                          
03-20-05 13:34 perex          Status                   new => resolved     
03-20-05 13:34 perex          Resolution               open => suspended   
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
