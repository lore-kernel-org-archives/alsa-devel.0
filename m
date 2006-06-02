From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002028]: cat /proc/asound/timers
Date: Fri, 2 Jun 2006 13:08:32 +0200
Message-ID: <23c939d84dbdfc11ec8eff898f5aa80a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 57E1E15A
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jun 2006 13:08:32 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2028> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2028
Category:                   CORE - timer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-17-2006 12:04 CEST
Last Modified:              06-02-2006 13:08 CEST
======================================================================
Summary:                    cat /proc/asound/timers
Description: 
Do all subdevices of cards list in /proc/asound/timers ?

some of 64 playback subdevices of device 3 of card 0 and card 1 'intel8x0'
is not listed


cat /proc/asound/timers
G0: system timer : 10000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-2: PCM playback 0-0-2 : SLAVE
P0-0-3: PCM capture 0-0-3 : SLAVE
P0-0-4: PCM playback 0-0-4 : SLAVE
P0-0-5: PCM capture 0-0-5 : SLAVE
P0-0-6: PCM playback 0-0-6 : SLAVE
P0-0-7: PCM capture 0-0-7 : SLAVE
P0-0-8: PCM playback 0-0-8 : SLAVE
P0-0-9: PCM capture 0-0-9 : SLAVE
P0-0-10: PCM playback 0-0-10 : SLAVE
P0-0-11: PCM capture 0-0-11 : SLAVE
P0-0-12: PCM playback 0-0-12 : SLAVE
P0-0-13: PCM capture 0-0-13 : SLAVE
P0-0-14: PCM playback 0-0-14 : SLAVE
P0-0-15: PCM capture 0-0-15 : SLAVE
P0-0-16: PCM playback 0-0-16 : SLAVE
P0-0-17: PCM capture 0-0-17 : SLAVE
P0-0-18: PCM playback 0-0-18 : SLAVE
P0-0-19: PCM capture 0-0-19 : SLAVE
P0-0-20: PCM playback 0-0-20 : SLAVE
P0-0-21: PCM capture 0-0-21 : SLAVE
P0-0-22: PCM playback 0-0-22 : SLAVE
P0-0-23: PCM capture 0-0-23 : SLAVE
P0-0-24: PCM playback 0-0-24 : SLAVE
P0-0-25: PCM capture 0-0-25 : SLAVE
P0-0-26: PCM playback 0-0-26 : SLAVE
P0-0-27: PCM capture 0-0-27 : SLAVE
P0-0-28: PCM playback 0-0-28 : SLAVE
P0-0-29: PCM capture 0-0-29 : SLAVE
P0-0-30: PCM playback 0-0-30 : SLAVE
P0-0-31: PCM capture 0-0-31 : SLAVE
P0-0-32: PCM playback 0-0-32 : SLAVE
P0-0-33: PCM capture 0-0-33 : SLAVE
P0-0-34: PCM playback 0-0-34 : SLAVE
P0-0-35: PCM capture 0-0-35 : SLAVE
P0-0-36: PCM playback 0-0-36 : SLAVE
P0-0-37: PCM capture 0-0-37 : SLAVE
P0-0-38: PCM playback 0-0-38 : SLAVE
P0-0-39: PCM capture 0-0-39 : SLAVE
P0-0-40: PCM playback 0-0-40 : SLAVE
P0-0-41: PCM capture 0-0-41 : SLAVE
P0-0-42: PCM playback 0-0-42 : SLAVE
P0-0-43: PCM capture 0-0-43 : SLAVE
P0-0-44: PCM playback 0-0-44 : SLAVE
P0-0-45: PCM capture 0-0-45 : SLAVE
P0-0-46: PCM playback 0-0-46 : SLAVE
P0-0-47: PCM capture 0-0-47 : SLAVE
P0-0-48: PCM playback 0-0-48 : SLAVE
P0-0-49: PCM capture 0-0-49 : SLAVE
P0-0-50: PCM playback 0-0-50 : SLAVE
P0-0-51: PCM capture 0-0-51 : SLAVE
P0-0-52: PCM playback 0-0-52 : SLAVE
P0-0-53: PCM capture 0-0-53 : SLAVE
P0-0-54: PCM playback 0-0-54 : SLAVE
P0-0-55: PCM capture 0-0-55 : SLAVE
P0-0-56: PCM playback 0-0-56 : SLAVE
P0-0-57: PCM capture 0-0-57 : SLAVE
P0-0-58: PCM playback 0-0-58 : SLAVE
P0-0-59: PCM capture 0-0-59 : SLAVE
P0-0-60: PCM playback 0-0-60 : SLAVE
P0-0-61: PCM capture 0-0-61 : SLAVE
P0-0-62: PCM playback 0-0-62 : SLAVE
P0-0-63: PCM capture 0-0-63 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P0-2-0: PCM playback 0-2-0 : SLAVE
P0-2-2: PCM playback 0-2-2 : SLAVE
P0-2-4: PCM playback 0-2-4 : SLAVE
P0-2-6: PCM playback 0-2-6 : SLAVE
P0-2-8: PCM playback 0-2-8 : SLAVE
P0-2-10: PCM playback 0-2-10 : SLAVE
P0-2-12: PCM playback 0-2-12 : SLAVE
P0-2-14: PCM playback 0-2-14 : SLAVE
P0-2-16: PCM playback 0-2-16 : SLAVE
P0-2-18: PCM playback 0-2-18 : SLAVE
P0-2-20: PCM playback 0-2-20 : SLAVE
P0-2-22: PCM playback 0-2-22 : SLAVE
P0-2-24: PCM playback 0-2-24 : SLAVE
P0-2-26: PCM playback 0-2-26 : SLAVE
P0-2-28: PCM playback 0-2-28 : SLAVE
P0-2-30: PCM playback 0-2-30 : SLAVE
P0-3-0: PCM playback 0-3-0 : SLAVE
P0-3-2: PCM playback 0-3-2 : SLAVE
P0-3-4: PCM playback 0-3-4 : SLAVE
P0-3-6: PCM playback 0-3-6 : SLAVE
P0-3-8: PCM playback 0-3-8 : SLAVE
P0-3-10: PCM playback 0-3-10 : SLAVE
P0-3-12: PCM playback 0-3-12 : SLAVE
P0-3-14: PCM playback 0-3-14 : SLAVE
P0-3-16: PCM playback 0-3-16 : SLAVE
P0-3-18: PCM playback 0-3-18 : SLAVE
P0-3-20: PCM playback 0-3-20 : SLAVE
P0-3-22: PCM playback 0-3-22 : SLAVE
P0-3-24: PCM playback 0-3-24 : SLAVE
P0-3-26: PCM playback 0-3-26 : SLAVE
P0-3-28: PCM playback 0-3-28 : SLAVE
P0-3-30: PCM playback 0-3-30 : SLAVE
P0-3-32: PCM playback 0-3-32 : SLAVE
P0-3-34: PCM playback 0-3-34 : SLAVE
P0-3-36: PCM playback 0-3-36 : SLAVE
P0-3-38: PCM playback 0-3-38 : SLAVE
P0-3-40: PCM playback 0-3-40 : SLAVE
P0-3-42: PCM playback 0-3-42 : SLAVE
P0-3-44: PCM playback 0-3-44 : SLAVE
P0-3-46: PCM playback 0-3-46 : SLAVE
P0-3-48: PCM playback 0-3-48 : SLAVE
P0-3-50: PCM playback 0-3-50 : SLAVE
P0-3-52: PCM playback 0-3-52 : SLAVE
P0-3-54: PCM playback 0-3-54 : SLAVE
P0-3-56: PCM playback 0-3-56 : SLAVE
P0-3-58: PCM playback 0-3-58 : SLAVE
P0-3-60: 
======================================================================

----------------------------------------------------------------------
 Raymond - 06-02-06 13:02 
----------------------------------------------------------------------
This bug can be reproduced by using 8 snd-dummy

cat /proc/asound/cards
 0 [Dummy          ]: Dummy - Dummy
                      Dummy 1
 1 [Dummy_1        ]: Dummy - Dummy
                      Dummy 2
 2 [Dummy_2        ]: Dummy - Dummy
                      Dummy 3
 3 [Dummy_3        ]: Dummy - Dummy
                      Dummy 4
 4 [Dummy_4        ]: Dummy - Dummy
                      Dummy 5
 5 [Dummy_5        ]: Dummy - Dummy
                      Dummy 6
 6 [Dummy_6        ]: Dummy - Dummy
                      Dummy 7
 7 [Dummy_7        ]: Dummy - Dummy
                      Dummy 8

cat /proc/asound/timers
G0: system timer : 10000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-2: PCM playback 0-0-2 : SLAVE
P0-0-3: PCM capture 0-0-3 : SLAVE
P0-0-4: PCM playback 0-0-4 : SLAVE
P0-0-5: PCM capture 0-0-5 : SLAVE
P0-0-6: PCM playback 0-0-6 : SLAVE
P0-0-7: PCM capture 0-0-7 : SLAVE
P0-0-8: PCM playback 0-0-8 : SLAVE
P0-0-9: PCM capture 0-0-9 : SLAVE
P0-0-10: PCM playback 0-0-10 : SLAVE
P0-0-11: PCM capture 0-0-11 : SLAVE
P0-0-12: PCM playback 0-0-12 : SLAVE
P0-0-13: PCM capture 0-0-13 : SLAVE
P0-0-14: PCM playback 0-0-14 : SLAVE
P0-0-15: PCM capture 0-0-15 : SLAVE
P1-0-0: PCM playback 1-0-0 : SLAVE
P1-0-1: PCM capture 1-0-1 : SLAVE
P1-0-2: PCM playback 1-0-2 : SLAVE
P1-0-3: PCM capture 1-0-3 : SLAVE
P1-0-4: PCM playback 1-0-4 : SLAVE
P1-0-5: PCM capture 1-0-5 : SLAVE
P1-0-6: PCM playback 1-0-6 : SLAVE
P1-0-7: PCM capture 1-0-7 : SLAVE
P1-0-8: PCM playback 1-0-8 : SLAVE
P1-0-9: PCM capture 1-0-9 : SLAVE
P1-0-10: PCM playback 1-0-10 : SLAVE
P1-0-11: PCM capture 1-0-11 : SLAVE
P1-0-12: PCM playback 1-0-12 : SLAVE
P1-0-13: PCM capture 1-0-13 : SLAVE
P1-0-14: PCM playback 1-0-14 : SLAVE
P1-0-15: PCM capture 1-0-15 : SLAVE
P2-0-0: PCM playback 2-0-0 : SLAVE
P2-0-1: PCM capture 2-0-1 : SLAVE
P2-0-2: PCM playback 2-0-2 : SLAVE
P2-0-3: PCM capture 2-0-3 : SLAVE
P2-0-4: PCM playback 2-0-4 : SLAVE
P2-0-5: PCM capture 2-0-5 : SLAVE
P2-0-6: PCM playback 2-0-6 : SLAVE
P2-0-7: PCM capture 2-0-7 : SLAVE
P2-0-8: PCM playback 2-0-8 : SLAVE
P2-0-9: PCM capture 2-0-9 : SLAVE
P2-0-10: PCM playback 2-0-10 : SLAVE
P2-0-11: PCM capture 2-0-11 : SLAVE
P2-0-12: PCM playback 2-0-12 : SLAVE
P2-0-13: PCM capture 2-0-13 : SLAVE
P2-0-14: PCM playback 2-0-14 : SLAVE
P2-0-15: PCM capture 2-0-15 : SLAVE
P3-0-0: PCM playback 3-0-0 : SLAVE
P3-0-1: PCM capture 3-0-1 : SLAVE
P3-0-2: PCM playback 3-0-2 : SLAVE
P3-0-3: PCM capture 3-0-3 : SLAVE
P3-0-4: PCM playback 3-0-4 : SLAVE
P3-0-5: PCM capture 3-0-5 : SLAVE
P3-0-6: PCM playback 3-0-6 : SLAVE
P3-0-7: PCM capture 3-0-7 : SLAVE
P3-0-8: PCM playback 3-0-8 : SLAVE
P3-0-9: PCM capture 3-0-9 : SLAVE
P3-0-10: PCM playback 3-0-10 : SLAVE
P3-0-11: PCM capture 3-0-11 : SLAVE
P3-0-12: PCM playback 3-0-12 : SLAVE
P3-0-13: PCM capture 3-0-13 : SLAVE
P3-0-14: PCM playback 3-0-14 : SLAVE
P3-0-15: PCM capture 3-0-15 : SLAVE
P4-0-0: PCM playback 4-0-0 : SLAVE
P4-0-1: PCM capture 4-0-1 : SLAVE
P4-0-2: PCM playback 4-0-2 : SLAVE
P4-0-3: PCM capture 4-0-3 : SLAVE
P4-0-4: PCM playback 4-0-4 : SLAVE
P4-0-5: PCM capture 4-0-5 : SLAVE
P4-0-6: PCM playback 4-0-6 : SLAVE
P4-0-7: PCM capture 4-0-7 : SLAVE
P4-0-8: PCM playback 4-0-8 : SLAVE
P4-0-9: PCM capture 4-0-9 : SLAVE
P4-0-10: PCM playback 4-0-10 : SLAVE
P4-0-11: PCM capture 4-0-11 : SLAVE
P4-0-12: PCM playback 4-0-12 : SLAVE
P4-0-13: PCM capture 4-0-13 : SLAVE
P4-0-14: PCM playback 4-0-14 : SLAVE
P4-0-15: PCM capture 4-0-15 : SLAVE
P5-0-0: PCM playback 5-0-0 : SLAVE
P5-0-1: PCM capture 5-0-1 : SLAVE
P5-0-2: PCM playback 5-0-2 : SLAVE
P5-0-3: PCM capture 5-0-3 : SLAVE
P5-0-4: PCM playback 5-0-4 : SLAVE
P5-0-5: PCM capture 5-0-5 : SLAVE
P5-0-6: PCM playback 5-0-6 : SLAVE
P5-0-7: PCM capture 5-0-7 : SLAVE
P5-0-8: PCM playback 5-0-8 : SLAVE
P5-0-9: PCM capture 5-0-9 : SLAVE
P5-0-10: PCM playback 5-0-10 : SLAVE
P5-0-11: PCM capture 5-0-11 : SLAVE
P5-0-12: PCM playback 5-0-12 : SLAVE
P5-0-13: PCM capture 5-0-13 : SLAVE
P5-0-14: PCM playback 5-0-14 : SLAVE
P5-0-15: PCM capture 5-0-15 : SLAVE
P6-0-0: PCM playback 6-0-0 : SLAVE
P6-0-1: PCM capture 6-0-1 : SLAVE
P6-0-2: PCM playback 6-0-2 : SLAVE
P6-0-3: PCM capture 6-0-3 : SLAVE
P6-0-4: PCM playback 6-0-4 : SLAVE
P6-0-5: PCM capture 6-0-5 : SLAVE
P6-0-6: PCM playback 6-0-6 : SLAVE
P6-0-7: PCM capture 6-0-7 : SLAVE
P6-0-8: PCM playback 6-0-8 : SLAVE
P6-0-9: PCM capture 6-0-9 : SLAVE
P6-0-10: PCM playback 6-0-10 : SLAVE
P6-0-11: PCM capture 6-0-11 : SLAVE
P6-0-12: PCM playback 6-0-12 : SLAVE
P6-0-13: PCM capture 6-0-13 : SLAVE
P6-0-14: PCM playback 6-0-14 : SLAVE
P6-0-15: PCM capture 6-0-15 : SLAVE
P7-0-0: PCM playback 7-0-0 : SLAVE
P7-0-1: PCM capture 7-0-1 : SLAVE
P7-0-2: PCM playback 7-0-2 :

----------------------------------------------------------------------
 tiwai - 06-02-06 13:08 
----------------------------------------------------------------------
This problem was already fixed on HG version.
There is no longer buffer size limit.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-17-06 12:04 Raymond        New Issue                                    
04-17-06 12:04 Raymond        Distribution              => Fedora Core 1   
04-17-06 12:04 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
04-17-06 16:09 rlrevell       Status                   new => closed       
04-17-06 16:09 rlrevell       Note Added: 0009310                          
04-17-06 19:45 Raymond        Status                   closed => feedback  
04-17-06 19:45 Raymond        Resolution               open => reopened    
04-17-06 19:45 Raymond        Note Added: 0009317                          
04-17-06 19:47 Raymond        Note Edited: 0009317                         
04-17-06 19:57 rlrevell       Note Added: 0009318                          
04-18-06 10:42 Raymond        Note Added: 0009327                          
04-29-06 11:13 Raymond        Note Added: 0009541                          
05-01-06 07:30 Raymond        Note Edited: 0009541                         
05-01-06 07:36 Raymond        Note Edited: 0009541                         
05-01-06 07:42 Raymond        Note Edited: 0009541                         
05-01-06 12:10 Raymond        Note Edited: 0009541                         
05-01-06 12:12 Raymond        Note Edited: 0009541                         
05-31-06 18:11 Raymond        Note Deleted: 0009541                        
05-31-06 18:19 Raymond        Issue Monitored: tiwai                       
05-31-06 18:19 Raymond        Note Added: 0010024                          
06-02-06 13:02 Raymond        Note Added: 0010047                          
06-02-06 13:08 tiwai          Status                   feedback => resolved
06-02-06 13:08 tiwai          Resolution               reopened => fixed   
06-02-06 13:08 tiwai          Assigned To               => tiwai           
06-02-06 13:08 tiwai          Note Added: 0010048                          
======================================================================
