From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001728]: Modification of volume control for M-Audio Revolution 5.1
Date: Fri, 27 Jan 2006 15:20:08 +0100
Message-ID: <46f663f75eae6e9e1910d0cc34111159@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA77A1AB
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 15:20:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1728> 
======================================================================
Reported By:                cyan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1728
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               gentoo testing
Kernel Version:             2.6.14-gentoo-r5
======================================================================
Date Submitted:             01-09-2006 23:35 CET
Last Modified:              01-27-2006 15:20 CET
======================================================================
Summary:                    Modification of volume control for M-Audio
Revolution 5.1
Description: 
In Alsamixer (and KMix) is not possible to change volume of both chanels at
once. Slides with names "DAC" and "DAC1" corresponds to left and right
chanel. 
I would like to make a suggestion to merge them together.
======================================================================

----------------------------------------------------------------------
 wollschaf - 01-25-06 00:29 
----------------------------------------------------------------------
I tried my best and came up with the attached patch.

The patch modifies ak4xxx-adda.c that only every second DAC (left channel)
gets a mixer attached (but a stereo one).

snd_akm4xxx_volume_put and snd_akm4xxx_volume_put are now based on the
assumption that the register holding the volume of the right channel is
always one register further than the one for the left channel. I found no
card that works different, but I might as well have not looked properly
enough.

The problem is that the patch applies to all cards that use an ak4xxx DAC.
So if there is a card out there that relies on separate mono DAC mixer
elements, this patch is absolutely evil. It is even more evil for an
uneven number of DACs on the card, i.e a card with 7 DACs will be totally
abused if the volume on this channel is adjusted (whatever there is in
addr+1).

This method works well for the Revolution 5.1; Other Cards should / could
work, too. At least I hope so.

I tested front, center/sub and rear channels.

This is my first patch, so it might as well be not working at all
regarding my use of diff. 
This is also my first real use of c besides some "hello world" and printf
things, and my pascal days are long gone and those were not even glorious.
Better look at everything twice ;)

----------------------------------------------------------------------
 tiwai - 01-27-06 15:20 
----------------------------------------------------------------------
Yes, the idea looks fine for most ice1724 boards, but not nice for some
ice1712 boards which have really independent mono jacks.
So, I'd like to rather allow the driver to select the behavior, whether
mono or stereo controls.

Also, it'd be not difficult to modify the code for driver to pass a static
array of control names including "Front", "Surround", "CLFE", "Side", so
that the mixer elements become more intuitive, too.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-06 23:35 cyan           New Issue                                    
01-09-06 23:35 cyan           Distribution              => gentoo testing  
01-09-06 23:35 cyan           Kernel Version            => 2.6.14-gentoo-r5
01-14-06 22:31 wollschaf      Note Added: 0007656                          
01-25-06 00:07 wollschaf      Issue Monitored: wollschaf                    
01-25-06 00:09 wollschaf      File Added: ak4xxx-adda-stereomixer.patch         
          
01-25-06 00:29 wollschaf      Note Added: 0007776                          
01-27-06 15:20 tiwai          Note Added: 0007804                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
