From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000557]: SNDCTL_DSP_GETOPTR not working correctly in specific situation
Date: Tue, 31 May 2005 17:39:52 +0200
Message-ID: <12bc33b8122121784da8f6d5f48f8b74@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 197DB1AB
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 17:39:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=557> 
======================================================================
Reported By:                minmax
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   557
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.7
======================================================================
Date Submitted:             10-01-2004 16:18 CEST
Last Modified:              05-31-2005 17:39 CEST
======================================================================
Summary:                    SNDCTL_DSP_GETOPTR not working correctly in specific
situation
Description: 
When the first few writes to the oss emulation device are done in specific
way, SNDCTL_DSP_GETOPTR returns wrongly huge results in info.bytes
======================================================================

----------------------------------------------------------------------
 perex - 05-31-05 17:18 
----------------------------------------------------------------------
Nice situation :-) Two patches in one moment....

Takashi, I think that your patch  pcm-oss-ptr-fix4.diff is not correct,
because info.blocks should count all buffered data from application (I may
be wrong of course).

----------------------------------------------------------------------
 tiwai - 05-31-05 17:39 
----------------------------------------------------------------------
I'm really puzzled what's the correct implementation of blocks.
And, yes, my patch isn't correct anyway for blocks field, but the current
implementation seems also wrong, too.

Looking at the other OSS/free codes, the blocks field contains basically
(snd_pcm_avail() / fragsize).  That is, for playback, the empty space on
the ring buffer / fragsize.

So, it should be like

    info.blocks = (runtime->oss.buffer_bytes - frames_to_bytes(delay) -
fixup) / runtime->oss.period_bytes;

for playback.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-01-04 16:18 minmax         New Issue                                    
10-01-04 16:18 minmax         Distribution              => Debian unstable 
10-01-04 16:18 minmax         Kernel Version            => vanilla 2.6.7   
10-02-04 10:52 minmax         Issue Monitored: minmax                      
04-09-05 16:09 jdthood        Note Added: 0004406                          
04-09-05 16:22 minmax         Note Added: 0004410                          
05-13-05 15:20 gk4            Note Added: 0004646                          
05-13-05 15:24 perex          Note Added: 0004647                          
05-13-05 15:26 tiwai          Note Added: 0004648                          
05-13-05 19:35 gk4            Note Added: 0004651                          
05-13-05 19:38 tiwai          Note Added: 0004652                          
05-13-05 19:48 gk4            Note Added: 0004655                          
05-15-05 15:50 tiwai          Note Added: 0004663                          
05-16-05 16:08 gk4            Note Added: 0004676                          
05-19-05 15:28 parente        Note Added: 0004693                          
05-20-05 00:38 minmax         Note Added: 0004698                          
05-26-05 17:27 Roger Mach     Note Added: 0004738                          
05-27-05 10:56 perex          Note Added: 0004742                          
05-27-05 11:03 perex          File Added: fix2.patch                       
05-27-05 11:04 perex          Note Added: 0004743                          
05-27-05 15:41 parente        Note Added: 0004752                          
05-30-05 09:51 perex          Note Added: 0004798                          
05-31-05 14:04 parente        Note Added: 0004831                          
05-31-05 15:54 perex          Status                   new => assigned     
05-31-05 15:54 perex          Assigned To               => perex           
05-31-05 15:55 perex          Note Added: 0004833                          
05-31-05 16:10 parente        Note Added: 0004834                          
05-31-05 16:38 perex          File Added: oss-optr-fix3.patch                   

05-31-05 16:41 perex          Note Added: 0004837                          
05-31-05 16:55 tiwai          Note Added: 0004838                          
05-31-05 16:56 parente        Note Added: 0004839                          
05-31-05 17:02 parente        Note Edited: 0004839                         
05-31-05 17:13 tiwai          Note Added: 0004840                          
05-31-05 17:13 perex          File Added: oss-optr-fix4.patch                   

05-31-05 17:13 tiwai          File Added: pcm-oss-ptr-fix4.diff                 
  
05-31-05 17:14 perex          Note Added: 0004841                          
05-31-05 17:18 perex          Note Added: 0004842                          
05-31-05 17:39 tiwai          Note Added: 0004843                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
