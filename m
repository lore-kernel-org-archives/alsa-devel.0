From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Midisport 2x2 Anniversary edition,
	latency	problem
Date: Wed, 29 Apr 2015 09:14:03 +0200
Message-ID: <554084BB.1090304@ladisch.de>
References: <1430209117.53049092@f91.i.mail.ru>	<1430230406.500088555@f412.i.mail.ru>
 <553FB37B.3000802@ladisch.de> <1430239699.153166263@f195.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 2E9AB260453
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 09:14:08 +0200 (CEST)
In-Reply-To: <1430239699.153166263@f195.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ilya Dikariev <dik_again@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ilya Dikariev wrote:
>>>>> I bought a MIDI-interface von M-Audio (see subject), but there are
>>>>> strange things with it on my desktop (Arch, latest kernel). The
>>>>> latency is about 5 seconds.
>>>>
>>>> How are you measuring the latency?
>>>
>>> I measured it only with my feeling of time.
>>
>> What are the specific events between which there is an interval of
>> 5 seconds?
>
> Between I press any key on a MIDI-keyboard and I hear the sound from
> the timidity-daemon (or any other MIDI-reciever in a computer).

There are lots of components involved besides the USB/MIDI interface:
Timidity, any sound server (if you're using one), and the sound card's
drivers.

It is extremely unlikely that the USB/MIDI interface could introduce
latency, because the only way to do that would be to go to the extra
effort of storing the MIDI events in some buffer, and then transmitting
them later.

> the MIDI events from the Pitch-wheel on the keyboard arrives the MIDI-
> reciever immedietly (I saw it, when i tried to check out the output
> from the /dev/midi).

This proves that another component introduces the latency.

(Note: you could also use amidi or aseqdump to do these tests.)


How did you configure the audio output of Timidity?


Regards,
Clemens
