From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: Re: Zoom R16/24 playback slient
Date: Wed, 30 Sep 2015 11:34:49 +0300
Message-ID: <560B9EA9.2090304@laiskiainen.org>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1509300955510.12892@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a57.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B0A32659FF
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 10:34:55 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1509300955510.12892@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/30/2015 11:05 AM, Ricard Wanderlof wrote:
>
> On Wed, 30 Sep 2015, Panu Matilainen wrote:
>
>>> Where does the above output come from, and where could I find information
>>> on what type of data is expected? I assume what's expected is something
>>> one would get from an USB mixer device?
>>
>> The output is simply 'lsusb -v' plus manually added guesses as to what
>> these unrecognized bits are.
>
> Ah, I should have guessed as much... (I was looking in the kernel for some
> USB debug thing via /sys or similar).
>
>> As for the mixer, I concluded the Zoom does not really have one. The
>> interface 0 is a control interface where a mixer would reside, but
>> there's no actual mixer unit in there.
>
> I wonder if any information could be gleaned from running the Windows
> driver and somehow snooping the USB bus.
>
> There must be some way of enabling the playback stream.

I do have an usb dump of Windows initializing the thing and can/will 
share and/or generate new ones if you/others want to have a look. It 
hasn't helped me so far, problem being I dont really know what to look 
for in the first place.

>> My memory is a bit hazy on the details, but the automatically detected
>> SNDRV_PCM_FMTBIT_S32 (which iirc means the actual 24bit values are
>> carried in 32bit chunks) seems to be the right thing for the device,
>> forcing it to something else just makes things worse. IIRC.
>
> I think that many devices put 24 bits in the most significant bits of a 32
> bit word, hence SNDRV_PCM_FMTBIT_S32 works fine, and the device simply
> disregards the lowest 8 bits. I don't know about USB, but I've come across
> SoC devices where it is the lower 24 bits that carry the data, in which
> case SNDRV_PCM_FMTBIT_S24LE is needed, and then there are devices which
> really handle the data in 24 bit chunks, using SNDRV_PCM_FMTBIT_S24_3LE.
>
> At any rate this issue seems to be cleared up.
>
>> Another finding from my last round in the spring I do remember clearly,
>> is that enabling both the input and output interfaces makes things hang
>> up (timeouts and nothing really works). But if you disable the input
>> interface and enable the output interface, you get an apparently working
>> playback stream. Only no sound comes out. If you disable the output and
>> enable input, capture itself works fine.
>
> Ok, thanks for that tidbit, I'd read about problems with simulatenous
> capture and playback in previous threads; I thought perhaps (hopefully...)
> the only remaining issue was the silent playback.
>
>> So perhaps it needs another quirk similar in spirit to the E-Mu:
>>
>>           /* When capture is active
>>            * sample rate shouldn't be changed
>>            * by playback substream
>>            */
>>           if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK) {
>>                   if
>> (subs->stream->substream[SNDRV_PCM_STREAM_CAPTURE].interface != -1)
>>                           return;
>
> So your theory is that reconfiguring the device once opened for one
> direction is what causes it to hang?

IIRC you start getting hangs accompanied with "cannot get/set freq XXX 
to ep Y" (or similar) messages when you try to open both. For a single 
interface at a time, those messages went away by adding the small delay, 
but adding more delay doesn't help with the case where both are active.

So to me the evidence seems to suggest it only supports a global 
frequency for the device, instead of per interface. Which, considering 
what the device is, seems quite reasonable.

>
>> Or something. I do intend to continue poking at it sooner or later but
>> can't make any promises.
>
> I understand. Since I have a setup at home that works now I thought I'd
> take a look at it and see how far I get.

Cool.

	- Panu -

>
> /Ricard
>
