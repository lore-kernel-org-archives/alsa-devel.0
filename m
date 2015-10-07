From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: Re: Zoom R16/24 playback slient
Date: Wed, 7 Oct 2015 11:44:59 +0300
Message-ID: <5614DB8B.2000709@laiskiainen.org>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1510060847350.19610@lnxricardw1.se.axis.com>
 <56137AE7.4000601@laiskiainen.org>
 <alpine.DEB.2.02.1510070941160.17839@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a91.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id A24D22659BF
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 10:45:05 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510070941160.17839@lnxricardw1.se.axis.com>
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

On 10/07/2015 10:53 AM, Ricard Wanderlof wrote:
>
> On Tue, 6 Oct 2015, Panu Matilainen wrote:
>
>>> Having dived into this, and looking carefully at the data produced by the
>>> Windows driver, it appears that what's happening is that the driver stuffs
>>> a 32-bit length specifier at the start of each isochronous data packet.
>>>
>>> So, for instance, instead of transferring the sample data
>>>
>>> 00 12 bf 34  00 98 87 76  00 3c 24 35  00 86 75 64 .. .. (40 bytes)
>>>
>>> the Zoom driver would send:
>>>
>>> 28 00 00 00  00 12 bf 34  00 98 87 76  00 3c 24 35  00 86 75 64 ... (44 bytes)
>>>
>>> At the moment I'm considering adding some additional code to
>>> sound/usb/pcm.c: prepare_playback_urb(), governed by a new boolean in
>>> struct snd_usb_substream in a similar vain as txfr_quirk in that structure
>>> (which in turn is set in some quirk function detecting the R16).
>>>
>>> What needs to be done is to add 4 bytes to the length, and adjust the
>>> offset accordingly, in urb->iso_frame_desc[i], and then add the additional
>>> length descriptor for each packet when copying out the data further down
>>> in the same function.
>>>
>>> It would be nice to add a foo_quirk() function but since the actual
>>> copying of the data needs to be changed, it's not really possible to do
>>> efficiently with a separate routine.
>>
>> Sounds like a plan to me, but keep in mind I'm just another newbie in
>> all this. Anyway, I wouldn't worry about cleanest possible way at this
>> point, just do a quick-n-dirty hack to see if adding the length is
>> enough to get it working and worry about the rest later. I'll try to
>> have a look at it too as soon as time permits, but meanwhile if more
>> experienced people have better suggestions...
>
> I tried this out yesterday, with good results. I only had time for limited
> testing, but I managed to playback a couple of 44.1 kHz files (didn't test
> anything else) without any hitches. So this is definitely the right way to
> go. Actually it was a real joy after the R16 has been silent for a week.
> :-)

Awesome! This will make you a hero for many :)

>
> Apart from prepare_playback_urb(), I had to make a similar change to
> endpoint.c:prepare_outound_urb() which outputs silence before there is
> data to send.
>
> Patch to follow, but there are a couple of things I need to straighten out
> first:
>
> - Since we're stuffing more data in the outgoing packets, some allowance
>    must be made for this when allocating the urb->transfer_buffer. I've got
>    to review that code so that we don't spill over the end of the allocated
>    buffer in some case.
> - The best way to trigger the quirk. I'm thinking something along the
>    lines of introducing a QUIRK_AUDIO_ZOOM_INTERFACE which enables the
>    aforementioned bit in order to enable the quirk in
>    prepare_playback_urb() and prepare_output_urb(), and then calls
>    create_standard_audio_quirk() (just as QUIRK_AUDIO_STANDARD_INTERFACE
>    would have resulted in). Then it's clear in quirks-table.h that
>    something special is going on. (Currently I've added the quirk
>    initialization directly in create_standard_audio_quirk(), but it seems
>    wrong to hide it away in there).

Clearly the device not following standard here, but then all sorts of 
other quirks get silently handled behind the scenes of 
QUIRK_AUDIO_STANDARD_INTERFACE too so... If handled in 
create_standard_audio_quirk() then the quirks-table entry for the thing 
could be reduced to just:

.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
         .ifnum = QUIRK_ANY_INTERFACE,
         .type = QUIRK_AUTODETECT
}

Not that it matters a whole lot I guess.

>
> And I also need to test some more.

I'd be happy to help with testing + extra eyeballs for any 
work-in-progress patch you have. Feel free to send privately if you feel 
its not suitable for mass-consumption yet.

>
> Also, in the dump from the Windows driver I saw some form of sample rate
> control message being sent that Linux doesn't send, on the other hand,
> that was sent as part of starting capture, which already has been proven
> to work, so it might simply not be needed.

Right, good to know. While capture appears to work just fine, I wouldn't 
be surprised if there are glitches left, its probably not being used all 
that much because of the dead playback (until now of course).

	- Panu -

>
> /Ricard
>
