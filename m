From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000607]: "rawusb" aka hwdep_pcm patch for snd-usb-usx2y >= 0.8.6
Date: Tue, 26 Oct 2004 21:39:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5b5e338ad191d30aa18e25e77f6a5a44@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 791F32A2
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2004 21:39:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=607> 
======================================================================
Reported By:                karsten
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   607
Category:                   USB - usb-usx2y
Reproducibility:            sometimes
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-26-2004 21:36 CEST
Last Modified:              10-26-2004 21:39 CEST
======================================================================
Summary:                    "rawusb" aka hwdep_pcm patch for snd-usb-usx2y >=
0.8.6
Description: 
Its usb's unableness to atomically handle power of 2 period sized data
chuncs,
what led to: 
This usx2y-alsa-jack driver pair uses a hardware dependant alsa-device for

mmaped pcm transport.
Advantage achieved:
        The usb_hcd places reads/writes pcm data into dma-memory.
        That memory is  mmaped by jack's usx2y driver.
        Jack's usx2y driver is the first/last to read/write pcm data.
        Read/write is a combination of power of 2 period shaping and
        float/int conversation.
        Compared to mainline alsa/jack we leave out power of 2 period
shaping inside
        snd-usb-* which needs memcpy() and additional buffers.
        As a side effect possible unwanted pcm-data coruption resulting of
        plain alsa's snd-usb-usx2y period shaping scheme falls away.
        Result is sane jack operation at buffering schemes down to
128frames,
        2 periods.
        plain usx2y alsa mode is able to achieve 64frames, 4periods, but
only at the
        cost of easier triggered i.e. aeolus xruns (128 or 256frames,
        2periods works but is useless cause of crackling).

New functionality would possibly be better integrated into mainlines at
more 
apropriate places.
Target could be: jack mmaping power of 2 period sized float-pcm buffers
and 
letting alsa (snd-usb-lib - alsa-lib - plugin) do power of 2 period
shaping 
and float/int conversation.

======================================================================

----------------------------------------------------------------------
 karsten - 10-26-04 21:39 
----------------------------------------------------------------------
uploaded snd-usb-usx2y.patch.0.8.6+hwdep_pcm.bz2 for use with alsa-kernel
cvs head.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 21:36 karsten        New Issue                                    
10-26-04 21:36 karsten        File Added:
snd-usb-usx2y.patch.0.8.6+hwdep_pcm.bz2                    
10-26-04 21:39 karsten        Note Added: 0002265                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
