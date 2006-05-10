From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002068]: No sound in headphones - A3H ASUS
Date: Wed, 10 May 2006 08:15:52 +0200
Message-ID: <f5deac82fec25eb812e77dd8bb8cb288@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EE2F115E
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 08:15:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2068> 
======================================================================
Reported By:                awisniewski
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2068
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-25-2006 12:03 CEST
Last Modified:              05-10-2006 08:15 CEST
======================================================================
Summary:                    No sound in headphones - A3H ASUS
Description: 
Hello

I have ASUS A3H model laptop. I've just compiled kernel 2.6.16.11 from
kernel.org (newest). I used CONFIG_SND_HDA_INTEL=y option in kernel config
and it seems to be working propertly till I'm not trying use headphone
(internal speaker from laptop is working propertly). When I plug in
headphones into the jack port in laptop, internal speaker is silent but I
can not hear anything in headphones. It seems like turned on MUTT option
in mixer but I can not find option for headphones in my mixer
application.
 
Few facts:

lapek:/proc/asound# cat version 
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).

andy@lapek:~/moje/instalki/Linux/kernele/linux-2.6.16.11$ uname -a
Linux lapek 2.6.16.11 #1 Tue Apr 25 10:07:45 CEST 2006 i686 GNU/Linux

lapek:/proc/asound# cat timers 
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-0-3: PCM capture 0-0-3 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE

lapek:/proc/asound# cat pcm 
00-01: ALC880 Digital : ALC880 Digital : playback 1
00-00: ALC880 Analog : ALC880 Analog : playback 1 : capture 2

lapek:/proc/asound# cat devices 
  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

I will add /proc/asound/card0/codec#0 file also (as attachmets).

======================================================================

----------------------------------------------------------------------
 awisniewski - 04-26-06 20:26 
----------------------------------------------------------------------
So. I can use following option in alsamiexr application:

- Front - I can change volume for internal speaker only when headphones
are out of jack
- Surround - I can change volume for headphones when they are plugin
- Front Pin Mode is Line Out
- Surround Pin Mode is Line Out

************
It's a little strange because I had these two options before use debug and
test options in my alsamixer and then it was not working :/ Now, when I
change volume on Surround option I can hear sounds in my headphones :/
Maybe Surround Pin Mode was in the other option then Line Out ...
And sorry but I can't check other items in this moment (microphone, cd,
etc) :/

I hope there are information which you need. If not please write a comment
with more info what do you need (i'm not a master of sounds :)

----------------------------------------------------------------------
 awisniewski - 05-10-06 08:15 
----------------------------------------------------------------------
Because I had to recompile kernel and in this case alsa drivers also I can
be 100% sure that I must go into test mode (in assus mode I can not do
anything with headphones) and :

- Front must have some volume level
- Front pi must be Line Out
- Surround must have some volume level (with this option I can chanege
volume in my headphones)
- Surround pi must be Line Out  

When I used asus or default model option in my alsa driver I can not
change volume for headphones even if I had Surround option in my
alsamixer.

I think it's all what you need :)
Tx again ...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 12:03 awisniewski    New Issue                                    
04-25-06 12:03 awisniewski    File Added: codec#0                          
04-25-06 12:08 awisniewski    File Added: codec.zip                        
04-25-06 18:16 tiwai          Note Added: 0009493                          
04-25-06 18:21 tiwai          Note Added: 0009494                          
04-26-06 12:49 awisniewski    Note Added: 0009506                          
04-26-06 12:54 awisniewski    File Added: codec_v2.zip                     
04-26-06 13:01 tiwai          Note Added: 0009507                          
04-26-06 13:49 awisniewski    Note Added: 0009509                          
04-26-06 14:34 tiwai          Note Added: 0009510                          
04-26-06 20:26 awisniewski    Note Added: 0009523                          
05-10-06 08:15 awisniewski    Note Added: 0009702                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
