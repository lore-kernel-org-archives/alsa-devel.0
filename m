From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000607]: "rawusb" aka hwdep_pcm patch for snd-usb-usx2y >= 0.8.6
Date: Fri, 10 Dec 2004 23:49:55 +0100
Message-ID: <b403854b2f6906873afc50af72bf04b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 88A102FC
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2004 23:49:55 +0100 (MET)
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
Last Modified:              12-10-2004 23:49 CET
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
 tiwai - 12-03-04 14:06 
----------------------------------------------------------------------
Yes, it sounds fine.

----------------------------------------------------------------------
 rncbc - 12-10-04 23:49 
----------------------------------------------------------------------
Just uploaded my own kernel patch
    linux-2.6.10-rc2-mm3-usx2y-0.8.7.patch.gz
as for convenience, which should apply against 2.6.10-rc2-mm3, and fit
with latest Ingo's RT patch(es). It upgrades to the snd-usb-usx2y version
0.8.7, as current of alsa-kernel CVS HEAD.

My latest tests ran against my custom jack-0.99.28.3usx2y, that includes a
proper jackd usx2y backend, and went just fine. 

    (see http://www.rncbc.org/usx2y/)

With that, I could reach a brand new low-latency "record" as with:

    jackd -R -dusx2y -dhw:1,2 -r44100 -p64 -n2

without crackling nor (much) xruns. Tested under
2.6.10-rc2-mm-RT-V0.7.32-18 on a P4@2.5Ghz laptop. Never though this could
happen with a USB audio device upon jackd, ever. Am I alone? Thanks
Karsten, first you solved the ohci horror, now this... :)

Two things to note about using this new interface:

- hw:N,2 (N=0,1,... index of snd-usb-usx2y on the snd stack);
- nrpacks=1 (e.g. modprobe snd-usb-usx2y nrpacks=1) is mandatory for this
hwdep pcm interface being up and available.

Take care.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 21:36 karsten        New Issue                                    
10-26-04 21:36 karsten        File Added:
snd-usb-usx2y.patch.0.8.6+hwdep_pcm.bz2                    
10-26-04 21:39 karsten        Note Added: 0002265                          
10-27-04 02:01 rncbc          File Added: linux-2.6.9-ohci-hcd.patch.gz         
          
10-27-04 02:01 rncbc          File Added: linux-2.6.9-usx2y-0.8.6.patch.gz      
             
10-27-04 02:02 rncbc          File Added:
linux-2.6.9-usx2y-0.8.6-rawusb.patch.gz                    
10-27-04 02:02 rncbc          File Added: linux-2.6.9-mm1_usx2y-0.8.6.patch.gz  
                 
10-27-04 02:03 rncbc          File Added:
linux-2.6.9-mm1_usx2y-0.8.6-rawusb.patch.gz                    
10-27-04 02:26 rncbc          Note Added: 0002269                          
11-09-04 19:22 tiwai          Note Added: 0002346                          
12-02-04 20:19 karsten        Note Added: 0002697                          
12-03-04 14:06 tiwai          Note Added: 0002710                          
12-10-04 23:22 rncbc          File Added:
linux-2.6.10-rc2-mm3-usx2y-0.8.7.patch.gz                    
12-10-04 23:49 rncbc          Note Added: 0002809                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
