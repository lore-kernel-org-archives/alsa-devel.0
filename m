From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001093]: snd-usb-audio device link is wrong
Date: Tue, 10 May 2005 16:07:07 +0200
Message-ID: <c2aec24325e0ad96458904504c37ecf0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 86BD0301
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 16:07:07 +0200 (MEST)
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
Status:                     resolved
Distribution:               Fedora
Kernel Version:             2.6.12-rc3
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-06-2005 23:43 CEST
Last Modified:              05-10-2005 16:07 CEST
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

----------------------------------------------------------------------
 Clemens Ladisch - 05-10-05 16:07 
----------------------------------------------------------------------
Now fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 23:43 davidz         New Issue                                    
05-06-05 23:43 davidz         Distribution              => Fedora          
05-06-05 23:43 davidz         Kernel Version            => 2.6.12-rc3      
05-10-05 16:07 Clemens LadischStatus                   assigned => resolved
05-10-05 16:07 Clemens LadischResolution               open => fixed       
05-10-05 16:07 Clemens LadischNote Added: 0004634                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
