From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002140]: No sound from mic on Fujitsu
	Siemens Amilo M3438G
Date: Fri, 26 May 2006 19:26:08 +0200
Message-ID: <259b3c5c1040f8d6b87adc3bc8cb0223@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E37A3EB
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 19:26:08 +0200 (MEST)
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
Last Modified:              05-26-2006 19:26 CEST
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
 el - 05-26-06 19:26 
----------------------------------------------------------------------
Hi, I experienced the same Problem with my M3438G. I was running Kubuntu
Breezy, Kubuntu Dapper and Kanotix als well as ALSA 1.0.10, 1.0.11rcX and
1.0.11. When I load the module without any additional parameters "cat
/sys/module/snd_hda_intel/parameters/model" returns "<NULL>", don't know
if this behavior is expected or not. 

Then I tried passing model=fujitsu and such, but couldn't get the
microphone to work. But when I tried model=auto (Should be the default
according to the documentation, but obviously it isn't) I got it to work
by turning up the leftmost capture control an setting it's input source to
Front Mic. 

I still got some high pitched noise in the background of any recording
when using Ubuntu Breezy, but that seems to be a different Problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-22-06 10:17 jacobs         New Issue                                    
05-22-06 10:17 jacobs         Distribution              => OpenSuSE 10.1   
05-22-06 10:17 jacobs         Kernel Version            => 2.6.16.13       
05-23-06 07:35 jacobs         Issue Monitored: jacobs                      
05-26-06 19:13 el             Issue Monitored: el                          
05-26-06 19:26 el             Note Added: 0009979                          
======================================================================
