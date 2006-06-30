From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000324]: Audigy2 Platinum: very low
	volume (both in and out)
Date: Fri, 30 Jun 2006 16:34:52 +0200
Message-ID: <5e498ccb103f86ca62fa6f4f5b365d79@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E75A29D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 16:34:52 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=324> 
======================================================================
Reported By:                garden
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   324
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian sid
Kernel Version:             2.6.5
======================================================================
Date Submitted:             06-06-2004 13:17 CEST
Last Modified:              06-30-2006 16:34 CEST
======================================================================
Summary:                    Audigy2 Platinum: very low volume (both in and out)
Description: 
Both the input and output levels of my Audigy2 Platinum seem to be very low
if compared to the same card with Windows (win98se). For example, I
connected an external source (a MD player with very loud music in the
disc) to the optical input, then to the aux input, then to the aux2 input.
With the mixer settings to 100% the input level still does not go over
20-25% of the maximum amplitude (while with Windows I have to lower the
input level or it will be too high). The same thing applies to the output
level of my analog speakers. [I must be *very* careful when I reboot with
Windows and must not forget to turn the volume knob from 10 to 2]. I had
exactly the same problem when I used the emu10k1 drivers from sourceforge.
======================================================================

----------------------------------------------------------------------
 garden - 09-14-04 15:24 
----------------------------------------------------------------------
Just to keep things updated: the problem stays there also with 2.6.8.1 and
ALSA 1.0.7rc1 (not compiled with the kernel).

----------------------------------------------------------------------
 pzad - 09-16-04 10:16 
----------------------------------------------------------------------
Driver only attenuate signals. If you set volumes of inputs and output to
100, then you get what is exactly on input.
Windows drivers probably amplify inputs or outputs. 

Could you attach output of amixer ????

----------------------------------------------------------------------
 garden - 09-16-04 11:37 
----------------------------------------------------------------------
Here is my amixer output.
I think it's very strange that the driver only attenuate signals... I
can't believe that the maximum output from this card is so much more quiet
than the output of an AWE64 (with ALSA and win95 the output volume was
exactly the same). 
On this PC I also have an integrated sound card:

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)

And in this case ALSA and win98 volume is quite the same.

Moreover, I also have very low levels with optical *input*, and I'm sure
that the original signal is near to 100% of volume.

----------------------------------------------------------------------
 pzad - 09-16-04 12:17 
----------------------------------------------------------------------
>Moreover, I also have very low levels with optical *input*, and I'm sure
that the >original signal is near to 100% of volume.

Try to set "IEC958 Optical Capture" to 100 in alsamixer and  record. Then 
check recorded file for signal level - maximum level - is this same as
source or it is lower ??? Best will be for example with cd player (optical
output connected to audigy). Recording something from this cd player. Then
you should grab this directly from cd (using some cd rip app) and compare
these two files if there is same volume level (They will be not same,
because emu10k1 always resamples).

Mixer in your other souncards are directly in hardware. On Audigy this
mixer is implemented in DSP software and can be changed. Output or input
can be amplifyed, but you will lose precision of your DAC or ADC.

If you set for example "IEC958 Optical", Front and Master to 100. What is
level compared to windows max mixer settings ???

I will check Audigy mixer if it is correct. Maybe I made some mistake.

----------------------------------------------------------------------
 garden - 09-16-04 13:23 
----------------------------------------------------------------------
I tried to record a CD track (1st mov. of 5th symphony by Beethoven :-))
with a CD player with the optical output connected to the input on the
audigy2 and IEC958 Capture at 100, then I tried connecting it to the RCA
connectors (analog inputs, 100% volume), then I recorded it playing the CD
in my CD-ROM reader (connected to the audigy2 "Audigy CD" digital input,
100% volume), then I ripped it with cdparanoia. These are the results
(well, I think I went wrong with "very low level". It appears just to be
"lower".)

arecord (IEC958 optical input, Sony MXD-D1)
Maximum amplitude:     0.835510
Minimum amplitude:    -0.828491

arecord (Aux IN 2 on the front panel, Sony MXD-D1)
Maximum amplitude:     0.727905
Minimum amplitude:    -0.715240

arecord (AudigyCD digital audio CD input, LiteON something DVD-ROM)
Maximum amplitude:     0.832703
Minimum amplitude:    -0.828522

cdparanoia:
Maximum amplitude:     0.933868
Minimum amplitude:    -0.923676

As for the comparison windows vs linux, I'll reboot in a few minutes then
I'll post the results.

----------------------------------------------------------------------
 jdthood - 08-30-05 12:23 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

----------------------------------------------------------------------
 garden - 08-30-05 12:32 
----------------------------------------------------------------------
No changes for me. It is still quite low.

----------------------------------------------------------------------
 rlrevell - 08-30-05 20:21 
----------------------------------------------------------------------
When you say Windows do you mean with the Creative driver?  Unfortunately
it's a black box.  Do you get the same results with this (vastly superior)
driver:

http://www.kxproject.com

If so then we can compare the AC97 registers.

----------------------------------------------------------------------
 pzad - 08-31-05 14:01 
----------------------------------------------------------------------
This is not in AC97 - it is used only for recording - and is already on
max. I think diffrence are in DSP code.

----------------------------------------------------------------------
 rlrevell - 08-31-05 18:54 
----------------------------------------------------------------------
Could this be related to the "x4" stuff in the kX driver?  Inputs from the
ADC are multiplied by 4 (since the ADC is 16 bit and the DSP 32 bit) then
divided by 4 at the output.

----------------------------------------------------------------------
 pzad - 01-26-06 21:52 
----------------------------------------------------------------------
I played with DSP and if everything is on 100 % then you get (when
recording) on output of DSP same amplitude of signal as on input. 
Playback can be diffrent and can be lower than in windows, but I don't
know, if it is, how much.

----------------------------------------------------------------------
 rlrevell - 01-26-06 21:55 
----------------------------------------------------------------------
OK, so NOTABUG?

----------------------------------------------------------------------
 pzad - 01-26-06 22:03 
----------------------------------------------------------------------
For now keep this bug open.
Recording from "mic in" is lower (compared to windows). I will post patch
(capture gain on AC97 needs to be set to 3-6 dB).
Recording from PCM is OK - when all volumes set 100% if you record PCM you
will get same recording volume as it was played.

I need to check recording from "line in" and playback part.

----------------------------------------------------------------------
 killrbuckeye - 06-19-06 16:33 
----------------------------------------------------------------------
pzad made me aware of this issue after I reported the problem in the
Creative forum.  I have the same symptoms as garden: very low capture
volumes with the Line-level inputs Aux2 (stereo RCA) and Line2 (1/4"),
even with all the ALSA capture volumes set to 100%.  I can make the
signals clip in Windows, so I know my source levels are more than
adequate.

----------------------------------------------------------------------
 snover - 06-21-06 23:19 
----------------------------------------------------------------------
I am experiencing a similar issue running 2.6.15 (2.6.15-25-amd64-k8) and
ALSA 1.0.10rc3 (Kubuntu Dapper 6.06) where the input levels are very very
low. Also, the "Line In 1/Mic 1" on the breakout box is mapped to Line2 in
ALSA, so "Mic Boost" does not work.

$ cat /proc/asound/cards
0 [Audigy2        ]: Audigy2 - Audigy 2 ZS [2001]
                     Audigy 2 ZS [2001] (rev.4, serial:0x20011102) at
0xc800, irq 74



----------------------------------------------------------------------
 killrbuckeye - 06-30-06 16:32 
----------------------------------------------------------------------
pzad: is this issue ever going to be addressed (we're approaching the
two-year mark), or should I just give up on using Linux for audio
recording with my Audigy?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-06-04 13:17 garden         New Issue                                    
06-06-04 13:17 garden         Distribution              => Debian sid      
06-06-04 13:17 garden         Kernel Version            => 2.6.5           
06-28-04 09:17 pzad           Status                   new => assigned     
06-28-04 09:17 pzad           Assigned To               => pzad            
09-14-04 15:24 garden         Note Added: 0001758                          
09-16-04 10:16 pzad           Note Added: 0001766                          
09-16-04 11:32 garden         File Added: amixer.out                       
09-16-04 11:37 garden         Note Added: 0001769                          
09-16-04 12:17 pzad           Note Added: 0001772                          
09-16-04 13:23 garden         Note Added: 0001773                          
08-30-05 12:23 jdthood        Note Added: 0005975                          
08-30-05 12:32 garden         Note Added: 0005978                          
08-30-05 20:21 rlrevell       Note Added: 0005981                          
08-31-05 14:01 pzad           Note Added: 0005988                          
08-31-05 18:54 rlrevell       Note Added: 0005990                          
01-26-06 21:52 pzad           Note Added: 0007789                          
01-26-06 21:55 rlrevell       Note Added: 0007790                          
01-26-06 22:03 pzad           Note Added: 0007791                          
01-28-06 23:11 andred         Issue Monitored: andred                      
06-19-06 16:33 killrbuckeye   Note Added: 0010316                          
06-19-06 16:34 killrbuckeye   Issue Monitored: killrbuckeye                    
06-21-06 23:18 snover         Note Added: 0010409                          
06-21-06 23:19 snover         Issue Monitored: snover                      
06-21-06 23:19 snover         Note Edited: 0010409                         
06-30-06 16:32 killrbuckeye   Note Added: 0010739                          
06-30-06 16:34 pzad           Assigned To              pzad =>             
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
