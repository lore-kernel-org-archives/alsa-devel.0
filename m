From: noreply@alsa-project.org
Subject: [ALSA - driver 0000376]: inserting maestro3 hangs system
Date: Thu, 15 Jul 2004 19:40:50 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040715174050.1D3BE19009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 753821EB
	for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2004 19:40:50 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000376
======================================================================
Reported By:                tmarble
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     376
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-11-2004 18:30 CEST
Last Modified:              07-15-2004 19:40 CEST
======================================================================
Summary:                    inserting maestro3 hangs system
Description: 
modprobe snd-maestro3 consistently hangs the system.
======================================================================

----------------------------------------------------------------------
 tmarble - 07-13-2004 07:43 CEST 
----------------------------------------------------------------------
The attached files were created as follows:

# cp /usr/src/kernel-source-2.4.26/.config  
/data/debian/alsa/2.4.26-tm2.config.txt
# cp /boot/System.map-2.4.26-tm2
/data/debian/alsa/System.map-2.4.26-tm2.txt
# cp /etc/alsa/modutils/1.0 /data/debian/alsa/alsa-1.0.conf
# depmod -a -v -u -e -F /boot/System.map-2.4.26-tm2 >
/data/debian/alsa/depmod.txt
# modprobe -n -v snd-maestro3 safemode=1 > /data/debian/alsa/depends.txt
# modprobe -v snd safemode=1
# modprobe -v snd-ac97-codec safemode=1
# modprobe -v snd-page-alloc safemode=1
# modprobe -v snd-timer safemode=1
# modprobe -v snd-pcm safemode=1
# modprobe -v snd-maestro3 safemode=1

PCI: Found IRQ 5 for device 02:03.0              
maestro3: enabled hack for 'Dell Inspiron 8100'  

-- hangs -- no other messages on console --

-- following reboot --

# cd /var/log/ksymoops
# cp 20040712233907.ksyms /data/debian/alsa/20040712233907.ksyms.txt
# cp 20040712233907.modules /data/debian/alsa/20040712233907.modules.txt

If there is additional debugging information I can provide please
let me know.

--Tom

----------------------------------------------------------------------
 tiwai - 07-15-2004 11:25 CEST 
----------------------------------------------------------------------
Could you check which ALSA version worked for you with the
same kernel?
I don't remember so many changes to this driver...

----------------------------------------------------------------------
 tmarble - 07-15-2004 19:40 CEST 
----------------------------------------------------------------------
I actually think that I had 1.0.4 working on 2.4.26... but it's been
long enough that I don't have accurate records.

Instead of using my custom kernel I have also tried the pre-built
debian kernel (2.4.26) and alsa-modules (1.0.5a) and they fail
the same way.

I also tried to rebuild my kernel so that soundcore was a loadable
module, but that didn't help.

My current thinking is that either there is some inherent
breakage in the 1.0.5+ driver OR it has to do with my module
configuration OR it has to do with something in the 2.4.26 kernel
(with debian patches) that recently changed.

My next step is to install a stock 2.6.7 kernel from scratch
with the pre-build (latest) alsa-modules and see if that works.
I'll let you know.

--Tom

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-11-04 18:30 tmarble        New Bug                                      
07-11-04 18:30 tmarble        Distribution              => Debian unstable 
07-11-04 18:30 tmarble        Kernel Version            => 2.4.26          
07-13-04 07:37 tmarble        File Added: 2.4.26-tm2.config.txt                    
07-13-04 07:38 tmarble        File Added: System.map-2.4.26-tm2.txt                    
07-13-04 07:38 tmarble        File Added: alsa-1.0.conf                    
07-13-04 07:39 tmarble        File Added: depmod.txt                       
07-13-04 07:40 tmarble        File Added: depends.txt                      
07-13-04 07:41 tmarble        File Added: 20040712233907.modules.txt                    
07-13-04 07:41 tmarble        File Added: 20040712233907.ksyms.txt                    
07-13-04 07:43 tmarble        Bugnote Added: 0001412                       
07-15-04 11:25 tiwai          Bugnote Added: 0001428                       
07-15-04 19:40 tmarble        Bugnote Added: 0001437                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
