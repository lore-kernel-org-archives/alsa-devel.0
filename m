From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: Re: Prodigy 7.1 driver update [snd-ice1724]
Date: Tue, 25 Nov 2003 14:38:39 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC3AFBF.9040801@aei.ca>
References: <3FC245AB.8040902@aei.ca> <s5hptfh1url.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030507060809080509000803"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptfh1url.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030507060809080509000803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

Takashi Iwai wrote:

>> Finally there is some misconception in the aureon & prodigy drivers: 
>>the codec chip does not have a Master control as it appears at the 
>>mixer. Instead the master control just updates the 8 volume controls of 
>>the individual DAC at the same time. Probably the best way is to add a 
>>virtual master control (ie that we update the volumes of the dac with  
>><master attenuation> + <specific channel attenuation> ).
>>    
>>
>
>well, such a thing should be done on user-space rather than on
>kernel.  let's postpone this until the new highlevel mixer functions
>become available.
>  
>
   That's fine if it can be done in user space but this creates a problem
with the mixer right now. Changing the master volume does not update all
the DAC volumes as it should and you can be in the situation where
Master is100% and all other volumes are 0, yet the playback is done in
maximum volume at all channels. Maybe the driver should update all
channel volumes on a master update.

>>As I wrote some days ago, the default buffer/period rates that 
>>alsarecord uses at 44.1KHz and lower sampling , locks hard the kernel. 
>>Have no idea what is it/how to fix it whatsoever.
>>    
>>
>
>hmm, could be the mismatch of cristal rate?
>i don't find out the critical path in the driver yet.
>  
>

No idea about that and how to debug it.. The driver still locks the
kernel using arecord and default parameters at 44.1Khz but not at higher
sample rates. I attached the PCM setup that locks the machine hard. It
seems that the driver manages to record a few periods and then locks.
Maybe the reason is the funny period buffer sizes (5513??) that appear
at the pcm setup. As I understand the situation it is a (minor) problem
with the ice1724 driver.

Apostolis





--------------030507060809080509000803
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



--------------030507060809080509000803--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
