From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001048]: support for aopen aw850
Date: Tue, 19 Apr 2005 17:30:38 +0200
Message-ID: <5aa5dfb48145a360304f24c657d9d682@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CD0B323A
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 17:30:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1048> 
======================================================================
Reported By:                xaos5
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1048
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.4.29, 2.6.11.6, 2.6.11.7
======================================================================
Date Submitted:             04-12-2005 23:37 CEST
Last Modified:              04-19-2005 17:30 CEST
======================================================================
Summary:                    support for aopen aw850
Description: 
can't get the aopen aw850 stable as it goes to almost complete static after
about a minute or two and crashes knotify. I've tryed updating alsa to
1.0.9rc2 and artsd to latest and kernel to 2.6.11.7 which all help a bit
but never fixed the problem. With alsa only in xmms it takes upto an hour
sometimes for it to become staticy, artsd speeds up the process to about 5
minutes sometimes faster depending on how many programs require audio
output. I know this card isn't in the support list but the chip is
(CMI8738) which should be semi easy to get working with tweaking.
======================================================================

----------------------------------------------------------------------
 xaos5 - 04-18-05 22:36 
----------------------------------------------------------------------
I've been having this problem in alot of different distros so I believe its
within alsa or a setting I need to specify. no matter the program it will
randomly give out static, sometimes not for 10 minutes, other times when
the sound volume of the file is high, most of the time when cpu usage is
high (above 95%) 

Just changed to gentoo 2005.0 and still having the same problem. its
working better with artsd though, but even without artsd its still has
static.

alsaconf detects it find (cmipci) and everything plays find (no errors)
just am getting static.

also the crashes on kde I believe where on part my fault or unstable to
begin with.



----------------------------------------------------------------------
 tiwai - 04-19-05 17:30 
----------------------------------------------------------------------
The static output might mean that the sound device is blocked by another
application (e.g. sound daemon) although multiple ALSA native apps work
with dmix.

If the silence output occurs, check what process is using the device.
For example, you can get the process id via lsof /dev/snd/pcmC0D0p.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-05 23:37 xaos5          New Issue                                    
04-12-05 23:37 xaos5          Distribution              => Slackware       
04-12-05 23:37 xaos5          Kernel Version            => 2.4.29, 2.6.11.6,
2.6.11.7
04-13-05 11:43 tiwai          Note Added: 0004468                          
04-18-05 22:34 xaos5          Note Added: 0004515                          
04-18-05 22:35 xaos5          Note Edited: 0004515                         
04-18-05 22:36 xaos5          Note Edited: 0004515                         
04-19-05 17:30 tiwai          Note Added: 0004521                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
