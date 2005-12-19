From: Andrey L <alsa-devel@lelik.org>
Subject: VLC SPDIF passthrough
Date: Mon, 19 Dec 2005 05:45:47 -0800
Message-ID: <43A6B98B.6060901@lelik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi guys. For a number of last nights I'm trying to get SPDIF passthrough 
working on my setup - ATI RS482 chipset + intel hd audio + realtek 
ALC880 connected to onkyo reciever. The problem seems common - receiver 
switches to dolby digital mode but there is no sound (otherwise 
everything works perfectly, including SPDIF in PCM mode). I have the 
latest alsa drivers, library and VLC.

I tried lots of theories and so far I believe the problem is due to 
invalid frame size. The VLC code looks (very simplified) like following 
fragment (it is in modules\audio_output\alsa.c in vlc source tree) :

        /* Get Initial hardware parameters */
snd_pcm_hw_params_any( p_sys->p_snd_pcm, p_hw )
        /* Set format. */
snd_pcm_hw_params_set_format( p_sys->p_snd_pcm, p_hw,i_snd_pcm_format )
        /* Set channels. */
snd_pcm_hw_params_set_channels( p_sys->p_snd_pcm, p_hw,i_channels)
        /* Set rate. */
snd_pcm_hw_params_set_rate_near( p_sys->p_snd_pcm, 
p_hw,&p_aout->output.output.i_rate,NULL );
        /* Set buffer size. */
snd_pcm_hw_params_set_buffer_size_near( p_sys->p_snd_pcm,p_hw, 
&i_buffer_size ) ;
        /* Set period size. */
snd_pcm_hw_params_set_period_size_near( p_sys->p_snd_pcm,p_hw, 
&i_period_size, NULL ) ;
        /* Commit hardware parameters. */
snd_pcm_hw_params( p_sys->p_snd_pcm, p_hw ) ;


In the code above VLC tries to set parameters as specified in AC3 spec - 
{//i_snd_pcm_format=SND_PCM_FORMAT_IEC958_SUBFRAME,i_channels=2,i_rate=48K,i_buffer_size=1536,i_period_size=16*1536}.
//I believe the frame size of 1536 is important here - seems like 
reciever ignores frames with wrong size. However this code  fails to set 
correct frame size, and once this code is executed the real parameters 
look like:

stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : IEC958_SUBFRAME_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 32
buffer_size  : 8192
period_size  : 2048
period_time  : 42666
tick_time    : 4000

ALSA software setup:

tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2048
xfer_align   : 2048
start_threshold  : 1
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 4611686018427387904


I'm new to alsa. Why snd_pcm_hw_params_set_buffer_size_near / 
snd_pcm_hw_params_set_period_size_near fails to set requested values in 
this example? Where this constraint ( 2K for period size ) lives? Is 
there any way to set period_size to 1536 or is it hardware restriction 
(I seriously doubt it though) ? Thanks in advance.













-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
