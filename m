From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Wed, 06 Oct 2010 15:57:30 +0200
Message-ID: <4CAC804A.8040806@showlabor.de>
References: <4C9DC7A1.8050001@showlabor.de>
	<4CA5BF35.2030108@showlabor.de>	<4CA60C5B.6010809@ladisch.de>
	<4CA86E1A.30405@showlabor.de> <4CAAD212.9090805@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id C9C3E103832
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 15:57:33 +0200 (CEST)
In-Reply-To: <4CAAD212.9090805@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Am 05.10.2010 09:21, schrieb Clemens Ladisch:
> Felix Homann wrote:
>    
>>
>> Trying to log the value of f reveals that retire_playback_sync_urb()
>> doesn't seem to be called at all.
>>      
> The entire function or that part of the code?
>
>    

The entire function. I had placed a printk at the very beginning of 
retire_playback_sync_urb() whose output doesn't show up.

> Anyway, please try the patch below, which makes the driver
> autodetect the feedback format.  (The actual format can be
> seen in /proc/asound/cardX/stream0 while running.)
>
> Alex, please test this with your widget.
>
>    

Here's what I get:


:~$ cat /proc/asound/card2/stream0
M-Audio Fast Track Ultra 8R at usb-0000:00:1a.7-4, high speed : USB Audio

Playback:
   Status: Running
     Interface = 1
     Altset = 1
     URBs = 3 [ 57 57 57 ]
     Packet Size = 312
     Momentary freq = 48000 Hz (0x6.0000)
   Interface 1
     Altset 1
     Format: S24_3LE
     Channels: 8
     Endpoint: 1 OUT (ADAPTIVE)
     Rates: 44100, 48000, 88200, 96000
     Data packet interval: 125 us

Capture:
   Status: Running
     Interface = 2
     Altset = 1
     URBs = 8 [ 8 8 8 8 8 8 8 8 ]
     Packet Size = 312
     Momentary freq = 48000 Hz (0x6.0000)
   Interface 2
     Altset 1
     Format: S24_3LE
     Channels: 8
     Endpoint: 1 IN (ASYNC)
     Rates: 44100, 48000, 88200, 96000
     Data packet interval: 125 us



Does it tell us anything?

Kind regards,

Felix
