From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002140]: No sound from mic on Fujitsu
	Siemens Amilo M3438G
Date: Wed, 7 Jun 2006 11:14:32 +0200
Message-ID: <aebac2b41a7bcadff3c1960cbcbc3c01@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5ED9515E
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 11:14:32 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2140> 
======================================================================
Reported By:                jacobs
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2140
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               OpenSuSE 10.1
Kernel Version:             2.6.16.13
======================================================================
Date Submitted:             05-22-2006 10:17 CEST
Last Modified:              06-07-2006 11:14 CEST
======================================================================
Summary:                    No sound from mic on Fujitsu Siemens Amilo M3438G
Description: 
I own a Fujitsu Siemens Amilo M3438G notebook with an onboard Azalia 7.1
SPDIF chipset/codec (see spec sheet at
http://www.fujitsu-siemens.de/ps/db/notebook/ds_amilo_m3438g_m4438g_d.pdf).
OpenSuSE 10.1 (Kernel 2.6.16.13) is installed; the module snd-hda-intel is
 loaded. Sound playback through the internal speakers and headphone does
work but I am unable to get sound from the internal and external
microphone. The alsamixer has three capture controls which all are set to
capture and maximum volume. Each capture controls source is set to mic.
The playback channel for mic is unmuted and also set to maximum volume but
I just don't get a signal.

I've tried to apply different model options to the snd-hda-intel module
relating to the file ALSA-Configuration.txt without luck.

This didn't work with OpenSuSE 10.0 (Kernel 2.6.13) either.

If you need any technical information please let me know.
======================================================================

----------------------------------------------------------------------
 jacobs - 05-29-06 08:26 
----------------------------------------------------------------------
Hello el,

I've tried that but it doesn't give satisfying results. First of all the
channels are assigned falsely, e.g. Front is actually the headphone. At
least they were correct when I didn't pass model=auto to the module.

Secondly I only get a signal from the microphone when I shout into it
(=when it's loud) plus the sound quality is pretty bad.

----------------------------------------------------------------------
 der_sprengmeister - 06-07-06 11:14 
----------------------------------------------------------------------
Hello jacobs.

Have you looked at my thread:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2167

I have a solution fot the wrong mixer. It would be nice, if you could
proof the inputs, because I have no microphones here

Bye!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 10:17 jacobs         New Issue                                    
05-22-06 10:17 jacobs         Distribution              => OpenSuSE 10.1   
05-22-06 10:17 jacobs         Kernel Version            => 2.6.16.13       
05-23-06 07:35 jacobs         Issue Monitored: jacobs                      
05-26-06 19:13 el             Issue Monitored: el                          
05-26-06 19:26 el             Note Added: 0009979                          
05-29-06 08:26 jacobs         Note Added: 0010007                          
06-07-06 11:14 der_sprengmeisterNote Added: 0010079                          
======================================================================
