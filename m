From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002235]: ALSA dependent applications
	segfault with 1.0.12rc1!
Date: Tue, 27 Jun 2006 12:01:35 +0200
Message-ID: <4cdad34556aad671e14f9c432520c013@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 35AD9267
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 12:01:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2235> 
======================================================================
Reported By:                quetzyg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2235
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.6.17.1
======================================================================
Date Submitted:             06-27-2006 09:29 CEST
Last Modified:              06-27-2006 12:01 CEST
======================================================================
Summary:                    ALSA dependent applications segfault with 1.0.12rc1!
Description: 
All applications that use ALSA for sound output, segfault after initiated.
If I use OSS emulation instead of ALSA (on applications that support both,
of course), the applications run flawlessly.

Something broke in this new version...

Only OSS compat. lib. is 1.0.11, all the rest (driver, lib and utils) are
1.0.12rc1.

Cheers,
Quetzy Garcia
======================================================================

----------------------------------------------------------------------
 Raymond - 06-27-06 11:03 
----------------------------------------------------------------------
Do you have your own customised dmix in .asoundrc ?

There are some patches related to dmix just before the release of
1.0.12rc1

----------------------------------------------------------------------
 quetzyg - 06-27-06 12:01 
----------------------------------------------------------------------
Here is my asound.conf

pcm.!default            { type                  plug;
                          slave.pcm             "dmix0"; }
ctl.!default            { type hw; card 0; }

pcm.dsp0                { type                  plug;
                          slave.pcm             "dmix0"; }
ctl.dsp0                { type hw; card 0; }
ctl.mixer0              { type hw; card 0; }



pcm.dmix0               { type                  dmix;
                          ipc_key               13759;

                          slave.pcm             "hw:0,0";
                          slave.channels        2;

                          slave.rate            48000;
                          slave.period_size     4096;
                          slave.buffer_size     16384;

                          slave.period_time     84000;
                          slave.buffer_time     340000;

                          # Map only the first two channels
                          bindings.0            0;
                          bindings.1            1; }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-06 09:29 quetzyg        New Issue                                    
06-27-06 09:29 quetzyg        Distribution              => Slackware       
06-27-06 09:29 quetzyg        Kernel Version            => 2.6.17.1        
06-27-06 09:40 Raymond        Note Added: 0010572                          
06-27-06 09:41 Raymond        Note Edited: 0010572                         
06-27-06 09:42 Raymond        Note Edited: 0010572                         
06-27-06 09:44 quetzyg        Note Added: 0010573                          
06-27-06 09:46 Raymond        Note Added: 0010574                          
06-27-06 09:57 quetzyg        Note Added: 0010575                          
06-27-06 10:03 Raymond        Note Added: 0010576                          
06-27-06 10:44 quetzyg        Note Added: 0010577                          
06-27-06 11:03 Raymond        Note Added: 0010578                          
06-27-06 12:01 quetzyg        Note Added: 0010579                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
