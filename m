From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002287]: Segfaults all functions after
	snd_pcm_hw_params_get_buffer_size (params,(snd_pcm_uframes_t
	*) & val);
Date: Mon, 17 Jul 2006 16:07:15 +0200
Message-ID: <a4910ca05655696ebab324fcbe8d554f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 81C98169
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 16:07:15 +0200 (MEST)
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
Last Modified:              07-17-2006 16:07 CEST
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
 cruiseoveride - 07-17-06 14:59 
----------------------------------------------------------------------
by the way, thanks ray for the links, even though ALSA API is as colourful
(descriptive)  as bleach.
You guys really need to put up some small code snippets with each
function, to show how its used. Like with the Gtk API
http://www.gtk.org/api/2.6/gtk/GtkFileChooser.html

Otherwise god only knows wat the hell a HCTL is.
Function prototypes alone are too cryptic to understand what they are
doing. Give us some examples please and not 100+ linex, just a little
snippet.

ok anyways, back to topic.
the output of 
[vikky@server ~]$ amixer  -c2 contents
numid=1,iface=CARD,name='ICE1724 EEPROM'
  ; type=BYTES,access=r----,values=52
  :
values=0x36,0x32,0x14,0x12,0x13,0x02,0x68,0x80,0xf8,0xc3,0xba,0xff,0x7f,0x45
,0x00,0x00,0xb5,0x00,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x45,0x00,0x00,0x00,0xb5,0x00
,0x40,0x00,0xba,0xff,0x7f,0x00
numid=6,iface=MIXER,name='IEC958 Playback Route'
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item #0 'PCM Out'
  ; Item #1 'H/W In 0'
  ; Item #2 'H/W In 1'
  ; Item #3 'IEC958 In L'
  ; Item #4 'IEC958 In R'
  : values=0
numid=7,iface=MIXER,name='IEC958 Playback Route',index=1
  ; type=ENUMERATED,access=rw---,values=1,items=5
  ; Item #0 'PCM Out'
  ; Item #1 'H/W In 0'
  ; Item #2 'H/W In 1'
  ; Item #3 'IEC958 In L'
  ; Item #4 'IEC958 In R'
  : values=2
numid=8,iface=MIXER,name='IEC958 Output Switch'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=2,iface=MIXER,name='Multi Track Internal Clock'
  ; type=ENUMERATED,access=rw---,values=1,items=16
  ; Item #0 '8000'
  ; Item #1 '9600'
  ; Item #2 '11025'
  ; Item #3 '12000'
  ; Item #4 '16000'
  ; Item #5 '22050'
  ; Item #6 '24000'
  ; Item #7 '32000'
  ; Item #8 '44100'
  ; Item #9 '48000'
  ; Item #10 '64000'
  ; Item #11 '88200'
  ; Item #12 '96000'
  ; Item #13 '176400'
  ; Item #14 '192000'
  ; Item #15 'IEC958 Input'
  : values=13
numid=5,iface=MIXER,name='Multi Track Peak'
  ; type=INTEGER,access=r----,values=22,min=0,max=255,step=0
  : values=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
numid=3,iface=MIXER,name='Multi Track Rate Locking'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=4,iface=MIXER,name='Multi Track Rate Reset'
  ; type=BOOLEAN,access=rw---,values=1
  : values=on
numid=10,iface=PCM,name='IEC958 Playback Con Mask',device=1
  ; type=IEC958,access=r----,values=1
  : values=?
numid=9,iface=PCM,name='IEC958 Playback Default',device=1
  ; type=IEC958,access=rw---,values=1
  : values=?
numid=11,iface=PCM,name='IEC958 Playback Pro Mask',device=1
  ; type=IEC958,access=r----,values=1
  : values=?
[vikky@server ~]$

wat does "?" mean for the values of numids 10,9,11

My methodology for porting envy24control was to first hack amixer to get
familar with how to set parameters on the card and then brute force attack
envy24control into ice24control.

I have tried to email  Jaroslav Kysela <perex@suse.cz> but with no
response. Do you have any ideas on which file to break first, i was
thinking evy24control.c?

----------------------------------------------------------------------
 Raymond - 07-17-06 16:07 
----------------------------------------------------------------------
The functions snd_ctl_*() in alsa-lib/src/control/control.c is much easier
to use than snd_hctl_*() alsa-lib/src/control/hcontrol.c

If you know gtk2 well, it is much easier to hack envy24control.c instead
of study amixer.c or alsamixer.c

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
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
