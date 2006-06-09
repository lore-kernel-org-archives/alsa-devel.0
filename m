From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001716]: aoss not working with audacity
Date: Fri, 9 Jun 2006 07:01:39 +0200
Message-ID: <2d7a8aab33a0717fbc3fd2f02dc364a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 031C7176
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 07:01:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1716> 
======================================================================
Reported By:                ajs1984
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1716
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-04-2006 23:04 CET
Last Modified:              06-09-2006 07:01 CEST
======================================================================
Summary:                    aoss not working with audacity
Description: 
Following up from a recent LKML thread, I'm going to report a number of
aoss incompatibilities with softwares on Linux.

First up is audacity, which has no ALSA port. snd-pcm/mixer-oss aren't
loaded.

======================================================================

----------------------------------------------------------------------
 Raymond - 06-08-06 02:43 
----------------------------------------------------------------------
aoss / OSS emulation should also work for audacity-1.2.4b

However some ALSA driver may need to specify period size by export
PA_ALSA_PERIODSIZE when audacity is using ALSA device hw

Which ALSA driver are you using ?



----------------------------------------------------------------------
 Raymond - 06-09-06 07:01 
----------------------------------------------------------------------
> Pa_SetLatency: could not SNDCTL_DSP_SETFRAGMENT
> Pa_SetLatency: numBuffers = 2, framesPerBuffer = 512, powerOfTwo = 11
> Pa_SetupDeviceFormat: could not SNDCTL_DSP_SETFMT

Which sound card are you using ?

It seem that your sound card does not support the specified format

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 23:04 ajs1984        New Issue                                    
01-04-06 23:06 ajs1984        Note Added: 0007457                          
01-04-06 23:06 ajs1984        Note Added: 0007458                          
06-07-06 15:06 Raymond        Note Added: 0010082                          
06-07-06 15:29 ajs1984        Note Added: 0010083                          
06-07-06 15:41 Raymond        Note Added: 0010084                          
06-08-06 02:41 Raymond        Note Edited: 0010084                         
06-08-06 02:42 Raymond        Note Edited: 0010084                         
06-08-06 02:43 Raymond        Note Edited: 0010084                         
06-09-06 07:01 Raymond        Note Added: 0010133                          
======================================================================
