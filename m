From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002287]: Segfaults all functions after
	snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t
	*) & val);
Date: Tue, 18 Jul 2006 14:21:09 +0200
Message-ID: <06e582a998dc69d18a8320c6d43147b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88AD9162
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:21:09 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2287> 
======================================================================
Reported By:                cruiseoveride
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2287
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-16-2006 18:03 CEST
Last Modified:              07-18-2006 14:21 CEST
======================================================================
Summary:                    Segfaults all functions after
snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t *) & val);
Description: 
I am new to Alsa and am not happy at all at the state of documentation
available.
You guys seriously need to do something about this.

I have an M-Audio Audiophile Delta 192 (ICE1724) and I want to port
envy24control for this chip, However I first need to familiar myself with
the ALSA API. So I began by looking for simple examples on how to use ALSA
API and came accross the followinf prog (Attached file test.c).

The program compiles cleanly with gcc-4.1 and runs, however after it
prints out the ..."buffer size = 8192 frames"
It segfaults.

If you slash out line 104, it resolves the issue.

My question is,

Is there a bug in this function?
Code was obtained from http://www.linuxjournal.com/article/6735
======================================================================

----------------------------------------------------------------------
 Raymond - 07-18-06 07:44 
----------------------------------------------------------------------
The functions list of alsa-lib control interface is hidden in

http://www.alsa-project.org/alsa-doc/alsa-lib/group___control.html

snd_ctl_elem_value_get_integer(peaks, x) return the value of item 'x' of
the kcontrol 'peak'

Modify the hardware specific check for 'ICE1712' may let you run the
envy24control

----------------------------------------------------------------------
 cruiseoveride - 07-18-06 14:21 
----------------------------------------------------------------------
ive got it runnig!!!
But...
I can only seem to monitor the Main RCA OUT Line.
Its not able to detect the number of Input Channels properly nor the
Output Channels...

Ok i understood the peak thing.

how to i put sample data inro the capture of the card to see which peak
control is  for which line? at the moment i just 

cat junk > /dev/dsp1

for sample data to monitor output levels

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-06 18:03 cruiseoveride  New Issue                                    
07-16-06 18:03 cruiseoveride  File Added: test.c                           
07-16-06 20:38 cruiseoveride  Issue Monitored: cruiseoveride                    
07-17-06 02:44 Raymond        Note Added: 0011032                          
07-17-06 02:47 Raymond        Note Edited: 0011032                         
07-17-06 03:18 Raymond        Note Edited: 0011032                         
07-17-06 05:45 cruiseoveride  Note Added: 0011033                          
07-17-06 05:46 cruiseoveride  Note Edited: 0011033                         
07-17-06 07:31 Raymond        Note Added: 0011035                          
07-17-06 08:23 Raymond        Note Added: 0011036                          
07-17-06 08:26 Raymond        Note Edited: 0011036                         
07-17-06 14:48 cruiseoveride  Note Added: 0011039                          
07-17-06 14:59 cruiseoveride  Note Added: 0011040                          
07-17-06 16:07 Raymond        Note Added: 0011042                          
07-17-06 16:31 Raymond        Note Edited: 0011042                         
07-17-06 16:40 cruiseoveride  Note Added: 0011044                          
07-17-06 17:13 cruiseoveride  Note Added: 0011045                          
07-17-06 17:34 Raymond        Note Added: 0011046                          
07-17-06 17:56 cruiseoveride  Note Added: 0011047                          
07-18-06 07:44 Raymond        Note Added: 0011053                          
07-18-06 14:21 cruiseoveride  Note Added: 0011057                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
