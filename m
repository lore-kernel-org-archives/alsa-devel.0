From: Jerry Geis <geisj@pagestation.com>
Subject: Re: seg fault in libasound
Date: Thu, 26 Jun 2008 08:37:15 -0400
Message-ID: <48638D7B.3020207@pagestation.com>
References: <486282A1.7050308@pagestation.com> <48638AE3.90003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com
	(mail.emergencycommunicationsystems.com [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AF4F24611
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 14:37:18 +0200 (CEST)
In-Reply-To: <48638AE3.90003@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Jerry Geis wrote:
>   
>> I am getting a seg fault in alsa.
>>
>> #2  0xb7d7105f in __assert_fail () from /lib/tls/libc.so.6
>> #3  0xb741861f in snd_pcm_area_copy (dst_area=0x81cc62c, dst_offset=0,
>>     src_area=0x81cb7ec, src_offset=5223, samples=816,
>>     format=SND_PCM_FORMAT_S16_LE) at pcm_local.h:499
>>     
>
> This is the "assert(bitofs % 8 == 0)" in snd_pcm_channel_area_addr()
> in pcm_local.h.  In theory, this means that some sample is not aligned
> to a byte boundary, but it should be impossible to get this error.
>
> Do you have any .asoundrc or asound.conf file?  If yes, please remove
> them and try again.
>
>
> Regards,
> Clemens
>
>   
You are correct. I removed my /etc/asound.conf file and now it does not 
seg fault.
Below is my file. What is wrong with it?

 aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: default [C-Media USB Headphone Set  ], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

 lsusb
Bus 004 Device 001: ID 0000:0000  
Bus 003 Device 002: ID 0d8c:000c C-Media Electronics, Inc. Audio Adapter
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 002: ID 13fe:1f00  
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 001: ID 0000:0000  

I have used this file many times with NON USB sound devices and it has been fine.

Also - after removing the asound.conf file my sound is a little choppy. Anything I can do about that?

Thank you.

Jerry


-----
 

# Set default sound card
# Useful so that all settings can be changed to a different card here.
pcm.snd_card {
     type hw
     card 0
     device 0
}

# Allow mixing of multiple output streams to this device
pcm.output {
     type dmix
     ipc_key 1024
     ipc_perm 0660 # Sound for everybody in your group!
     slave.pcm "snd_card"

     slave {
          # This stuff provides some fixes for latency issues.
          # buffer_size should be set for your audio chipset.
          period_time 0
          period_size 1024
          buffer_size 8192
     }

     bindings {
          0 0
          1 1
     }
}

# Allow reading from the default device.
# Also known as record or capture.
pcm.input {
     type dsnoop
     ipc_key 2048
     slave.pcm "snd_card"

## Possible artsd full duplex fix:
#     slave {
#          period_time 0
#          period_size 1024
#          buffer_size 8192
#     }

     bindings {
          0 0
          1 1
     }
}

# This is what we want as our default device
# a fully duplex (read/write) audio device.
pcm.duplex {
     type asym
     playback.pcm "output"
     capture.pcm "input"
}

###################
# CONVERSION PLUG #
###################
# Setting the default pcm device allows the conversion
# rate to be selected on the fly.
# duplex mode allows any alsa enabled app to read/write
# to the dmix plug (Fixes a problem with wine).
pcm.!default {
     type plug
     slave.pcm "duplex"
}

# Apparently this is wrong (breaks mplayer for me opening the device)
#ctl.!default {
#     type plug
#     slave.pcm "snd_card"
#}

########
# AOSS #
########
# OSS dsp0 device (OSS needs only output support, duplex will break some stuff)
pcm.dsp0 {
     type plug
     slave.pcm "output"
}

# OSS control for dsp0 (needed?...this might not be useful)
ctl.dsp0 {
     type plug
     slave.pcm "snd_card"
}

# OSS control for dsp0 (default old OSS is mixer0)
ctl.mixer0 {
     type plug
     slave.pcm "snd_card"
}
