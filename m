From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000833]: [snd_via82xx] setting ac97_clock greater than 48000 should be ?ignored? but breaks sound output for kernels >= linux-2.6.9
Date: Tue, 18 Jan 2005 17:44:47 +0100
Message-ID: <1511e327528c077f9354951f9baaf917@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 366F3220
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 17:44:47 +0100 (MET)
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
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.10-gentoo-r5 (but error is reproducible in stock
kernels also)
======================================================================
Date Submitted:             01-18-2005 17:35 CET
Last Modified:              01-18-2005 17:44 CET
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
 tiwai - 01-18-05 17:44 
----------------------------------------------------------------------
I guess your problem has nothing to do with ac97_clock.  Setting
ac97_clock=96000 is simply wrong.  If this really works, then something
else is broken...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-18-05 17:35 t35t0r         New Issue                                    
01-18-05 17:35 t35t0r         Distribution              => gentoo          
01-18-05 17:35 t35t0r         Kernel Version            => 2.6.10-gentoo-r5 (but
error is reproducible in stock kernels also)
01-18-05 17:44 tiwai          Note Added: 0003252                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
