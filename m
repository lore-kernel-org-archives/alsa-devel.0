From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001824]: Always mixed into one channel when recording stereo
Date: Sat, 25 Mar 2006 06:53:44 +0100
Message-ID: <d73ed4c69ce4abf71def83edc91e3f50@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9C15618B
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 06:53:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1824> 
======================================================================
Reported By:                Electro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1824
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r4
======================================================================
Date Submitted:             02-06-2006 06:56 CET
Last Modified:              03-25-2006 06:53 CET
======================================================================
Summary:                    Always mixed into one channel when recording stereo
Description: 
When recording stereo audio (2 channels), the sound seems to mix to one
channel and then saved in the left track. I do not have anything in
asound.conf or ~/.asoundrc that will affect the recordings. I even cleared
them out to make sure that my code is not screwing up the recordings. It
has done this since I upgraded to 1.0.10 from 1.0.9. I thought 1.0.11rc3
will fix the problem but it still does it.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001527 amixer fails to set right 'Capture Sour...
======================================================================

----------------------------------------------------------------------
 ungod - 03-21-06 16:48 
----------------------------------------------------------------------
1.
Have you tried the patch from bug 1527 or the very latest CVS (21 hours
old)?

2.
Have you tried CD, Aux, or Mic as capture source?

3.
I really need you to verify with that the command:

$ amixer cset name="Capture Source" 2,2

produces the output:

numid=36,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=5
  ; Item #0 'CD'
  ; Item #1 'Aux'
  ; Item #2 'Line'
  ; Item #3 'Mic'
  ; Item #4 'AC97'
  : values=2,2

In this regard, the last line if the most important. It clarifies whether
the driver did indeed set the capture source correctly. (As mention in
1527, there are some flaws here)

4.
As a last resort, you may try loading the snd-ice1724 module with the
model=universe argument, and then try all record sources there (Unlike
aureon  space and prodigy 7.1, this model have 8 record sources)


As a final note, I saw that the initialization process for prodigy 7.1
differ from the aureon init process in a few ways:

* CD is selected as record source by default
* Front channels are not mixed with AC'97 output

The last point made me wonder whether you are actually capable of hearing
the line in while listening to digital audio?



----------------------------------------------------------------------
 Electro - 03-25-06 06:53 
----------------------------------------------------------------------
1) No
2) Nope. At the time I have not had the need to record from Mic, Aux, and
CD-ROM. I use DAE to play audio CD. For the tests below I deactivate DAE
in xmms for the tests below.
3) It states the value as 2,2 but it still records only the left channel.
I can always listen from Line in and play a PCM stream. 
4) When I pass model=universe to the snd-ice1724 module, recording stereo
through Line in and CD-ROM works. The cset values for each input is as
follows.

:: CD-ROM ::
$ amixer cset name="Capture Source" 0,0
numid=36,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Aux1'
  ; Item #1 'CD'
  ; Item #2 'Phono'
  ; Item #3 'Line'
  ; Item #4 'Aux2'
  ; Item #5 'Mic'
  ; Item #6 'Aux3'
  ; Item #7 'AC97'
  : values=0,0
The Phono mix control have to be unmuted and its volume have to be
adjusted in order for the CD-ROM to be heard. Adjusting CD-ROM mix control
does not work.


:: Line In ::
$ amixer cset name="Capture Source" 2,2
numid=36,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Aux1'
  ; Item #1 'CD'
  ; Item #2 'Phono'
  ; Item #3 'Line'
  ; Item #4 'Aux2'
  ; Item #5 'Mic'
  ; Item #6 'Aux3'
  ; Item #7 'AC97'
  : values=2,2
Records in stereo. Uses correct control to adjust Line in volume.


:: Mic ::
$ amixer cset name="Capture Source" 3,3
numid=36,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Aux1'
  ; Item #1 'CD'
  ; Item #2 'Phono'
  ; Item #3 'Line'
  ; Item #4 'Aux2'
  ; Item #5 'Mic'
  ; Item #6 'Aux3'
  ; Item #7 'AC97'
  : values=3,3


:: AC97 ::
$ amixer cset name="Capture Source" 4,4
numid=36,iface=MIXER,name='Capture Source'
  ; type=ENUMERATED,access=rw---,values=2,items=8
  ; Item #0 'Aux1'
  ; Item #1 'CD'
  ; Item #2 'Phono'
  ; Item #3 'Line'
  ; Item #4 'Aux2'
  ; Item #5 'Mic'
  ; Item #6 'Aux3'
  ; Item #7 'AC97'
  : values=4,4
Records from everything such as Line in, Mic, CD-ROM, and PCM stream only
if they are not muted.


I have not tested AUX. I assume it uses the cset values of 1,1, but I do
not know.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-06 06:56 Electro        New Issue                                    
02-06-06 06:56 Electro        Distribution              => Gentoo          
02-06-06 06:56 Electro        Kernel Version            => 2.6.14-gentoo-r4
02-10-06 23:38 tartif         Note Added: 0008009                          
02-16-06 07:26 Electro        Note Added: 0008087                          
02-18-06 01:32 rlrevell       Relationship added       duplicate of 0001527
02-28-06 22:45 Electro        Note Added: 0008248                          
03-20-06 12:35 ungod          Note Added: 0008717                          
03-21-06 09:28 Electro        Note Added: 0008740                          
03-21-06 16:47 ungod          Note Added: 0008743                          
03-21-06 16:48 ungod          Note Edited: 0008743                         
03-25-06 06:53 Electro        Note Added: 0008942                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
