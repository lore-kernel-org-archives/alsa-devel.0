From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001716]: aoss not working with audacity
Date: Fri, 7 Jul 2006 08:43:22 +0200
Message-ID: <e6be4b97904486f128c0c713cc62edaf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 96D12263
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 08:43:22 +0200 (MEST)
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
Last Modified:              07-07-2006 08:43 CEST
======================================================================
Summary:                    aoss not working with audacity
Description: 
Following up from a recent LKML thread, I'm going to report a number of
aoss incompatibilities with softwares on Linux.

First up is audacity, which has no ALSA port. snd-pcm/mixer-oss aren't
loaded.

======================================================================

----------------------------------------------------------------------
 ajs1984 - 06-09-06 10:04 
----------------------------------------------------------------------
It's a bug _in aoss_. My soundcard is an Audidy 2 Platinum, I'm fairly sure
that isn't the problem.

----------------------------------------------------------------------
 Raymond - 07-07-06 08:43 
----------------------------------------------------------------------
It seem that playback device and capture device support different format.

snd_emu10k1_playback
.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,

snd_emu10k1_capture
.formats =		SNDRV_PCM_FMTBIT_S16_LE,

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
06-09-06 10:04 ajs1984        Note Added: 0010135                          
06-09-06 11:01 Raymond        Note Added: 0010138                          
06-10-06 13:27 Raymond        Note Added: 0010145                          
07-07-06 05:30 Raymond        Note Deleted: 0010138                        
07-07-06 08:40 Raymond        Note Deleted: 0010145                        
07-07-06 08:43 Raymond        Note Added: 0010897                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
