From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Wed, 06 Oct 2010 18:31:45 +0200
Message-ID: <4CACA471.2000504@showlabor.de>
References: <4C9DC7A1.8050001@showlabor.de>	<4CA5BF35.2030108@showlabor.de>	<4CA60C5B.6010809@ladisch.de>	<4CA86E1A.30405@showlabor.de>
	<4CAAD212.9090805@ladisch.de>	<4CAC804A.8040806@showlabor.de>
	<4CAC89EA.8080207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id 007B5244E6
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 18:31:50 +0200 (CEST)
In-Reply-To: <4CAC89EA.8080207@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Clemens for your quick response!

Am 06.10.2010 16:38, schrieb Clemens Ladisch:
>>
>> Playback:
>>     Status: Running
>>       Interface = 1
>>       Altset = 1
>>       URBs = 3 [ 57 57 57 ]
>>       Packet Size = 312
>>       Momentary freq = 48000 Hz (0x6.0000)
>>     Interface 1
>>       Altset 1
>>       Format: S24_3LE
>>       Channels: 8
>>       Endpoint: 1 OUT (ADAPTIVE)
>>       Rates: 44100, 48000, 88200, 96000
>>       Data packet interval: 125 us
>>
>> Does it tell us anything?
>>      
> That this device does not use frequency feedback.
>
> What happens when you are recording something and then try to play
> something else with a different sample rate? (use arecord/aplay with
> "-D hw:X")
>
>    

When I start recording at 44.1 kHz while playing a wav at 48 kHz the 
playback gets very distorted, sounds like lots of missing samples. I get 
this from stream0:

M-Audio Fast Track Ultra 8R at usb-0000:00:1a.7-4, high speed : USB Audio

Playback:
   Status: Running
     Interface = 1
     Altset = 1
     URBs = 2 [ 5 6 ]
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
     Momentary freq = 44100 Hz (0x5.8333)
   Interface 2
     Altset 1
     Format: S24_3LE
     Channels: 8
     Endpoint: 1 IN (ASYNC)
     Rates: 44100, 48000, 88200, 96000
     Data packet interval: 125 us


The sound stays corrupted until I record at 48 kHz again. Then 
everything sounds as before, i.e. with thos noticable clicks we're 
trying to sort out.

Do you need more infos?

Regards,

Felix
