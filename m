From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002287]: Segfaults all functions after
	snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t
	*) & val);
Date: Mon, 17 Jul 2006 17:56:58 +0200
Message-ID: <54f9b00aee192a0a670177a2b6d4351e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7EC4A10D
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 17:56:58 +0200 (MEST)
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
Last Modified:              07-17-2006 17:56 CEST
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
 Raymond - 07-17-06 17:34 
----------------------------------------------------------------------
I don't have any ice17xx card

iec958 playback control is well defined but iec958 capture control is not
...

alsa-lib/include/asoundef.h

Refer to ice1724.c, 'Multi Track Peak' is a kcontrol with 22 values (min=0
and max=255) as same as ice1712.c in alsa-driver-1.0.12rc1

alsactl store test.state

The difficult part is to know the difference between different sound cards
using ice1724.

----------------------------------------------------------------------
 cruiseoveride - 07-17-06 17:56 
----------------------------------------------------------------------
ok cool.
the level meters function looks like this on the envy24control
(levelmeters.c)

void level_meters_init(void)
{
        snd_ctl_elem_value_malloc(&peaks);
        snd_ctl_elem_value_set_interface(peaks,
SND_CTL_ELEM_IFACE_MIXER);
        snd_ctl_elem_value_set_name(peaks, "Multi Track Peak");
}

and the get levels looks like this

static void get_levels(int idx, int *l1, int *l2)
{
        *l1 = *l2 = 0;

        if (idx == 0) {
                *l1 = snd_ctl_elem_value_get_integer(peaks, 20);
                *l2 = snd_ctl_elem_value_get_integer(peaks, 21);
        } else {
                *l1 = *l2 = snd_ctl_elem_value_get_integer(peaks, idx -
1);
        }
}

the 20, and 21 are indexes ? are they the same as numids that amixer
ouputs if so than these refer to

numid=20,iface=MIXER,name='DAC Volume'
numid=21,iface=MIXER,name='DAC Volume',index=1
[from:ice1712]

how do u seperate the multi track peak, or do i have to parse it.

[vikky@server ~]$ amixer -c 2 cget numid=5
numid=5,iface=MIXER,name='Multi Track Peak'
  ; type=INTEGER,access=r----,values=22,min=0,max=255,step=0
  : values=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
[from:ice1724]

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
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
