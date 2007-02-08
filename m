From: <daniel.car@cox.net>
Subject: Looking for help with dmix plug-in on ARM
Date: Thu, 8 Feb 2007 10:44:10 -0800
Message-ID: <15711510.1170960250793.JavaMail.root@fed1wml07.mgt.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working on an unannounced SOC audio driver on an ARM system.  I have a problem were audio works fine with out dmix, but when I try to use dmix no audio data gets to the driver.  The dmix plug-in does work when attaching external usb audio device.  Trying to use dmix so that more then one application can generate audio simultaneously.

If I try with version 1.0.11 of ALSA the audio driver doesn't receive any data after the snd_pcm_period_elapsed() function call.  If I try with version 1.0.13 of ALSA, aplay returns an error saying: 
# aplay -D hw:0,0 pcm48khz_2ch_stereo.wav open_stream success
  Playing WAVE 'pcm48khz_2ch_stereo.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
  aplay: set_params:882: Broken configuration for this PCM: no configurations available

I'm planning on building a debug version of 1.0.14rc2 and tracing thru the code to see why aplay fails.  Is there a better way to debug this?  Are there any tricks for building ALSA with debug info?

Here is how the driver is set up:
static snd_pcm_hardware_t snd_oloriver_playback_hw = {
 .info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
	   SNDRV_PCM_INFO_MMAP_VALID),
 .formats 	    = SNDRV_PCM_FMTBIT_S16_LE,
  .rates 	    = SNDRV_PCM_RATE_48000,
  .rate_min	    = 48000, 
  .rate_max	    = 48000,
  .channels_min     = 2,
  .channels_max     = 2,
  .buffer_bytes_max = 65536,
  .period_bytes_min = 32768,
  .period_bytes_max = 32768,
  .periods_min 	    = 2,
  .periods_max 	    = 2,
};  

No config file is used for the working version.  For the dmix version the etc/asound.conf file is:
 pcm.chemamix {
      type dmix
      ipc_key 1024
       slave {
        pcm "hw:0,0"
        rate 48000
       }
  }

  pcm.!default {
     type plug
     slave.pcm chemamix
  }

Thanks,
Daniel

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
