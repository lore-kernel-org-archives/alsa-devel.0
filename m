From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: aplay noise
Date: Tue, 13 Apr 2004 22:06:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <005801c421cd$7560b1a0$0403a8c0@win2K>
References: <Pine.HPX.4.33n.0404131825060.10741-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

thanks for your answers.

I have another problem with my driver... another one ;)

When i try to play a sound with aplay, there is an horrible noise like: 
"tatatatatatatat" (like gun shoots)

I don't understand why.
I'm trying to playback a wav file, but i hear some strange noise, not the
data corresponding to the wav file.
I compared the data of the wav file and the data in the copy operator
(before they sent to the codec). They seam to be the same.

This is what the aplay -v tell me, maybe it can help.
 
aplay -v voice-8k-16bit-stereo.wav

Playing WAVE 'voice-8k-16bit-stereo.wav' : 
Signed 16 bit Little Endian, Rate 8000 Hz, Stereo

Plug PCM: Hardware PCM card 0 'codec a ' device 0 subdevice 0

Its setup is:
stream      : PLAYBACK
access       : RW_INTERLEAVED                          
format       : S16_LE                                  
subformat    : STD                                     
channels     : 2                                       
rate         : 8000                                    
exact rate   : 8000 (8000/1)                           
msbits       : 16                                      
buffer_size  : 16384                                   
period_size  : 2048                                    
period_time  : 256000                                  
tick_time    : 10000                                   
tstamp_mode  : NONE                                    
period_step  : 1                                       
sleep_min    : 0                                       
avail_min    : 2048                                    
xfer_align   : 2048                                    
start_threshold  : 16384                               
stop_threshold   : 16384                               
silence_threshold: 0 
silence_size : 0                                     
boundary     : 1073741824    

Thank you very much for any help.
regards,

Mathieu



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
