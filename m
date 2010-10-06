From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Wed, 06 Oct 2010 16:38:34 +0200
Message-ID: <4CAC89EA.8080207@ladisch.de>
References: <4C9DC7A1.8050001@showlabor.de>
	<4CA5BF35.2030108@showlabor.de>	<4CA60C5B.6010809@ladisch.de>
	<4CA86E1A.30405@showlabor.de> <4CAAD212.9090805@ladisch.de>
	<4CAC804A.8040806@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 912D6103981
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 16:37:53 +0200 (CEST)
In-Reply-To: <4CAC804A.8040806@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> Am 05.10.2010 09:21, schrieb Clemens Ladisch:
>> Felix Homann wrote:
>>> Trying to log the value of f reveals that retire_playback_sync_urb()
>>> doesn't seem to be called at all.
>> 
>> The entire function or that part of the code?
> 
> The entire function. I had placed a printk at the very beginning of 
> retire_playback_sync_urb() whose output doesn't show up.
> 
>> Anyway, please try the patch below, which makes the driver
>> autodetect the feedback format.  (The actual format can be
>> seen in /proc/asound/cardX/stream0 while running.)
> 
> Playback:
>    Status: Running
>      Interface = 1
>      Altset = 1
>      URBs = 3 [ 57 57 57 ]
>      Packet Size = 312
>      Momentary freq = 48000 Hz (0x6.0000)
>    Interface 1
>      Altset 1
>      Format: S24_3LE
>      Channels: 8
>      Endpoint: 1 OUT (ADAPTIVE)
>      Rates: 44100, 48000, 88200, 96000
>      Data packet interval: 125 us
> 
> Does it tell us anything?

That this device does not use frequency feedback.

What happens when you are recording something and then try to play
something else with a different sample rate? (use arecord/aplay with
"-D hw:X")


Regards,
Clemens
