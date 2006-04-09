From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001331]: MSI K8N's SB Live 24 bit, no sound from line-in
Date: Sun, 9 Apr 2006 21:40:39 +0200
Message-ID: <0ed68cb0565520adbae4fce2dc1b54f3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DD32F159
	for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2006 21:40:39 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1331> 
======================================================================
Reported By:                Cimmo
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1331
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1398-x86_64
======================================================================
Date Submitted:             08-13-2005 01:27 CEST
Last Modified:              04-09-2006 21:40 CEST
======================================================================
Summary:                    MSI K8N's SB Live 24 bit, no sound from line-in
Description: 
I have a MSI K8N Platinum motherboard that has a SBLive! 24 bit
integrated.
(Un)fortunatelly this motherboard provide two different jacks for Mic and
Line-In instead of one single jack like the pci version of the sb live 24
bit.

With this card I cannot hear any sound that come from line-in.
For Example I have a tv card, its output audio go into line-in: result is
I cannot hear nothing from the tv, I can only see channels without audio.

The "Capture feedback into playback" in the mixer change the mic's
volume.
There is nothing that change line-in's volume.
======================================================================

----------------------------------------------------------------------
 jcdutton - 08-13-05 01:41 
----------------------------------------------------------------------
In order to help me implement support for what you want, please try the
following:
arecord -fdat -Dhw:0,0 | aplay
arecord -fdat -Dhw:0,1 | aplay
arecord -fdat -Dhw:0,2 | aplay
arecord -fdat -Dhw:0,3 | aplay

Please tell me which one works for the "line in".
If should record from the line in and then play it to the speakers with a
small delay.

----------------------------------------------------------------------
 Cimmo - 08-13-05 18:30 
----------------------------------------------------------------------
There are some problems, none of the 4 lines works, this is what I have
done:

[cimmo@localhost ~]$ arecord -fdat -Dhw:0,0 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Aborted by signal Interrupt...
Aborted by signal Interrupt...
[cimmo@localhost ~]$ arecord -fdat -Dhw:0,1 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Aborted by signal Interrupt...
Aborted by signal Interrupt...
[cimmo@localhost ~]$ arecord -fdat -Dhw:0,2 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
arecord: pcm_read:1252: read error: Input/output error
[cimmo@localhost ~]$ arecord -fdat -Dhw:0,3 | aplay
Recording WAVE 'stdout' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
arecord: pcm_read:1252: read error: Input/output error

----------------------------------------------------------------------
 Cimmo - 08-31-05 15:14 
----------------------------------------------------------------------
What I have to do? Waiting for an answer...

----------------------------------------------------------------------
 rlrevell - 08-31-05 18:59 
----------------------------------------------------------------------
It's clearly a driver bug so all you can do at this point is wait for a
response from the driver developer.

----------------------------------------------------------------------
 jcdutton - 09-10-05 10:31 
----------------------------------------------------------------------
You might have an older version of the kernel driver.
Please post the output of: http://alsa.opensrc.org/TroubleShooting
Do Questions 1,2,3 and 4 and post the output here.

If you find that you do not have the latest alsa-driver, please try to
upgrade to it.

Please note that Line-in has never ever worked for your motherboard based
sound card in Linux, due to lack of enough information to implement it.
So, it is not really a bug, but instead a feature that we don't know how
to implement yet.

----------------------------------------------------------------------
 Cimmo - 10-19-05 19:13 
----------------------------------------------------------------------
1) Alsa is installed via module. Actually I've kernel v2.6.12.9
2) Advanced Linux Sound Architecture Driver Version 1.0.9 (Sun May 29
07:31:02 2005 UTC).
3) 1.0.9
4)
0 [CA0106         ]: CA0106 - CA0106
                     MSI K8N Diamond MB [SB0438] at 0xde00 irq 16
1 [Camera         ]: USB-Audio - Camera
                     Camera at usb-0000:00:02.0-8, full speed

----------------------------------------------------------------------
 jcdutton - 11-07-05 00:02 
----------------------------------------------------------------------
The version of alsa-driver you have is too old.
Support for your sound card was only added recently.
Please upgrade your version of alsa-driver.
If you compiled your own kernel, then simply installing alsa-driver will
update them for you.

----------------------------------------------------------------------
 Cimmo - 11-07-05 11:07 
----------------------------------------------------------------------
So I've to switch to development version 1.0.10rc2?

----------------------------------------------------------------------
 Cimmo - 11-11-05 19:33 
----------------------------------------------------------------------
Ok I've compiled and installed succesfully alsa-driver and alsa-lib
1.0.10rc3

I've retested everything:
putting TV audio output to mic it works great, I can listen to TV!
With this configuration I'm be able to record and play with these 2
commands:
arecord -fdat -Dhw:0,1 | aplay
arecord -fdat -Dhw:0,2 | aplay

with line-in there is no chance: audio doesn't work, and none of the four
0,x works.

I've to stress Creative for documentation?

Tell me something

Thanx
Marco

----------------------------------------------------------------------
 jcdutton - 12-13-05 13:16 
----------------------------------------------------------------------
Ok, so now the mic in works, but line in does not.
The only way to fix this is if I get a hardware sample.
The connections of the mic and line in are hardware specific and different
from all other SB Live 24bit cards.
You could try and get MSI to send me a hardware sample if you wish to fix
this.

----------------------------------------------------------------------
 Cimmo - 12-13-05 13:34 
----------------------------------------------------------------------
Of course send to you a sample means that I have to pay for this and can't
do this :)
The only thing I can do is to give and ssh login to my pc to try via
remote, it can help you?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-13-05 01:27 Cimmo          New Issue                                    
08-13-05 01:27 Cimmo          Distribution              => Fedora Core 4   
08-13-05 01:27 Cimmo          Kernel Version            => 2.6.12-1.1398-x86_64
08-13-05 01:41 jcdutton       Note Added: 0005798                          
08-13-05 01:42 jcdutton       Status                   assigned => feedback
08-13-05 18:30 Cimmo          Note Added: 0005807                          
08-31-05 15:14 Cimmo          Note Added: 0005989                          
08-31-05 18:59 rlrevell       Note Added: 0005991                          
09-10-05 10:31 jcdutton       Note Added: 0006107                          
10-19-05 19:13 Cimmo          Note Added: 0006496                          
11-07-05 00:02 jcdutton       Note Added: 0006610                          
11-07-05 11:07 Cimmo          Note Added: 0006612                          
11-11-05 19:33 Cimmo          Note Added: 0006678                          
12-13-05 13:16 jcdutton       Note Added: 0007007                          
12-13-05 13:34 Cimmo          Note Added: 0007015                          
04-09-06 21:40 jcdutton       Status                   feedback => assigned
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
