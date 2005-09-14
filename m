From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000048]: M-Audio Quattro initialization problem
Date: Wed, 14 Sep 2005 16:03:01 +0200
Message-ID: <ecccfa25b2fddc946e8109d190e4c9dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9291B19A
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:03:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=48> 
======================================================================
Reported By:                giggls
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   48
Category:                   USB - usb-audio
Reproducibility:            sometimes
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.24
======================================================================
Date Submitted:             02-09-2004 11:45 CET
Last Modified:              09-14-2005 16:03 CEST
======================================================================
Summary:                    M-Audio Quattro initialization problem
Description: 
If a M-Audio Quattro device is plugged into the USB Port the driver does
not always initialize the device in a correct way.

It seems to work, but it does not record any useful sound.

Unfortunately it does work occasionally (about 50% of the time)!

Replugging the device until it works does resolve the Problem.


======================================================================

----------------------------------------------------------------------
 v2 - 02-11-04 14:59 
----------------------------------------------------------------------
I also have this problem. Currently running Debian, Agnula 1.1.0 kernel
(can't remember the alsa version), Intel PIV (shuttle SB51G).

I suspect that the device is working 24 bit and the driver doesn't realize
this and the driver accepts the data as 16bit. I haven't found a
conversion which would create the same "distortion" type sound, but I
haven't looked for it very througly. I'll post a sample file when I get
home.

edited on: 02-11-04 14:59

----------------------------------------------------------------------
 giggls - 02-11-04 16:36 
----------------------------------------------------------------------
Further debugging of the problem led to the following result:

After initialisation the device will randomly work in either 16 or 24 bit
recording mode.

Looks like the device does not care about the data format given by
arecord. Probably these options have to be set by means of vendor specific
commands :(

----------------------------------------------------------------------
 Clemens Ladisch - 02-24-04 09:07 
----------------------------------------------------------------------
Are you trying to record at 16 or 24 bits (or both)? At which sample rate?

Does this happen with input pairs 1/2, 3/4, or both?

And what are the contents of /proc/asound/cardX/stream0 and stream1?

----------------------------------------------------------------------
 giggls - 02-25-04 09:53 
----------------------------------------------------------------------
I tried to either reccord in 16 or 24 Bit Mode and either one of the Modes
does work, but not both of them.

I tried with the 1/2 Input-Pair only.

I uploaded the Output of /proc/asound/cardX/stream0 and
/proc/asound/cardX/stream1 as requested.

They are the same regardless of which Mode currently works.

I use something like this to test the behaviour:

arecord -D plughw:1 -c 2 -r 44100 -f S16_LE

A Sin-Wave with an Amplitude of about 5V is connected to Input 1 in order
to get a useful Signal.

In the case where it did not work it was always possible to use S24_LE
instead of S16_LE and vise versa.

P.S.: I will be able to provide access to a Machine with the device
connected if necessary.

----------------------------------------------------------------------
 Clemens Ladisch - 02-25-04 10:15 
----------------------------------------------------------------------
Please try it at 48000 Hz instead of 44100.

If the bug is what I think it is, then this should work in any case (with
both 16 and 24 bits).

----------------------------------------------------------------------
 giggls - 02-25-04 16:10 
----------------------------------------------------------------------
OK, I just gave this a try:

arecord -D plughw:1 -r 48000 -f S16_LE -c 2

This gives me the exact same Problem I have with the -r 44100 Option :(

For me, it does still look like a matter of device Initialisation, note,
that there is a special Windows and MAC-Software for the selection of
Operation Modes!

Thats why I got the Intention, that this has to be set using a proprietary
protocoll.
See Page 21 of the Manual
(www.synthman.com/support/midiman-maudio/ manuals/Quattro_manual.pdf)
for what I am talking about.

P.S.: Thanks for changing the severity Level from feature, which I had
chosen by mistake. I disagree about the assigned "minor" level though, as
the Problem renders the device almost unusable for a lot of applications.

----------------------------------------------------------------------
 Clemens Ladisch - 02-26-04 16:12 
----------------------------------------------------------------------
I uploaded a patch.
To apply it, go to the alsa-kernel directory and run

  patch -p1 < quattroif.patch

then recompile and reload ALSA.

Please check if the error still occurs with this patch.  If there is wrong
output, please show the contents of /proc/asound/card0/stream0 while it is
playing.

----------------------------------------------------------------------
 giggls - 02-27-04 15:42 
----------------------------------------------------------------------
OK, here is the behavior after your patch has been applied:

The output seems to be the same all the time now. No difference between
different reinitialisation cycles, but at the Output is now junk _all_ the
time, regardless of using 24 or 16 bit modes. I uploaded a file called
proc-asound-card1-stream0-junk.txt which has been generated while running
the following command:

arecord -D plughw:1 -r 44100 -f S16_LE -t raw -q -c 1 |scope Short

For testing 24 Bit Mode I use this command:

arecord -D plughw:1 -r 44100 -f S24_LE -t raw -q -c 2

----------------------------------------------------------------------
 Clemens Ladisch - 03-01-04 18:45 
----------------------------------------------------------------------
I don't see the file ...

----------------------------------------------------------------------
 giggls - 03-02-04 09:32 
----------------------------------------------------------------------
Sorry, I forgot to upload the file

----------------------------------------------------------------------
 Clemens Ladisch - 03-02-04 17:11 
----------------------------------------------------------------------
It may be possible that the Quattro records big-endian data (some other
M-Audio devices do that, too).

Please record a file with:

arecord -D hw:1 -r 44100 -f S16_LE -c 2 -t raw somefile

... and then try to play it back with:

aplay -D plughw:1 -r44100 -f S16_BE -c 2 -t raw somefile

----------------------------------------------------------------------
 giggls - 03-04-04 10:09 
----------------------------------------------------------------------
Its _not_ a byte swapping issue! I already checked this before and did it
again now.

With the hacked version I never get any usable Data (in either 24 or
16-Bit Mode) with the arecord commands that I posted, even if the bytes
are swapped before visualisation.

However, when using the unmodified Version of the driver, in the one of
the two random states of the device (the one, where 24-Bit Mode does
work), I have to swap the bytes to get usefull results. I don´t need to do
this when recording data in 16-Bit Mode (in the other random state of the
device of course).

I forget to mention this in my other reports.

----------------------------------------------------------------------
 Clemens Ladisch - 03-04-04 12:53 
----------------------------------------------------------------------
Now that's interesting that the recorded data is neither big-endian nor
little-endian.

Please record a small file of (nearly) silence (with "arecord -D hw:1 -r
11025 -f S16_LE -c 2 -t raw -d 1 somefile") and upload/send me the file,
maybe I can find out what the format is.

----------------------------------------------------------------------
 giggls - 03-04-04 16:18 
----------------------------------------------------------------------
OK, first of all, here are some further findings:

While trying to record your sample data (with the patched driver Version),
I found out, that the 16-Bit recording does work if I use something like
this:

arecord -D plughw:1 -r 44100 -f S16_LE -t raw -q -c 2

while it does not, if just one channel is used (-c 1)!

The Data is in BIG-Endian Format in 2-channel Mode, while in 1-channel
Mode I uploaded two files one without anything connected and one with a
sin-wave connected to channel 1.

----------------------------------------------------------------------
 Clemens Ladisch - 03-04-04 19:50 
----------------------------------------------------------------------
Please note that the Quattro cannot record with one channel, and that you
have used not "hw:0" but "plughw:0" which automatically converts sample
formats.  This conversion[1] won't work if the data format isn't the same
as declared.

To summarize:  with my patch, the Quattro _always_ plays back
little-endian data[2], and _always_ records big-endian data.  Is that
correct?

It would be nice if you could try 24bit/48kHz and 24bit/96kHz, too.


[1] here: averaging both channels
[2] you didn't mention playback, but I assume it works

----------------------------------------------------------------------
 Clemens Ladisch - 03-08-04 10:48 
----------------------------------------------------------------------
I uploaded a new patch.  Please apply it in the same way as the other one. 
(It doesn't matter if your driver still has the old patch.)

With this patch, the driver knows that recorded samples are big-endian,
and recording should now work.

----------------------------------------------------------------------
 timblech - 04-28-04 12:44 
----------------------------------------------------------------------
hi all,

i still have problems with my quattro ... pd reports the input level as 16
(what was ok with the old driver, the distortion of the old driver was at
58), but the input is still distorted ...

but after switching to kernel 2.6.6_rc2, i didn't have to restart alsa
that often ... with kernel 2.4 i had to restart between 10 and 15 times
... with 2.6 only one or two times ... maybe that's a hint .... 
cheers ... t

----------------------------------------------------------------------
 giggls - 11-17-04 15:09 
----------------------------------------------------------------------
OK, I've got some time now to debug this Problem again. It would still
be nice to get these devices working!

I still does not work as of kernel 2.6.9 (vanilla Kernel). Still the same
Problem as in my first bug-report. It soemetimes works and sometimes does
not. Despite your patch which has been applied as I could see in the
sources.

It does not matter if I use 16 or 24 Bit Mode:

arecord -D plughw:1 -d 3 -r 48000 -f S24_LE -q -c 2 24.wav

arecord -D plughw:1 -d 3 -r 48000 -f S16_LE -q -c 2 16.wav

The first gives big endian data though.

Sven

----------------------------------------------------------------------
 jdthood - 09-14-05 16:03 
----------------------------------------------------------------------
Submitter: Is this problem fixed in more recent ALSA versions or using more
recent kernels?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-04 11:45 giggls         New Issue                                    
02-11-04 10:26 giggls         Issue Monitored: giggls                      
02-11-04 14:58 v2             Note Added: 0000218                          
02-11-04 14:58 v2             Issue Monitored: v2                          
02-11-04 14:59 v2             Note Edited: 0000218                         
02-11-04 14:59 v2             Note Edited: 0000218                         
02-11-04 16:36 giggls         Note Added: 0000219                          
02-24-04 08:48 Clemens LadischSeverity                 feature => minor    
02-24-04 09:07 Clemens LadischNote Added: 0000302                          
02-25-04 09:30 giggls         File Added: proc-stream1.txt                    
02-25-04 09:30 giggls         File Added: proc-stream0.txt                    
02-25-04 09:53 giggls         Note Added: 0000310                          
02-25-04 10:12 Clemens LadischIssue Monitored: Clemens Ladisch                  
 
02-25-04 10:15 Clemens LadischNote Added: 0000313                          
02-25-04 16:10 giggls         Note Added: 0000315                          
02-26-04 16:08 Clemens LadischFile Added: quattroif.patch                    
02-26-04 16:12 Clemens LadischNote Added: 0000352                          
02-26-04 16:12 Clemens LadischSeverity                 minor => major      
02-26-04 16:12 Clemens LadischReproducibility          always => sometimes 
02-27-04 15:42 giggls         Note Added: 0000381                          
03-01-04 18:45 Clemens LadischNote Added: 0000413                          
03-02-04 09:31 giggls         File Added: proc-asound-card1-stream0-junk.txt    
               
03-02-04 09:32 giggls         Note Added: 0000432                          
03-02-04 17:11 Clemens LadischNote Added: 0000443                          
03-04-04 10:09 giggls         Note Added: 0000471                          
03-04-04 12:53 Clemens LadischNote Added: 0000477                          
03-04-04 16:18 giggls         Note Added: 0000482                          
03-04-04 16:18 giggls         File Added: sinus.raw                        
03-04-04 16:19 giggls         File Added: silence.raw                      
03-04-04 19:50 Clemens LadischNote Added: 0000491                          
03-08-04 10:46 Clemens LadischFile Added: quattro-new.patch                    
03-08-04 10:48 Clemens LadischNote Added: 0000527                          
04-28-04 12:44 timblech       Note Added: 0000969                          
11-17-04 15:09 giggls         Note Added: 0002435                          
11-17-04 15:25 v2             Issue End Monitor: v2                        
09-14-05 16:03 jdthood        Note Added: 0006170                          
09-14-05 16:03 jdthood        Severity                 major => minor      
09-14-05 16:03 jdthood        Summary                  M-Audio Quattro
Initialisation Problem => M-Audio Quattro initialization problem
09-14-05 16:03 jdthood        Description Updated                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
