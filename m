From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Wed, 04 Aug 2004 12:21:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4110C6C9.4000009@wildgooses.com>
References: <200408040018.i740ITg5017942@localhost.localdomain> <Pine.LNX.4.58.0408040935080.1857@pnote.perex-int.cz> <s5h8ycvqltj.wl@alsa2.suse.de> <Pine.LNX.4.58.0408041218030.1857@pnote.perex-int.cz> <4110BAE0.6070309@wildgooses.com> <Pine.LNX.4.58.0408041252140.1857@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0408041252140.1857@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>>Ahh, yes, I see now.  The max period size SHOULD be 8192.  For some 
>>reason when I request anything larger than 2048, I only get 2048...  I 
>>have tried asking for exactly 8192, and "_near" 8192 with the same results.
>>
>>I will try giving the machine a reboot in case something has grabbed the 
>>card and it's ended up in a funny state which might be causing this.  
>>However, I can currently happily choose 512, 1024, and 2048 period 
>>sizes, but nothing larger.
>>    
>>
>
>It's better to send us a dump from /proc/asound/card0/pcm0p/sub0/* files
>to verify the correct values. But I guess that resampling might be 
>involved, so the final frame count is smaller from the application view.
>  
>

Reboot achieved nothing.

(Did the following while the app was active)

mm MPlayer-1.0pre5 # ls /proc/asound/card1/pcm0p/sub0/*
/proc/asound/card1/pcm0p/sub0/hw_params  
/proc/asound/card1/pcm0p/sub0/info  
/proc/asound/card1/pcm0p/sub0/status  
/proc/asound/card1/pcm0p/sub0/sw_params
mm MPlayer-1.0pre5 # cat /proc/asound/card1/pcm0p/sub0/*
access: MMAP_NONINTERLEAVED
format: S32_LE
subformat: STD
channels: 12
rate: 48000 (48000/1)
period_size: 2048
buffer_size: 4096
tick_time: 1000
card: 1
device: 0
subdevice: 0
stream: PLAYBACK
id: RME Hammerfall HDSP 9632
name: RME Hammerfall HDSP 9632
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
state: RUNNING
trigger_time: 1091618462.875884000
tstamp      : 1091618462.918708000
delay       : 3872
avail       : 224
avail_max   : 224
-----
hw_ptr      : 2048
appl_ptr    : 5920
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2048
xfer_align: 2048
start_threshold: 1
stop_threshold: 4096
silence_threshold: 0
silence_size: 0
boundary: 1073741824





-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
