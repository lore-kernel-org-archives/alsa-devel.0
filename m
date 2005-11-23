From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001510]: ac97 with SiS SI7012 [ALC203 rev 0] doesn't allow to control volume by master channel, PCM and headphones work
Date: Wed, 23 Nov 2005 17:31:16 +0100
Message-ID: <8d44a3b460d27db68fe270e1eabb350b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 24AE81B1
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 17:31:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1510> 
======================================================================
Reported By:                wiktorw
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1510
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo 2005.1
Kernel Version:             2.6.13-gentoo-r4
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             10-28-2005 17:54 CEST
Last Modified:              11-23-2005 17:31 CET
======================================================================
Summary:                    ac97 with SiS SI7012 [ALC203 rev 0] doesn't allow to
control volume by master channel, PCM and headphones work
Description: 
On my Acer Aspire 5002LM laptop I have the following problem:
- Master channel does not control volume level (no matter if I slide it or
mute)
- PCM channel works
- Headphone/PCM-2 channel works

The Master/PCM/Headphone channels are for the "SiS SI7012 (Alsa Mixer)"
device, while Volume/PCM/PCM-2 channels are for the "Realtek ALC203 rev 0
(OSS Mixer)" device. They do the same thing: Master/Volume control in
gnome-volume-control applet doesn't change the volume level.

At first I thought that this problem is software-related, but in fact it
isn't. Now I have tested several things and all give me the same result. I
also suspect that not only I have such problems, althought the original
posters might not be aware of it. See here for the original discussion:

http://forums.gentoo.org/viewtopic-t-387739.html

======================================================================

----------------------------------------------------------------------
 garfungiloops - 11-20-05 11:41 
----------------------------------------------------------------------
Since I have cmedia codec, softvol has fixed the problem for me.

----------------------------------------------------------------------
 tiwai - 11-23-05 17:31 
----------------------------------------------------------------------
Closing this bug since the original reporter found a solution.

If a similar problem happens with a _different_ codec, please open another
bug report.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-28-05 17:54 wiktorw        New Issue                                    
10-28-05 17:54 wiktorw        Distribution              => Gentoo 2005.1   
10-28-05 17:54 wiktorw        Kernel Version            => 2.6.13-gentoo-r4
10-30-05 09:35 garfungiloops  Note Added: 0006573                          
10-30-05 09:36 garfungiloops  Issue Monitored: garfungiloops                    
11-08-05 08:44 mrblur         Note Added: 0006619                          
11-08-05 17:45 tiwai          Note Added: 0006626                          
11-08-05 19:37 garfungiloops  Note Added: 0006640                          
11-08-05 19:41 garfungiloops  Note Added: 0006641                          
11-09-05 15:23 wiktorw        Note Added: 0006654                          
11-09-05 15:27 wiktorw        Note Added: 0006655                          
11-12-05 11:33 froztbyte      Issue Monitored: froztbyte                    
11-17-05 13:25 mrblur         Issue Monitored: mrblur                      
11-20-05 11:41 garfungiloops  Note Added: 0006765                          
11-23-05 17:31 tiwai          Status                   new => resolved     
11-23-05 17:31 tiwai          Resolution               open => not an issue
11-23-05 17:31 tiwai          Assigned To               => tiwai           
11-23-05 17:31 tiwai          Note Added: 0006815                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
