From: Eric Ross <eross+alsa-devel@disc.ucn.cl>
Subject: Using snd_async_add_pcm_handler
Date: Tue, 12 Oct 2004 22:02:25 -0300 (CLST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.61.0410122148530.26443@chacaya.disc.ucn.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

Hello there

I've using ALSA to develop a little video player for the dillo browser, 
also using the ffmpeg library.

I based the audio part in the pcm.c example found in the library source, 
but I have some questions about how alsa works. I'm using 
SND_PCM_ACCESS_RW_INTERLEAVED access.

Currently I'm using snd_async_add_pcm_handler to make ALSA call some 
function when it needs data to play. I've read somewhere that before 
calling snd_pcm_start() one need to feed some data into the buffer or I'll 
get an error. So I have a call to snd_pcm_writei before calling 
snd_pcm_start. The problem is that I cant figure out how much data I need 
to write: in the pcm.c example, it does a loop to write 2*period_size 
frames before calling _start(), so I do the same thing, but I'd like to 
know the real reason (and make sure that my player will work in any 
situation).

Also, I've ported the player to FamiliarLinux running in a IPaq, and it 
runs ok without sound, but when starting to write data to alsa handler, I 
just get a "Broken pipe" error.

Any sugestions ?
thanks in advance


PS: When running in the ipaq, the pcm_dump is:
Hardware PCM card 0 'H5xxx AK4535' device 0 subdevice 0
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 1024
period_time  : 23219
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1
start_threshold  : 16384
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824

-- 
#79989 counter.li.org


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
