From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002287]: Segfaults all functions after
	snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t
	*) & val);
Date: Mon, 17 Jul 2006 08:23:05 +0200
Message-ID: <d0d7c88d7b75ed05f2c4c4a055647ed4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 18A30219
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 08:23:06 +0200 (MEST)
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
Last Modified:              07-17-2006 08:23 CEST
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
 Raymond - 07-17-06 07:31 
----------------------------------------------------------------------
Some of the functions seem out-dated.

snd_pcm_hw_params_get_periods (params, &val, &dir);	
snd_pcm_hw_params_get_rate_numden (params, &val, &val2);


http://www.alsa-project.org/alsa-doc/alsa-lib/examples.html

Can you run alsa-lib examples ?

pcm.c, pcm_min.c and latency.c

The alsa-lib control inteface api

http://www.alsa-project.org/alsa-doc/alsa-lib/group___h_control.html

alsa-tool  (e.g. envy24control, echomixer, hdspmixer, ..)

http://hg-mirror.alsa-project.org/alsa-tools?cmd=manifest;manifest=c27094158cad02342671bd5e0f70ed5bdec84ef3;path=/;style=gitweb

alsa-driver control api

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c843.htm

ice1712/ice1724 driver code

http://hg-mirror.alsa-project.org/alsa-kernel?mf=a7ac5a5c1e51;path=/pci/ice1712/;style=gitweb

----------------------------------------------------------------------
 Raymond - 07-17-06 08:23 
----------------------------------------------------------------------
Even the most common format(S16_LE, 2 channels) may fail on some specific
sound card when using 'hw'.

Make sure that there is no error when calling snd_pcm_hw_params_set_xxx()

snd_pcm_hw_params_set_access()
snd_pcm_hw_params_set_format();
snd_pcm_hw_params_set_channels();
snd_pcm_hw_params_set_rate_near();

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
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
