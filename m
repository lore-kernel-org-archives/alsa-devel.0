From: noreply@alsa-project.org
Subject: [ALSA - driver 0000315]: No option to enable SP/DIF in Fedora Core 2
Date: Fri, 16 Jul 2004 12:05:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716100502.6D1F126009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B7ACB254
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:05:02 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000315
======================================================================
Reported By:                sehh
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     315
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core 2
Kernel Version:             2.6.5-1.358
======================================================================
Date Submitted:             05-30-2004 17:10 CEST
Last Modified:              07-16-2004 12:05 CEST
======================================================================
Summary:                    No option to enable SP/DIF in Fedora Core 2
Description: 
We can't find any way to enable SP/DIF in Fedora Core 2.

We are using the Asus A7V600 with the AD1980 chipset.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-30-2004 15:47 CEST 
----------------------------------------------------------------------
There is no module option for spdif.
You just need to specify the correct PCM name "iec958" or "spdif".

----------------------------------------------------------------------
 sehh - 07-01-2004 05:39 CEST 
----------------------------------------------------------------------
There is no 'spdif' pcm name, but there are a few "IEC958" which have
no effect here, even though they seem to be enabled and with volume at
100%:

Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%]
Simple mixer control 'IEC958 Playback Source',0
  Capabilities:
  Mono:


Any suggestions please on how to enable spdif output?

Thank you.

----------------------------------------------------------------------
 tiwai - 07-16-2004 12:05 CEST 
----------------------------------------------------------------------
You seem to be confused.

On ALSA, you need to access to the certain PCM for accessing
the SPDIF properly, for example,

    % aplay -Diec958 foo.wav

You don't need to touch 'IEC958*' stuff on the mixer in general.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-30-04 17:10 sehh           New Bug                                      
05-30-04 17:10 sehh           Distribution              => Fedora Core 2   
05-30-04 17:10 sehh           Kernel Version            => 2.6.5-1.358     
06-30-04 15:47 tiwai          Bugnote Added: 0001352                       
06-30-04 15:47 tiwai          Assigned To               => tiwai           
06-30-04 15:47 tiwai          Resolution               open => not a bug   
06-30-04 15:47 tiwai          Status                   new => resolved     
07-01-04 05:39 sehh           Bugnote Added: 0001368                       
07-01-04 05:39 sehh           Resolution               not a bug => reopened
07-01-04 05:39 sehh           Status                   resolved => feedback
07-16-04 12:05 tiwai          Bugnote Added: 0001445                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
