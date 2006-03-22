From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000833]: [snd_via82xx] setting ac97_clock greater than 48000 should be ?ignored? but breaks sound output for kernels >= linux-2.6.9
Date: Wed, 22 Mar 2006 03:04:45 +0100
Message-ID: <8a165d22f1fcdd8981ad4ac76d47632d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9745B1A1
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:04:45 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=833> 
======================================================================
Reported By:                t35t0r
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   833
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               gentoo
Kernel Version:             2.6.10-gentoo-r5 (but error is reproducible in stock
kernels also)
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-18-2005 17:35 CET
Last Modified:              03-22-2006 03:04 CET
======================================================================
Summary:                    [snd_via82xx] setting ac97_clock greater than 48000
should be ?ignored? but breaks sound output for kernels >= linux-2.6.9
Description: 
Please read: http://bugs.gentoo.org/show_bug.cgi?id=78327

Forwarded email below

From: Jaroslav Kysela <perex@suse.cz>
To: t35t0r@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>
Date: Tue, 18 Jan 2005 10:40:56 +0100 (CET)
Subject: Re: snd_via82xx ac97_clock=96000 parameter doesn't work for
kernels >= linux-2.6.9 (fwd)

> > Dear sir:
> >
> > If you get a chance can you look at
> > http://bugs.gentoo.org/show_bug.cgi?id=78327 . It seems that setting
> > ac97_clock=96000 no longer works for kernels >= linux-2.6.9. I didn't
> > try any other ac97_clock settings since the 96000 setting was working
> > for a 2.6.7 and 2.6.8.1 kernel. The url has some of my hardware
> > specifications.

It seems that the no-sound bug is caused with the AC'97 codec
initialization. Specifying 96000 as ac97_clock parameter won't help,
because this value must be from 8000 to 48000 otherwise it is ignored.
Please, fill a bug to our bugtrack system.

                                               Jaroslav
======================================================================

----------------------------------------------------------------------
 perex - 08-04-05 09:15 
----------------------------------------------------------------------
To confirm: Does the driver work without using ac97_clock parameter?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:04 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-18-05 17:35 t35t0r         New Issue                                    
01-18-05 17:35 t35t0r         Distribution              => gentoo          
01-18-05 17:35 t35t0r         Kernel Version            => 2.6.10-gentoo-r5 (but
error is reproducible in stock kernels also)
01-18-05 17:44 tiwai          Note Added: 0003252                          
07-22-05 02:46 connolly       Note Added: 0005544                          
08-04-05 09:15 perex          Note Added: 0005642                          
03-22-06 03:04 rlrevell       Status                   new => closed       
03-22-06 03:04 rlrevell       Note Added: 0008793                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
