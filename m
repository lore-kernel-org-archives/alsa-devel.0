From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000425]: usb-usx2y: System lockup on PCM device open (OHCI)
Date: Tue, 26 Oct 2004 13:47:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <2ab3c9fc8162367f3a4dfa1eadd90b7d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5F1302EF
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2004 13:47:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=425> 
======================================================================
Reported By:                rncbc
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   425
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 10.0 Official
Kernel Version:             2.6.8-rc2
======================================================================
Date Submitted:             08-06-2004 10:53 CEST
Last Modified:              10-26-2004 13:47 CEST
======================================================================
Summary:                    usb-usx2y: System lockup on PCM device open (OHCI)
Description: 
As of ALSA 1.0.6rc1, the US-x2y PCM device driver module exposes a hard
conflict on OHCI based USB controllers, causing a complete system lockup
-- kernel oops on an interrupt handler -- exactly upon starting or
openning the PCM device for audio playback. 
======================================================================

----------------------------------------------------------------------
 rncbc - 10-22-04 09:48 
----------------------------------------------------------------------
Uploaded latest snd-usb-usx2y 0.8.5 kernel patches, as proposed by Karsten
on alsa-devel.

----------------------------------------------------------------------
 rncbc - 10-26-04 13:47 
----------------------------------------------------------------------
Uploaded latest snd-usb-usx2y 0.8.6 kernel patches, as posted today by
Karsten on alsa-devel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-06-04 10:53 rncbc          New Issue                                    
08-06-04 10:53 rncbc          File Added: usx2y-oops3.png                    
08-06-04 10:53 rncbc          Distribution              => Mandrake 10.0
Official
08-06-04 10:53 rncbc          Kernel Version            => 2.6.8-rc2       
08-06-04 12:16 rncbc          Note Added: 0001538                          
09-23-04 20:52 karsten        Note Added: 0001849                          
09-24-04 09:43 rncbc          Note Added: 0001858                          
09-25-04 17:13 rncbc          File Added: usx2y-oops4.png                    
09-25-04 17:18 rncbc          Note Added: 0001911                          
09-25-04 17:45 karsten        Note Added: 0001912                          
09-26-04 14:54 karsten        Note Edited: 0001912                         
09-26-04 15:15 rncbc          File Added: netconsole.out.0.txt                  
 
09-26-04 15:16 rncbc          File Added: netconsole.out.1.txt                  
 
09-26-04 15:26 karsten        Note Edited: 0001912                         
09-26-04 15:28 rncbc          Note Added: 0001921                          
09-26-04 15:43 karsten        Note Added: 0001922                          
09-26-04 21:52 rncbc          File Added: netconsole.out.2.txt                  
 
09-26-04 22:00 rncbc          Note Added: 0001925                          
09-26-04 22:18 karsten        Note Added: 0001927                          
09-27-04 13:48 karsten        File Added: snd-usb-usx2y.patch.0.7.3+ohci        
           
09-27-04 13:51 karsten        Note Added: 0001936                          
09-27-04 23:22 rncbc          File Added: netconsole.out.3.aplay_OK.txt         
          
09-27-04 23:22 rncbc          File Added: netconsole.out.4.jackd_HANGS.txt      
             
09-27-04 23:49 rncbc          Note Added: 0001943                          
09-28-04 15:13 karsten        File Added: snd-usb-usx2y.patch.0.7.3+ohci_1      
             
09-28-04 15:16 karsten        Note Added: 0001945                          
09-28-04 21:52 rncbc          File Added: netconsole.out.5.aplay_OOPS.txt       
            
09-28-04 21:52 rncbc          File Added: netconsole.out.6.jackd_OOPS.txt       
            
09-28-04 22:01 rncbc          Note Added: 0001957                          
09-28-04 22:02 rncbc          Note Edited: 0001925                         
09-29-04 12:38 rncbc          Issue Monitored: rncbc                       
09-30-04 01:19 rncbc          File Added: usx2y_linux-2.6.9-rc2-mm4-S7.tar.gz   
                
09-30-04 01:22 rncbc          File Added: linux-2.6.9-rc2-mm4-S7_usx2y.patch.gz 
                  
09-30-04 01:24 rncbc          File Added: dmesg.out.7.jackd-R_ABORTS.txt        
           
09-30-04 01:25 rncbc          File Added: dmesg.out.8.jackd_XRUNS.txt           
        
09-30-04 01:44 karsten        Note Added: 0001978                          
09-30-04 02:00 rncbc          Note Added: 0001979                          
09-30-04 02:11 karsten        Note Added: 0001980                          
09-30-04 11:43 rncbc          Note Edited: 0001979                         
09-30-04 11:44 rncbc          Note Edited: 0001979                         
10-01-04 01:23 karsten        Note Added: 0001988                          
10-07-04 10:24 rncbc          File Added: linux-2.6.9-usx2y-0.8.3.patch.gz      
             
10-07-04 10:24 rncbc          File Added: linux-2.6.9-usx2y-0.8.3a.patch.gz     
              
10-07-04 10:25 rncbc          File Added:
linux-2.6.9-usx2y-0.8.3a_rawusb.patch.gz                    
10-07-04 10:26 rncbc          File Added: jackd-usx2y-0.8.3-out.tar.gz          
         
10-07-04 10:26 rncbc          File Added: jackd-usx2y-0.8.3a-out.tar.gz         
          
10-07-04 10:42 rncbc          Note Added: 0002029                          
10-07-04 15:55 roswel         Note Added: 0002033                          
10-07-04 19:51 roswel         Note Added: 0002038                          
10-07-04 19:52 roswel         Issue Monitored: roswel                      
10-08-04 03:40 behappy_       Note Added: 0002041                          
10-08-04 04:07 behappy_       Issue Monitored: behappy_                    
10-08-04 22:24 karsten        File Added:
usx2y_linux-2.6.9-rc2-mm4-S7_041008.tar.gz                    
10-08-04 22:30 karsten        Note Added: 0002058                          
10-10-04 15:30 karsten        File Added:
usx2y_linux-2.6.9-rc3-mm3-VP-T3_041010.tar.gz                    
10-10-04 15:37 karsten        Note Added: 0002066                          
10-10-04 18:45 roswel         Note Added: 0002067                          
10-10-04 20:27 karsten        Note Added: 0002068                          
10-11-04 21:13 roswel         Note Added: 0002085                          
10-14-04 10:41 rncbc          File Added: linux-2.6.9-usx2y-0.8.3c.patch.gz     
              
10-14-04 10:42 rncbc          File Added: usx2y_jackd.0.out                    
10-14-04 10:43 rncbc          File Added: usx2y_jackd.1.out                    
10-14-04 10:43 rncbc          File Added: usx2y_jackd-R.0.out                   

10-14-04 10:44 rncbc          File Added: usx2y_jackd-R.1.out                   

10-14-04 11:21 rncbc          Note Added: 0002138                          
10-14-04 11:25 rncbc          Note Edited: 0002138                         
10-14-04 15:26 behappy_       Note Added: 0002150                          
10-15-04 01:30 karsten        Note Added: 0002162                          
10-15-04 01:32 karsten        File Added:
usx2y_linux-2.6.9-rc2-mm4-S7_041014.tar.gz                    
10-15-04 01:40 karsten        Note Added: 0002163                          
10-15-04 11:37 rncbc          File Added:
linux-2.6.9-rc4-mm1_usx2y-0.8.3d.patch.gz                    
10-15-04 11:37 rncbc          File Added: linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz 
                  
10-15-04 12:06 rncbc          Note Added: 0002164                          
10-15-04 12:55 behappy_       Note Added: 0002165                          
10-16-04 00:36 karsten        Note Added: 0002178                          
10-16-04 00:38 karsten        Note Edited: 0002178                         
10-16-04 00:41 rncbc          File Added: usx2y_jackd.2.out                    
10-16-04 00:42 rncbc          File Added: usx2y_jackd-R.2.out                   

10-16-04 00:52 rncbc          Note Added: 0002179                          
10-16-04 00:58 rncbc          Note Edited: 0002179                         
10-16-04 02:35 rncbc          File Added: usx2y_jackd-R.3.out                   

10-16-04 02:35 rncbc          File Added: usx2y_jackd-R.4.out                   

10-16-04 03:05 rncbc          Note Added: 0002182                          
10-16-04 13:58 karsten        Note Added: 0002187                          
10-16-04 14:13 karsten        Note Edited: 0002187                         
10-16-04 14:15 karsten        Note Edited: 0002187                         
10-16-04 14:15 karsten        Note Edited: 0002187                         
10-16-04 16:31 rncbc          Note Added: 0002188                          
10-16-04 23:11 karsten        Note Added: 0002189                          
10-16-04 23:13 karsten        Note Edited: 0002189                         
10-17-04 02:09 rncbc          File Added: usx2y_jackd-R.3a.out                  
 
10-17-04 02:20 rncbc          Note Added: 0002190                          
10-17-04 13:32 karsten        Note Added: 0002191                          
10-17-04 13:38 karsten        Note Edited: 0002191                         
10-17-04 13:44 karsten        Note Edited: 0002191                         
10-17-04 22:26 rncbc          File Added:
usx2y_jackd-R.out-2.6.9-rc4-mm1-RT-U4.0                    
10-17-04 22:27 rncbc          File Added:
gdb_disassemble_usX2Y_urbs_start-2.6.9-rc4-mm1-RT-U4.0                    
10-17-04 22:46 rncbc          Note Added: 0002193                          
10-18-04 22:56 rncbc          File Added:
linux-2.6.9-rc4-mm1_usx2y-0.8.4.patch.gz                    
10-18-04 23:07 rncbc          Note Added: 0002200                          
10-19-04 13:50 roswel         Note Added: 0002204                          
10-19-04 15:53 rncbc          File Added: linux-2.6.9-rc4_usx2y-0.8.4.patch.gz  
                 
10-19-04 15:56 rncbc          Note Added: 0002206                          
10-20-04 07:39 roswel         Note Added: 0002210                          
10-20-04 11:30 rncbc          Note Added: 0002213                          
10-22-04 09:44 rncbc          File Added:
linux-2.6.9-rc4-mm1_usx2y-0.8.5.patch.gz                    
10-22-04 09:45 rncbc          File Added: linux-2.6.9-usx2y-0.8.5.patch.gz      
             
10-22-04 09:48 rncbc          Note Added: 0002226                          
10-24-04 00:01 djether        Issue Monitored: djether                     
10-26-04 13:45 rncbc          File Added: linux-2.6.9-mm1_usx2y-0.8.6.patch.gz  
                 
10-26-04 13:46 rncbc          File Added: linux-2.6.9-usx2y-0.8.6.patch.gz      
             
10-26-04 13:47 rncbc          Note Added: 0002264                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
