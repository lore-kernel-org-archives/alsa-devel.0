From: Mark Knecht <markknecht@attbi.com>
Subject: Re: aplay: pcm_write:1025: write error
	&	SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
Date: 02 Jun 2003 21:14:05 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054613645.1430.23.camel@Wizard.knechthome.com>
References: <s5h1xycpor7.wl@alsa2.suse.de>
	 <NDBBLGIKBJENLAMOLFHGMELKCFAB.mknecht@controlnet.com>
	 <s5hznl0o8u1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznl0o8u1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Knecht <mknecht@controlnet.com>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-06-02 at 07:25, Takashi Iwai wrote:

> just add the following line to the end of /etc/modules.conf:
> 
> 	options snd-via82xx dxs_support=2
> 
> (or dxs_support=3)
> 
> and run "/etc/init.d/alsasound restart".
> 
> note that the option above is available only on the very recent ALSA 
> version.

A solution is found! But I'd like to understand why the other failed:

Wizard root # aplay -D hw:0,1 /home/mark/data/wave/seque~10.wav 
Playing WAVE '/home/mark/data/wave/seque~10.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Mono

And I get sound just fine...

Why is specifying the device required? As root I have no .asoundrc file,
but as a user I do:


pcm.via82xx {
    type hw
    card 0
}

ctl.via82xx {
    type hw
    card 0
}



Apparently my version is not new enough for your new option:

Wizard modules.d # /etc/init.d/alsasound restart
 * Shutting down ALSA
modules....                                         [ ok ]
 * Initialising ALSA....
 * Starting sound driver: snd-via82xx Warning: ignoring dxs_support=2,
no such parameter in this module
Module snd-via82xx loaded, with
warnings                                  [ ok ]
 
Wizard modules.d # 

And pcm2p did not exist...

Wizard root # ls /proc/asound/card0/
ac97#0  ac97#0regs  id  pcm0c  pcm0p  pcm1c  pcm1p
Wizard root # 


Wizard root # aplay -v /home/mark/data/wave/seque~10.wav 
Playing WAVE '/home/mark/data/wave/seque~10.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Mono
Plug PCM: Hardware PCM card 0 'VIA 8235' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 1
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 22050
period_size  : 4410
period_time  : 100000
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 4410
xfer_align   : 4410
start_threshold  : 22050
stop_threshold   : 22050
silence_threshold: 0
silence_size : 0
boundary     : 1445068800
aplay: pcm_write:1025: write error: Input/output error
Wizard root # 






-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
