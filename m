From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000324]: Audigy2 Platinum: very low volume (both in and out)
Date: Wed, 31 Aug 2005 13:22:05 +0200
Message-ID: <f66396f36757138ec8ba33e8407c81d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0DEFB208
	for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2005 13:22:06 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=324> 
======================================================================
Reported By:                garden
Assigned To:                pzad
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
Last Modified:              08-31-2005 13:22 CEST
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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
