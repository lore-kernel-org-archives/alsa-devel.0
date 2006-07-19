From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002287]: Segfaults all functions after
	snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t
	*) & val);
Date: Wed, 19 Jul 2006 02:52:51 +0200
Message-ID: <c19b347167b634c188d464afcf8b16b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B223A242
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 02:52:51 +0200 (MEST)
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
Last Modified:              07-19-2006 02:52 CEST
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
 Raymond - 07-18-06 14:35 
----------------------------------------------------------------------
cat /proc/asound/cards

cat /proc/asound/pcm

lspci -vn

----------------------------------------------------------------------
 cruiseoveride - 07-19-06 02:52 
----------------------------------------------------------------------
its great that ur helping me ray,
but eash post i ask u at least 3 different things, u only seem to see the
last one in each case...

[vikky@server asound]$ cat cards
 0 [ALS4000        ]: ALS4000 - Avance Logic ALS4000
                      Avance Logic ALS4000 at 0x7000, irq 82
 1 [ICE1724        ]: ICE1724 - ICEnsemble ICE1724
                      ICEnsemble ICE1724 at 0x7400, irq 66
 2 [CK804          ]: NFORCE - NVidia CK804
                      NVidia CK804 with ALC850 at 0xd5003000, irq 233
[vikky@server asound]$ cat pcm
00-00: ALS4000 DSP :  : playback 1 : capture 1
01-01: IEC1724 IEC958 : IEC1724 IEC958 : playback 1 : capture 1
01-00: ICE1724 : ICE1724 : playback 1 : capture 1
02-02: Intel ICH - IEC958 : NVidia CK804 - IEC958 : playback 1
02-01: Intel ICH - MIC ADC : NVidia CK804 - MIC ADC : capture 1
02-00: Intel ICH : NVidia CK804 : playback 1 : capture 1
[vikky@server asound]$

The card physically has 3 outs
S/P DIF 
Main Out - (1/4' TRS) seperate left and right
Monitor Out - (1/4' TRS) seperate left and right

it has 2 ins
S/PDIR in
In - (1/4' TRS) both left and right

Question 1
---------------
Please could u answer  this question.
from
amixer -c 2 cget numid=5
numid=5,iface=MIXER,name='Multi Track Peak'
  ; type=INTEGER,access=r----,values=22,min=0,max=255,step=0
  : values=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
which value is what?
when i play something , the first two (1,2) start jumping up and down and
peaking at 255. wat do the others do? As they dont change at all.


Question 2
---------------
How to push noise into the capture interfaces to check monitor levels?

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
07-18-06 14:35 Raymond        Note Added: 0011060                          
07-19-06 02:52 cruiseoveride  Note Added: 0011075                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
