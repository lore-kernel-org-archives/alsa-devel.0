From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000059]: On au8820 left and right channels are swapped
Date: Fri, 6 Jan 2006 18:15:39 +0100
Message-ID: <61dc82690e1814a883319f7d11e484d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8FB9E13C
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2006 18:15:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59> 
======================================================================
Reported By:                kernel_bug
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   59
Category:                   PCI - au88x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     confirmed
Distribution:               
Kernel Version:             2.6.2
======================================================================
Date Submitted:             02-13-2004 11:40 CET
Last Modified:              01-06-2006 18:15 CET
======================================================================
Summary:                    On au8820 left and right channels are swapped
Description: 
In most cases, left and right channels are swapped. But in approx. 5% cases
all OK. Looks like the matter is somewhere in byte alignment...
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000949 Randomly, left and right tracks are swaped
======================================================================

----------------------------------------------------------------------
 Raymond - 08-27-05 04:43 
----------------------------------------------------------------------
0:7c = 574d
0:7e = 4c00

You may need to upgrade to CVS since there is a patch for WM codecs.

This means you cannot just copy pci/ac97/*.*
1) alsa-driver
2) alsa-lib
3) alsa-util

02:02.0 Class 0401: 12eb:0001 (rev 02)
        Subsystem: 12eb:0001

Is your Vortex card OEM ?

http://portal.suse.com/sdb/en/2001/03/chofman_vortex.html

Other user do not have your problem but his au8820 card use STAC9704 and
your card use WM9701A. 

The other user has WM9701A on his au8810.

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948


Do you find "vortex: IRQ fifo error" in system log when you play sound ?

http://lists.nongnu.org/archive/html/openvortex-dev/2005-03/msg00015.html

Using "vortex_adbdma_stopfifo()" instead of "vortex_adbdma_pausefifo()"
in snd_vortex_pcm_trigger() (ie. in the same way before au88x0 migrated
from alsa-driver to alsa-kernel) seem to fix the front/rear channels swap
when playing 4 channels sound on my au8830.

----------------------------------------------------------------------
 Raymond - 01-06-06 18:15 
----------------------------------------------------------------------
Please try to add the vortex_dump_route routine at the end of following
routines:-
1) vortex_connect_default()
2) snd_vortex_pcm_hw_params()
3) snd_vortex_pcm_hw_free() 

and post the system log when the channels are swapped/normal.

void vortex_dump_route(vortex_t * vortex)
{
     u32 addr,value;
     u8  src,dest;
     int i;
     for (i=0; i<VORTEX_ADB_CHNBASE_COUNT; i++) {
         addr=VORTEX_ADB_CHNBASE+i*4;
         value=hwread(vortex->mmio,addr);
         if ( value != ROUTE_MASK ) {
  	     src=(value >>ADB_SHIFT)& ADB_MASK;
	     dest=value & ADB_MASK;
	     printk(KERN_INFO "%.8x adb_chnbase(%.2x) %.8x src=%.2x
dest=%.2x\n",
        		addr,i,value,src,dest);
         };
     };
     for (addr=VORTEX_ADB_RTBASE; addr<VORTEX_ADB_CHNBASE; addr+=4) {
         value=hwread(vortex->mmio,addr);
         if ( value != ROUTE_MASK ) {
  	     src=(value >>ADB_SHIFT)& ADB_MASK;
	     dest=value & ADB_MASK;
	     printk(KERN_INFO "%.8x adb_rtbase(%.2x)  %.8x src=%.2x
dest=%.2x\n",
        		addr,(addr-VORTEX_ADB_RTBASE)>>2,value,src,dest);
         };
     };
     printk(KERN_INFO "---------------------------------\n");
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 11:40 kernel_bug     New Issue                                    
02-21-04 15:40 kernel_bug     Note Added: 0000280                          
03-02-04 02:56 Tim            Note Added: 0000429                          
04-09-04 11:54 kernel_bug     Note Added: 0000774                          
04-09-04 18:35 mjander        Note Added: 0000777                          
04-17-04 18:59 mjander        Status                   assigned => closed  
04-17-04 18:59 mjander        Note Added: 0000849                          
04-26-04 17:04 kernel_bug     Status                   closed => feedback  
04-26-04 17:04 kernel_bug     Resolution               open => reopened    
04-26-04 17:04 kernel_bug     Note Added: 0000953                          
04-26-04 23:27 mjander        Note Added: 0000956                          
03-10-05 15:31 jdthood        Note Added: 0003866                          
03-10-05 16:44 mjander        Note Added: 0003867                          
03-10-05 21:25 kernel_bug     Note Added: 0003873                          
03-22-05 22:33 jdthood        Relationship added       related to 0000949  
03-28-05 04:27 jdthood        Note Added: 0004235                          
03-28-05 04:27 jdthood        Status                   feedback => assigned
03-28-05 04:29 jdthood        Status                   assigned => confirmed
08-26-05 14:50 Raymond        Note Added: 0005951                          
08-26-05 15:12 kernel_bug     Note Added: 0005955                          
08-26-05 16:07 Raymond        Note Added: 0005956                          
08-26-05 17:38 kernel_bug     File Added: asound.state                     
08-26-05 17:41 kernel_bug     Note Added: 0005957                          
08-27-05 04:43 Raymond        Note Added: 0005959                          
01-06-06 18:15 Raymond        Note Added: 0007491                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
