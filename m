From: Dan McGhee <beesnees@grm.net>
Subject: snd_hda_intel and Beats Audio
Date: Thu, 19 Dec 2013 11:05:31 -0600
Message-ID: <52B3275B.3070709@grm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp650.redcondor.net (smtp650.redcondor.net [208.80.206.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 47B652654B7
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 18:05:38 +0100 (CET)
Received: from cgp.netins.net ([167.142.229.103])
 by smtp650.redcondor.net ({9ef01f99-b982-4add-83fd-b7c41c74273c})
 via TCP (outbound) with ESMTP id 20131219170536188
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 17:05:36 +0000
Received: from [72.35.180.39] (account beesnees@grm.net HELO [192.168.1.8])
 by cgpf2.cgp.netins.net (CommuniGate Pro SMTP 5.3.13)
 with ESMTPA id 643631463 for alsa-devel@alsa-project.org;
 Thu, 19 Dec 2013 11:05:31 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have an HP Envy m6 Sleekbook model k010 with Beats Audio.  My system 
is LFS-7.4 and BLFS-7.4.  I have subscribed to this list in order to get 
the sound on my laptop working and also, hopefully, to provide you with 
info on what might need to be done in the hda_intel driver.  If this 
list is not the appropriate one in which to do this, I will be more than 
happy to unsubscribe to it and get on the "users" list.

In the hope that this situation is acceptable for this list--and please 
let me know if it's not--let me continue.

Except for video replay, sound and printing my build is complete.  I do 
not have any other sound applications or "helpers" installed, 
particularly PulseAudio, except gstreamer which is for dependencies.  
I'm using xcfe4 desktop. In my troubleshooting and research I discovered 
"hda-jack-retask."  I installed it and have been "poking around" for 
awhile unsuccessfully.  I guess I just don't understand the "pin out."  
This particular laptop has two speakers and a woofer.

I ran "alsa-info.sh" and here is the section on the pins:

> /sys/class/sound/hwC0D0/init_pin_configs:
> 0x03 0x185600f0
> 0x05 0x585600f0
> 0x07 0x585600f0
> 0x09 0x585600f0
> 0x0b 0x585600f0
> 0x0d 0x585600f0
and

> /sys/class/sound/hwC1D0/init_pin_configs:
> 0x0a 0x03a11020
> 0x0b 0x0321101f
> 0x0c 0x40f000f0
> 0x0d 0x92170110
> 0x0e 0x40f000f0
> 0x0f 0x40f000f0
> 0x10 0x40f000f0
> 0x11 0xd5a30130
> 0x1f 0x40f000f0
If you need the results of the whole script, I will run it again and 
provide the link.

I just don't understand the mapping for the pins to be able to 
"override" them in hda-jack-retask.

Here is more, I hope helpful info.

Output from "speaker-test"--whether run as root or an unprivileged user:

> speaker-test 1.0.27.2
>
> Playback device is default
> Stream parameters are 48000Hz, S16_LE, 1 channels
> Using 16 octaves of pink noise
> Channels count (1) not available for playbacks: Invalid argument
> Setting of hwparams failed: Invalid argument

 From "aplay -L

> null
>     Discard all samples (playback) or generate zero samples (capture)
> hdmi:CARD=HDMI,DEV=0
>     HDA ATI HDMI, HDMI 0
>     HDMI Audio Output
> sysdefault:CARD=Generic
>     HD-Audio Generic, 92HD91BXX Analog
>     Default Audio Device
> front:CARD=Generic,DEV=0
>     HD-Audio Generic, 92HD91BXX Analog
>     Front speakers
> surround40:CARD=Generic,DEV=0
>     HD-Audio Generic, 92HD91BXX Analog
>     4.0 Surround output to Front and Rear speakers
> surround41:CARD=Generic,DEV=0
>     HD-Audio Generic, 92HD91BXX Analog
>     4.1 Surround output to Front, Rear and Subwoofer speakers
> surround50:CARD=Generic,DEV=0
>     HD-Audio Generic, 92HD91BXX Analog
>     5.0 Surround output to Front, Center and Rear speakers
> surround51:CARD=Generic,DEV=0
>     HD-Audio Generic, 92HD91BXX Analog
>     5.1 Surround output to Front, Center, Rear and Subwoofer speakers
> surround71:CARD=Generic,DEV=0
>     HD-Audio Generic, 92HD91BXX Analog
>     7.1 Surround output to Front, Center, Side, Rear and Woofer speakers

I will be grateful for any help.  Also, once again, if this list is not 
the appropriate one, please let me know and I'll go to "users."

Thanks,
Dan
