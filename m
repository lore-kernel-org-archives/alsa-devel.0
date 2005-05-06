From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001093]: snd-usb-audio device link is wrong
Date: Fri, 6 May 2005 23:43:55 +0200
Message-ID: <6be7161cc48830113da86d4ba13245ff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0C3F0209
	for <alsa-devel@alsa-project.org>; Fri,  6 May 2005 23:43:55 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1093> 
======================================================================
Reported By:                davidz
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1093
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora
Kernel Version:             2.6.12-rc3
======================================================================
Date Submitted:             05-06-2005 23:43 CEST
Last Modified:              05-06-2005 23:43 CEST
======================================================================
Summary:                    snd-usb-audio device link is wrong
Description: 

When using my USB Plantronics headset (which works fine), there is a minor
cosmetic bug

        [davidz <at> daxter hal]$ ls -l /sys/class/sound/pcmC2D0c/
        total 0
        -r--r--r--  1 root root 4096 Apr 29 16:57 dev
        lrwxrwxrwx  1 root root    0 Apr 29 16:57 device ->
../../../devices/pci0000:00/0000:00:1d.1/usb3/3-2
        [davidz <at> daxter hal]$ ls -l /sys/class/sound/pcmC2D0c/device/
        total 0
        drwxr-xr-x  3 root root    0 Apr 29 16:57 3-2:1.0
        drwxr-xr-x  3 root root    0 Apr 29 16:57 3-2:1.1
        drwxr-xr-x  3 root root    0 Apr 29 16:57 3-2:1.2
        drwxr-xr-x  3 root root    0 Apr 29 16:57 3-2:1.3

However,

        [davidz <at> daxter hal]$ tree
/sys/bus/usb/drivers/snd-usb-audio/
        /sys/bus/usb/drivers/snd-usb-audio/
        |-- 3-2:1.0 ->
../../../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0
        |-- 3-2:1.1 ->
../../../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.1
        |-- 3-2:1.2 ->
../../../../devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.2
        `-- module -> ../../../../module/snd_usb_audio

Thus, the 'device' symlink in /sys/class/sound/pcmC2D0c/ appears to be
wrong - it needs to point at the USB interface - not the USB device. This
is with ALSA in 2.6.12-rc3. Should be a one line fix. See also

 http://article.gmane.org/gmane.linux.hotplug.devel/7714
 http://article.gmane.org/gmane.linux.hotplug.devel/7717

Thanks,
David
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 23:43 davidz         New Issue                                    
05-06-05 23:43 davidz         Distribution              => Fedora          
05-06-05 23:43 davidz         Kernel Version            => 2.6.12-rc3      
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
