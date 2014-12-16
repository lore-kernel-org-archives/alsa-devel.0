From: Dylan Reid <dgreid@google.com>
Subject: Re: Streaming wake-up buffer from DSP to SoC over SPI
Date: Tue, 16 Dec 2014 00:16:40 -0800
Message-ID: <CAEUnVG4OexC99Cxbd7TF7NQxxk8wQd0WRQS8Q6mzMMY1X5PWgA@mail.gmail.com>
References: <CAEUnVG6n15vNYgZoZXzRZvgAqej1Lb3bHDEy9cyQ+UCJbuv2kg@mail.gmail.com>
 <20141216044115.GU16827@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CEEF260483
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 09:17:01 +0100 (CET)
Received: by mail-oi0-f46.google.com with SMTP id h136so9247405oig.19
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 00:17:00 -0800 (PST)
In-Reply-To: <20141216044115.GU16827@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 15, 2014 at 8:41 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, Dec 15, 2014 at 06:45:37PM -0800, Dylan Reid wrote:
>> What is the right way to model a bursty, SPI based audio transfer?
>> There could be hours between samples, then several seconds of audio
>> will be ready.
>>
>> The codec, an rt5677, is attached to the SoC with both an IIS bus and
>> a SPI bus.  The IIS bus is used for normal audio playback and record.
>> The SPI bus is used for transferring audio that caused a voice wake,
>> "OK Google" in this case.
>>
>> When the codec detects the wake up phrase, the SoC will read out two
>> plus seconds of buffered data over the SPI bus and continue to stream
>> audio data over SPI for the rest of the query.  Nexus 9 has a custom
>> ioctl to access rt5677-spi and some user-space smarts to poll for more
>> data.
> why do we need custom ioctls :( current framework can address all your
> needs..

This is what I'm trying to avoid =)

>
>> I was thinking of making a separate PCM device.  The odd things are
>> that it would have to originate from soc/codecs, the codec would own
>> the codec and cpu end of the link, and the hw_ptr position would need
>> to be queried over SPI.  But it would make userspace access to it more
>> standard looking.
> okay here we have two things and they need to be decoupled. First is
> detection by the codec for "OK Google". And second is getting the data (some
> buffered while things are setup) to usermode.
>
> For the former, the codec should implement a 'sink' for voice wake, so
> essentially connecting the voice wake widget to MIC pins will power up codec
> and codec can do the detection while rest of the system is sleeping
>
> Once the event is detected, codec should send an interrupt to host, thereby
> waking up the system. The driver will figure out that it is voice wake event
> and should set the alsa kcontrol status, on which usermode needs to listen.
>
> Now usermode knows the event occurred so lets read the data. During all the
> activation, wakeup etc some data would be buffered, in you case 2 secs. IMO
> PCM devices aren't suited for this, so you need to use a compressed device.
> The data can come from SPI port (we can get all the buffered data in one big
> burst". I know one vendor has implemented such a mechanism.
>
> The device here wont be any different than regular PCM/Compressed devices.
> Assume the data path is SPI rather than I2S so things would be modelled that
> way. You still need to setup SPI port, DMAs like you would do on I2S.

Ah, I hadn't thought about using the compressed framework.  I can see
how that would make this easier.  I'll take a closer look at it
tomorrow.

Thanks Vinod.

-Dylan

>
> HTH
> --
> ~Vinod
>
