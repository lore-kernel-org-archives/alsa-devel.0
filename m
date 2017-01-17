From: Milan Oravec <moravec@ukf.sk>
Subject: Re: SoundBlaterX G5
Date: Tue, 17 Jan 2017 22:16:28 +0100
Message-ID: <fd6095b8-c8c1-8b8b-d6b5-bc22a236e499@ukf.sk>
References: <c7f0fe10-92b0-0866-f638-96e78b6175c5@ukf.sk>
 <35808a43-245b-a075-a433-d892897b40b4@ladisch.de>
 <8893efe5-8e73-3f75-b19c-b47891383342@ukf.sk>
 <d961d16c-aa8e-18b7-226f-ede89945f5cc@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inmail2.ukf.sk (inmail2.ukf.sk [193.87.12.27])
 by alsa0.perex.cz (Postfix) with ESMTP id EB79E265142
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 22:16:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by inmail2.ukf.sk (Postfix) with ESMTP id 7FA661007DA
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 22:16:37 +0100 (CET)
Received: from inmail2.ukf.sk ([127.0.0.1])
 by localhost (inmail2.ukf.sk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DMOcpnE1KO83 for <alsa-devel@alsa-project.org>;
 Tue, 17 Jan 2017 22:16:32 +0100 (CET)
Received: from posta.ukf.sk (posta.ukf.sk [193.87.12.33])
 by inmail2.ukf.sk (Postfix) with ESMTPS id 73A8A1007D7
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 22:16:32 +0100 (CET)
In-Reply-To: <d961d16c-aa8e-18b7-226f-ede89945f5cc@ladisch.de>
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

Hi Clemens,

I'm unable to unload snd_usb_audio module because I can't find module 
locking it.

root@migo_lenovo:/home/migo# rmmod snd_usb_audio
rmmod: ERROR: Module snd_usb_audio is in use

Module                  Size  Used by
snd_usb_audio         155648  1

Is there any other way to re-probe sound-card capabilities?

I've changed clock source to direct stereo and stored configuration 
(alsactl store) for device. Now, when plugging device in and checking 
clock source property is set to direct stereo, but still no 192k.

migo@migo_lenovo:~$ cat /proc/asound/card0/stream0
Creative Technology Ltd Sound BlasterX G5 at usb-0000:00:1d.7-1.1, high 
speed : USB Audio

Playback:
   Status: Stop
   Interface 1
     Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 1 OUT (ASYNC)
     Rates: 44100, 48000, 88200, 96000
     Data packet interval: 500 us

Capture:
   Status: Stop
   Interface 2
     Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 2 IN (ASYNC)
     Rates: 44100, 48000, 88200, 96000
     Data packet interval: 500 us


Then I unloaded module with force option and modprobed it again and succes!

migo@migo_lenovo:~$ cat /proc/asound/card0/stream0
Creative Technology Ltd Sound BlasterX G5 at usb-0000:00:1d.7-1.1, high 
speed : USB Audio

Playback:
   Status: Stop
   Interface 1
     Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 1 OUT (ASYNC)
     Rates: 44100, 48000, 88200, 96000, 176400, 192000
     Data packet interval: 500 us

Capture:
   Status: Stop
   Interface 2
     Altset 1
     Format: S24_3LE
     Channels: 2
     Endpoint: 2 IN (ASYNC)
     Rates: 44100, 48000, 88200, 96000, 176400, 192000
     Data packet interval: 500 us

Now, when we have proof of concept is it possible to implement this in 
driver without this module mess please?

How can I help?

I can provide you with remote access to my computer with sound-card 
inserted when needed.

Playback tested and works. ;)

migo@migo_lenovo:~$ pactl list sink-inputs
Sink Input #2
	Driver: protocol-native.c
	Owner Module: 8
	Client: 11
	Sink: 1
	Sample Specification: float32le 2ch 192000Hz
	Channel Map: front-left,front-right
	Format: pcm, format.sample_format = "\"float32le\""  format.rate = 
"192000"  format.channels = "2"  format.channel_map = 
"\"front-left,front-right\""
	Corked: no
	Mute: no
	Volume: front-left: 61840 /  94% / -1,51 dB,   front-right: 61840 / 
94% / -1,51 dB
	        balance 0,00
	Buffer Latency: 398307 usec
	Sink Latency: 41474 usec
	Resample method: copy
	Properties:
		media.role = "video"
		media.name = "audio stream"
		application.name = "VLC media player (LibVLC 2.2.4)"
		native-protocol.peer = "UNIX socket client"
		native-protocol.version = "31"
		application.id = "org.VideoLAN.VLC"
		application.version = "2.2.4"
		application.icon_name = "vlc"
		application.language = "en_US.UTF-8"
		application.process.id = "2872"
		application.process.user = "migo"
		application.process.host = "migo_lenovo"
		application.process.binary = "vlc"
		window.x11.display = ":0"
		application.process.machine_id = "d3a60e6dc8754c9f80f7bb1e19b2d988"
		application.process.session_id = "c5"
		module-stream-restore.id = "sink-input-by-media-role:video"

Thank you for your interest and your time.

Kind regards,

Milan


s pozdravom

Milan Oravec

CIKT UKF Nitra
mobil: +421907670270
email: moravec@ukf.sk

--------------------------------------------------------------------

Tuto spravu nepreveril ziadny antivirus - nebolo treba...

On 17.01.2017 10:39, Clemens Ladisch wrote:
> Milan Oravec wrote:
>> I think when I change "Speaker Clock Source" to direct audio sound card capabilities need to be re-enumerated to update sampling rates.
>>
>> Is there any way to achieve this?
>
> Try unloading and re-loading the driver module (snd-usb-audio).
>
>
> Regards,
> Clemens
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
