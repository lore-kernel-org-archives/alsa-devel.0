From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000601]: Getting error while trying to insert the modules into the kernel>>cannot proceede further
Date: Sun, 24 Oct 2004 21:16:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <282ca00fe6440c8f2aa897208bb11f90@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 497B7274
	for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2004 21:16:30 +0200 (MEST)
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
Status:                     new
======================================================================
Date Submitted:             10-24-2004 21:16 CEST
Last Modified:              10-24-2004 21:16 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-24-04 21:16 djcobra        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
