From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000857]: intel8x0m does not work on asus a3n laptop
Date: Wed, 22 Mar 2006 04:27:49 +0100
Message-ID: <a9d8bb16b508611ee4bd371a3805decd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 076AA18E
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 04:27:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=857> 
======================================================================
Reported By:                mart
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   857
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               slackware 10
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-29-2005 16:43 CET
Last Modified:              03-22-2006 04:27 CET
======================================================================
Summary:                    intel8x0m does not work on asus a3n laptop
Description: 
with this laptop, the sound by intel8x0 works ok, but the modem with the 
alsa-driver intel8x0m and slmodemd 2.9.10 does not.
slmodemd starts ok, it opens the alsa device hw:1 that is tje modem, but
when i try to dial a number (i tried with kppp and minicom) the modem does
dial, but after a while it quits with a NO ANSWER error.
making some exprtiments, i found that when i connect under windows, if i
listen to the phone connected to the same line, i can hear the tones
gererated by the modem, but when i dial under linux i can't hear anything,
so i think this is a driver issue, the driver that can't make the modem
produce any sound.

this is what lspci tells me on that modem:
00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000509 Conexant Moden &quot;not ready&quot;
related to          0000890 no dialtone with modem &amp; strange lo...
======================================================================

----------------------------------------------------------------------
 metal - 06-01-05 21:26 
----------------------------------------------------------------------
I downloaded slmodem-2.9.9d. I do:
slmodemd --country=RUSSIA --alsa hw:1
minicom
atz
ok
atx3
ok
atdp7893333
NO ANSWER
In syslod
darkstar kernel: codec_semaphore: semaphore is not ready [0x1][0x701300]
darkstar kernel: codec_read 1: semaphore is not ready for register 0x54

----------------------------------------------------------------------
 sashak - 06-01-05 21:47 
----------------------------------------------------------------------
Use ATDT instead of ATDP (pulse dialing is unsupported by slmodemd --alsa),
not "semaphore is not ready" is fixed in recent ALSA (1.0.9 and cvs).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-05 16:43 mart           New Issue                                    
01-29-05 16:43 mart           Distribution              => slackware 10    
01-29-05 16:43 mart           Kernel Version            => 2.6.10          
01-29-05 16:44 mart           Issue Monitored: mart                        
02-03-05 21:55 mart           Note Added: 0003494                          
02-03-05 23:21 sashak         Note Added: 0003495                          
02-04-05 13:10 mart           Note Added: 0003501                          
03-02-05 14:12 perex          Relationship added       related to 0000509  
03-02-05 15:19 perex          Relationship added       related to 0000890  
03-24-05 20:25 metal          Note Added: 0004200                          
04-03-05 01:49 sashak         Note Added: 0004301                          
04-05-05 21:29 metal          Note Added: 0004342                          
04-14-05 11:55 sashak         Note Added: 0004486                          
05-29-05 21:45 metal          Note Added: 0004791                          
05-30-05 00:05 sashak         Note Added: 0004794                          
05-30-05 00:05 sashak         File Added: slmodem-2.9.9d-speaker.patch          
         
06-01-05 21:26 metal          Note Added: 0004869                          
06-01-05 21:47 sashak         Note Added: 0004870                          
03-22-06 04:27 rlrevell       Status                   assigned => resolved
03-22-06 04:27 rlrevell       Resolution               open => fixed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
