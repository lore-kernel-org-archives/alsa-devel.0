From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000048]: M-Audio Quattro Initialisation Problem
Date: Wed, 17 Nov 2004 15:09:10 +0100
Message-ID: <248d11cff3217d0e8c9279a099e4d5ce@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B4D4822A
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2004 15:09:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=48> 
======================================================================
Reported By:                giggls
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   48
Category:                   USB - usb-audio
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.24
======================================================================
Date Submitted:             02-09-2004 11:45 CET
Last Modified:              11-17-2004 15:09 CET
======================================================================
Summary:                    M-Audio Quattro Initialisation Problem
Description: 
If a M-Audio Quattro device is pluged into the USB Port the driver does not
always initialize the device in a correct way.

It seems to work, but it does not record any useful sound.

Unfortunately it does work occasionally (about 50% of the time)!

Replugging the device until it works does resolve the Problem.


======================================================================

----------------------------------------------------------------------
 timblech - 04-28-04 12:44 
----------------------------------------------------------------------
hi all,

i still have problems with my quattro ... pd reports the input level as 16
(what was ok with the old driver, the distortion of the old driver was at
58), but the input is still distorted ...

but after switching to kernel 2.6.6_rc2, i didn't have to restart alsa
that often ... with kernel 2.4 i had to restart between 10 and 15 times
... with 2.6 only one or two times ... maybe that's a hint .... 
cheers ... t

----------------------------------------------------------------------
 giggls - 11-17-04 15:09 
----------------------------------------------------------------------
OK, I've got some time now to debug this Problem again. It would still
be nice to get these devices working!

I still does not work as of kernel 2.6.9 (vanilla Kernel). Still the same
Problem as in my first bug-report. It soemetimes works and sometimes does
not. Despite your patch which has been applied as I could see in the
sources.

It does not matter if I use 16 or 24 Bit Mode:

arecord -D plughw:1 -d 3 -r 48000 -f S24_LE -q -c 2 24.wav

arecord -D plughw:1 -d 3 -r 48000 -f S16_LE -q -c 2 16.wav

The first gives big endian data though.

Sven

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-04 11:45 giggls         New Issue                                    
02-11-04 10:26 giggls         Issue Monitored: giggls                      
02-11-04 14:58 v2             Note Added: 0000218                          
02-11-04 14:58 v2             Issue Monitored: v2                          
02-11-04 14:59 v2             Note Edited: 0000218                         
02-11-04 14:59 v2             Note Edited: 0000218                         
02-11-04 16:36 giggls         Note Added: 0000219                          
02-24-04 08:48 Clemens LadischSeverity                 feature => minor    
02-24-04 09:07 Clemens LadischNote Added: 0000302                          
02-25-04 09:30 giggls         File Added: proc-stream1.txt                    
02-25-04 09:30 giggls         File Added: proc-stream0.txt                    
02-25-04 09:53 giggls         Note Added: 0000310                          
02-25-04 10:12 Clemens LadischIssue Monitored: Clemens Ladisch                  
 
02-25-04 10:15 Clemens LadischNote Added: 0000313                          
02-25-04 16:10 giggls         Note Added: 0000315                          
02-26-04 16:08 Clemens LadischFile Added: quattroif.patch                    
02-26-04 16:12 Clemens LadischNote Added: 0000352                          
02-26-04 16:12 Clemens LadischSeverity                 minor => major      
02-26-04 16:12 Clemens LadischReproducibility          always => sometimes 
02-27-04 15:42 giggls         Note Added: 0000381                          
03-01-04 18:45 Clemens LadischNote Added: 0000413                          
03-02-04 09:31 giggls         File Added: proc-asound-card1-stream0-junk.txt    
               
03-02-04 09:32 giggls         Note Added: 0000432                          
03-02-04 17:11 Clemens LadischNote Added: 0000443                          
03-04-04 10:09 giggls         Note Added: 0000471                          
03-04-04 12:53 Clemens LadischNote Added: 0000477                          
03-04-04 16:18 giggls         Note Added: 0000482                          
03-04-04 16:18 giggls         File Added: sinus.raw                        
03-04-04 16:19 giggls         File Added: silence.raw                      
03-04-04 19:50 Clemens LadischNote Added: 0000491                          
03-08-04 10:46 Clemens LadischFile Added: quattro-new.patch                    
03-08-04 10:48 Clemens LadischNote Added: 0000527                          
04-28-04 12:44 timblech       Note Added: 0000969                          
11-17-04 15:09 giggls         Note Added: 0002435                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
