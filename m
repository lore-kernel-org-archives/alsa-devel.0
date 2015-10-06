From: Panu Matilainen <pmatilai@laiskiainen.org>
Subject: Re: Zoom R16/24 playback slient
Date: Tue, 6 Oct 2015 10:40:23 +0300
Message-ID: <56137AE7.4000601@laiskiainen.org>
References: <alpine.DEB.2.02.1509292156390.6263@lnxricardw1.se.axis.com>
 <560B8481.1080304@laiskiainen.org>
 <alpine.DEB.2.02.1510060847350.19610@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a93.g.dreamhost.com (sub5.mail.dreamhost.com
 [208.113.200.129])
 by alsa0.perex.cz (Postfix) with ESMTP id A6748264F3F
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 09:40:28 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510060847350.19610@lnxricardw1.se.axis.com>
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

On 10/06/2015 10:02 AM, Ricard Wanderlof wrote:
>
> On Wed, 30 Sep 2015, Panu Matilainen wrote:
>
>> My memory is a bit hazy on the details, but the automatically detected
>> SNDRV_PCM_FMTBIT_S32 (which iirc means the actual 24bit values are
>> carried in 32bit chunks) seems to be the right thing for the device,
>> forcing it to something else just makes things worse. IIRC. The delay
>> was a key part, but not enough.
>>
>> Another finding from my last round in the spring I do remember clearly,
>> is that enabling both the input and output interfaces makes things hang
>> up (timeouts and nothing really works). But if you disable the input
>> interface and enable the output interface, you get an apparently working
>> playback stream. Only no sound comes out. If you disable the output and
>> enable input, capture itself works fine.
>
> Having dived into this, and looking carefully at the data produced by the
> Windows driver, it appears that what's happening is that the driver stuffs
> a 32-bit length specifier at the start of each isochronous data packet.
>
> So, for instance, instead of transferring the sample data
>
> 00 12 bf 34  00 98 87 76  00 3c 24 35  00 86 75 64 .. .. (40 bytes)
>
> the Zoom driver would send:
>
> 28 00 00 00  00 12 bf 34  00 98 87 76  00 3c 24 35  00 86 75 64 ... (44 bytes)

Wow, nice detective work! :)

>
> No wonder the Zoom gets confused when it gets sent ordinary sample data,
> and tries to interpret the first sample value as a length.

Heh, indeed.

> There doesn't seem to be anything in the ALSA USB driver to do this, and
> I'm thinking it's Zoom specific (perhaps to overcome some deficiency in
> the hardware (or USB firmware) in the R16?).
>
> I'm trying to figure out where would be the best place to add a quirk for
> this. Input from anyone knowledgeable about the ALSA USB system would be
> very helpful.
>
> At the moment I'm considering adding some additional code to
> sound/usb/pcm.c: prepare_playback_urb(), governed by a new boolean in
> struct snd_usb_substream in a similar vain as txfr_quirk in that structure
> (which in turn is set in some quirk function detecting the R16).
>
> What needs to be done is to add 4 bytes to the length, and adjust the
> offset accordingly, in urb->iso_frame_desc[i], and then add the additional
> length descriptor for each packet when copying out the data further down
> in the same function.
>
> It would be nice to add a foo_quirk() function but since the actual
> copying of the data needs to be changed, it's not really possible to do
> efficiently with a separate routine.


Sounds like a plan to me, but keep in mind I'm just another newbie in 
all this. Anyway, I wouldn't worry about cleanest possible way at this 
point, just do a quick-n-dirty hack to see if adding the length is 
enough to get it working and worry about the rest later. I'll try to 
have a look at it too as soon as time permits, but meanwhile if more 
experienced people have better suggestions...

	- Panu -
