From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: Re: ICE1724 & Prodigy  instant reboot..
Date: Sat, 22 Nov 2003 15:08:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBFC24B.6090004@aei.ca>
References: <3FB79D6D.3050006@aei.ca> <s5hn0avjde3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070603080008020702010405"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0avjde3.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070603080008020702010405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

I tried the same setup with a stock 2.4.22 kernel and CVS and the
problem persists but only in below 48k sampling rates.

arecord -f S32_LE -d ICE1724 -D hw:0,0  -c 2
-r 192000 :  works (?? the card has a maximum 96k sampling rate!)
-r 96000 :  works
-r 48000 : works
-r 44100 : reboot after 2 seconds no data recorded
-r 22050 : same
-r 11025 : same

   I have done some more tests and it seems that adding "--bufer-size
8192" make recording fine. So I guess it is a software bug somewhere in
the ICE1724 driver together with arecord setting some weird
buffer/period size or whatever.  In my sense of a kernel driver,
whatever arecord does, the system shouldn't crash. I've attached the log
from the setup of the recording stream that crashes the system.

Apostolis


Takashi Iwai wrote:

>At Sun, 16 Nov 2003 10:53:17 -0500,
>Apostolos Dimitromanolakis wrote:
>  
>
>>Hi everybody,
>>
>>I'm still working on the audiotrak prodigy driver.  However for some 
>>reason the ice1724 module performs an instant reboot of the kernel when 
>>I try to record at 44khz. Recording at 96khz seems fine but as soon as 
>>you select 44khz on arecord, something odd happens. No data come out and 
>>no error messages from the module but the computers reboots after 1-2 
>>seconds. Experiments on the console revealed some kernel error messages 
>>(something with the word vm inside :) milliseconds before the reboot but 
>>there is
>>no time to read the messages really.  Is this a known problem with the 
>>ice1724 (i guess not) or something else is wrong? Note that the hardware 
>>access of prodigy to the DAC/ADC works fine and the interrupts should be 
>>generated ok. Also the ice1724 configuration is copied directly from the 
>>win driver and should be fine. Any ideas?
>>    
>>
>
>do you use a preemptive kernel?
>there was a mutex in spinlock context, and it was fixed recently on
>cvs.  anyway, please try the cvs version if not yet.
>
>
>Takashi
>
>
>  
>



--------------070603080008020702010405
Content-Type: text/plain;
 name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log"

Recording WAVE '/dev/null' : Signed 32 bit Little Endian, Rate 44000 Hz, Stereo
Hardware PCM card 0 'Audiotrak Prodigy 7.1' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 22050
period_size  : 5513
period_time  : 125011
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 5513
xfer_align   : 5513
start_threshold  : 1
stop_threshold   : 22050
silence_threshold: 0
silence_size : 0
boundary     : 1445068800
Aborted by signal Interrupt...


--------------070603080008020702010405--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
