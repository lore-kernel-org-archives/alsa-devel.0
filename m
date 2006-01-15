From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001694]: snd-intel8x0m unable to initialize the Modem device ICH6
Date: Sun, 15 Jan 2006 13:57:07 +0100
Message-ID: <009b42f298b3c568f1323d331289a4bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EDDB412B
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2006 13:57:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1694> 
======================================================================
Reported By:                guido
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1694
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian "Sarge" with kernel and alsa from "SID"
Kernel Version:             2.6.14
======================================================================
Date Submitted:             12-29-2005 22:43 CET
Last Modified:              01-15-2006 13:57 CET
======================================================================
Summary:                    snd-intel8x0m unable to initialize the Modem device
ICH6
Description: 
Dear Maintainer and Reader,

I couldn't get the modem in my Notebook "Acer Aspire 1692WLMi" working.
I found a lot of things recommended in different Mailing lists and blogs
but they did not solve my problem. I use alsa Ver. 1.0.10-1 with
kernel Version 2.6.14 with source from Debian "SID".
The current status is that two modules are loaded during boot,
snd-intel8x0 and snd-intel8x0m. When both modules are loaded
the sound doesn't works. Only when snd-intel8x0 is loaded alone the sound
works fine.
If I additionally load module snd-intel8x0m sound does not work anymore
and error messages in syslog are printed.
So I think the error messages are a buck in the snd-intel8x0m module.
There is no /proc/asound/Modem present when I load the snd-intel8x0m
module.

In the "Additional Information" Section I paste some debugging output.

Regards
Guido
======================================================================

----------------------------------------------------------------------
 guido - 01-14-06 23:48 
----------------------------------------------------------------------
So let's resume:

I can now load snd-intel8x0 and snd-intel8x0m at the same time and the
sound
output still is working.
I have a conexant modem chip and a intel ICH6 modem controller.
For the conexant modem chip I will need the hsf codecs from linuxant.
So is the snd-intel8x0m module for any use for my type of hardware
combination?
What can I do with this module?

Regards
Guido

----------------------------------------------------------------------
 pzad - 01-15-06 13:57 
----------------------------------------------------------------------
For you, snd-intel8x0m is not usable.

Yu can delete it, rename, ....

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-05 22:43 guido          New Issue                                    
12-29-05 22:43 guido          Distribution              => Debian "Sarge" with
kernel and alsa from "SID"
12-29-05 22:43 guido          Kernel Version            => 2.6.14          
01-03-06 20:51 guido          Issue Monitored: guido                       
01-07-06 01:56 sashak         Note Added: 0007501                          
01-07-06 01:57 sashak         File Added: ich-cxt30amc-test.patch               
    
01-07-06 01:57 sashak         Note Added: 0007502                          
01-12-06 23:39 guido          File Added: syslog                           
01-12-06 23:40 guido          Note Added: 0007593                          
01-12-06 23:43 guido          Note Edited: 0007593                         
01-13-06 00:21 sashak         Note Added: 0007601                          
01-13-06 10:06 guido          Note Added: 0007636                          
01-13-06 10:15 pzad           Note Added: 0007637                          
01-14-06 23:48 guido          Note Added: 0007657                          
01-15-06 13:57 pzad           Note Added: 0007663                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
