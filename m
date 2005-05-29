From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000857]: intel8x0m does not work on asus a3n laptop
Date: Mon, 30 May 2005 00:05:07 +0200
Message-ID: <a6d164d5827fa1c4e48b8133a5ae1a54@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 552711A4
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 00:05:07 +0200 (MEST)
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
Status:                     assigned
Distribution:               slackware 10
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-29-2005 16:43 CET
Last Modified:              05-30-2005 00:05 CEST
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
 metal - 05-29-05 21:45 
----------------------------------------------------------------------
I have downloaded 2.6.12-rc5. Trying use command, this isn't help. Modem
quiet and i don't hear sound in phone too.

----------------------------------------------------------------------
 sashak - 05-30-05 00:05 
----------------------------------------------------------------------
There is new mixer stuff in linux-2.6.12-rc5, it is supported only by
slmodem-2.9.9d from http://linmodems.technion.ac.il/packages/smartlink .
Speaker support is added to alsa cvs today, but not supported yet by any
slmodem-2.9.9x, if you would like to try there is the patch for
slmodem-2.9.9d .

BTW drop your /proc/asound/card1/codec97#97/mc97#1 .

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
