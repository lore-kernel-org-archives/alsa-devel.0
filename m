From: "John W. Cocula" <john@cocula.com>
Subject: Re: any support for realtech sound chip
Date: Thu, 22 Jan 2004 15:35:21 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <65120.138.88.11.209.1074803721.squirrel@cocula.com>
References: <m3llnz25uf.fsf@ccs.covici.com>
    <65072.138.88.11.209.1074802308.squirrel@cocula.com>
    <401030A7.5050604@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <401030A7.5050604@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi James,

It was your program that further confirmed that it does not work for me!

$ ./speaker-test -Drear -c 2

speaker-test 0.0.3

Playback device is rear
Stream parameters are 48000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
ALSA lib pcm.c:1812:(snd_pcm_open_conf) Invalid type for PCM rear
definition (id: rear, value: cards.pcm.rear)
Playback open error: Invalid argument


I'm using ALSA 1.0.1.  What is different???

Thanks,
John

James Courtier-Dutton said:
> 5.1 Audio works fine on my ALC650 rev 3 chip.
> I have a Intel ICH5 chip controlling it.
> Try my speaker-test program from
> http://www.superbug.demon.co.uk/speaker-test/
>
> Cheers
> James
>
>
> John W. Cocula wrote:
>> The Realtek ALC650 rev 3 chip, in my Shuttle SB62G2, is supported by the
>> intel8x0 driver.
>>
>> HOWEVER, and I have a headache from it at this very moment, I've just
>> learned that the driver does not support anything but the front L and R
>> channels for output.
>>
>> Can anyone tell me what is involved in evolving the driver so that it
>> will
>> support all 6 playback channels?  Please someone tell me what I can do
>> to
>> help make this come to pass!
>>
>> Many thanks,
>> John
>>
>> Now to find some ibuprofen.
>>
>>
>> John Covici said:
>>
>>>Hi.  I would like to use a Shuttle An50R which supports the Athlon 64
>>>under Linux, but their sound chip is an ac97 audio Realtech.  What
>>>module would support such a beast or is it not possible to use ALSA
>>>with that chip?
>>>
>>>Thanks.
>>>
>>>--
>>>         John Covici
>>>         covici@ccs.covici.com
>>>
>
>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
