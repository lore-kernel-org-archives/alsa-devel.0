From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: Re: Broken emu10k/SB Live driver?
Date: Thu, 10 Oct 2002 21:37:44 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021010183748Z23071-7588+6998@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On the SB Live problems: recorded signal levels differs from MS Windows
driver, and the capture faders of alsamixer seems to do nothing.
I posted this to alsa-user as well if there are people who has
the SB Live card. Please join us for testing.

If I start to understand how the SB Live driver works, then I will
fix the driver myself. But I would like to have reports from other
SB Live users if their driver works the same way.

 -*-

Below are the settings which works for Drive/line-in2 (Line LiveDrive)
recording. All other faders are 0, mute switches are on, and capture
switches are off.

name                   | capture switch | mute switch | level
-------------------------------------------------------------
PCM                    | <none>         | off         | 100
Line LiveDrive         | off            | <none>      | 100
Line LiveDrive Capture | <none>         | <none>      | 0
Capture                | on             | <none>      | 0
Mix                    | on             | <none>      | 0
AC97 Capture           | <none>         | <none>      | 100

<none> means that there is no such a switch.

Line LiveDrive's capture switch has no effect.   Strange!
Line LiveDrive's level must be 100 because it controls both the monitor
signal and the capture signal gains.
Line LiveDrive Capture's level has no effect.    Strange!
Capture level 0 seems to mean unity gain.
Mix level is fixed to 0.

Where all those controls are physically located? A flow diagram could
also help in understanding all the relations.

By seeing the whole signal path diagram of Alsa, I could check if there
is a direct signal path from Line LiveDrive to disk with all gains
inbetween set to unity. Is there such a path?

 -*-

MS Windows driver allows one to set the quality of the resamplers
(48000 Hz to/from 44100 Hz). Are those resamplers in firmware or
in dsp code of emu10k1? Does Alsa use those resamplers or has
equivalents? Could Alsa be programmed to allow an application
software to use those resamplers? Or are the resamplers tied up
to A/D and D/A conversion?

Does emu10k1 work at a user settable sample rate? 44100 Hz? 32000Hz?

MS Windows driver has a good sounding reverb. Could this reverb dsp
code be extracted from the MS Windows driver and used "as is" in Alsa?

 -*-

Alsamixer shows the following additional controls only if alsamixer
is executed at the play time. What they are? The controls are not
available at record time.

name                     |  value (left right)
-------------------------------------------------------
EMU10K1 PCM              |         100  100
EMU10K1 PCM              |         100  100
EMU10K1 PCM Send         |         100  100
EMU10K1 PCM Send         |         0    100
EMU10K1 PCM Send         |         0    0
EMU10K1 PCM Send         |         0    0
EMU10K1 PCM Send Routing |         0    7
EMU10K1 PCM Send Routing |         20   0
EMU10K1 PCM Send Routing |         13   13
EMU10K1 PCM Send Routing |         7    7


Best Regards,

Juhana


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
