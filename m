From: Caleb Crome <caleb@crome.org>
Subject: Re: Need general idea how to architect driver for
 multi-codec board
Date: Wed, 11 May 2011 15:44:42 -0700
Message-ID: <BANLkTi=1dAzpRGTrS=p8ZGN81PQfeOauzQ@mail.gmail.com>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
	<20110511175021.GB22798@sirena.org.uk>
	<BANLkTi=mKjPhgjmmxG2C34xLzisYuyY0rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id BE08324430
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 00:44:46 +0200 (CEST)
Received: by pzk26 with SMTP id 26so528679pzk.38
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 15:44:43 -0700 (PDT)
In-Reply-To: <BANLkTi=mKjPhgjmmxG2C34xLzisYuyY0rg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi again,
   I've been poking through the soc-core.c and other soc files, and I'm
still at a bit of a loss how to add 8 cocdecs on 3 different I2C (virtual)
busses onto one card.

Do I set up my 'card'  with multiple codecs as multiple dai links?

static struct snd_soc_dai_link puppy_dai[] =
{
        {
                .name = "puppy",
                .stream_name = "puppy",
                .cpu_dai_name = "omap-mcbsp-dai.0",
                .platform_name = "omap-pcm-audio",
                .codec_dai_name = "tlv320aic3x-se-hifi",
                .codec_name = "tlv320aic3x-se-codec.4-0018",
                .ops = &puppy_ops,
        }, {
                .name = "puppy",
                .stream_name = "puppy",
                .cpu_dai_name = "omap-mcbsp-dai.0",
                .platform_name = "omap-pcm-audio",
                .codec_dai_name = "tlv320aic3x-se-hifi",
                .codec_name = "tlv320aic3x-se-codec.4-0019",
                .ops = &puppy_ops,
        },
...   6 more codecs ...
}

static struct snd_soc_card snd_soc_puppy = {
        .name = "tlv320aic33-se",
        .owner = THIS_MODULE,
        .dai_link = puppy_dai,
        .num_links = ARRAY_SIZE(puppy_dai),

};

I'm afraid I don't understand how it's supposed to work.  How do I get the
sound card to understand the multiple codecs?  Is the above the right
direction, or am I way off?

All the examples of multiple links on one card all seemed to be exlcusive of
one another, and ran over different cpu DAIs.  I need these all to run on
the same CPU DAI but TDMd.

Is each codec supposed to have its own substream, or do they all get
aggregated into one 16-channel substream?


Thanks again,
   -Caleb

On Wed, May 11, 2011 at 11:29 AM, Caleb Crome <caleb@crome.org> wrote:

> Well, that does sound easier than rewriting the whole thing.  I'll give it
> a go at instantiating multiple codecs.
>
> Would this be 'substreams' or is that something else?
>
> Sorry to be ignorant, but I'm a newbie to kernel development (I've
> successfully brought up GPIOs and the I2C mux on my board, so I at least
> have some simple stuff under my belt).
>
> Thanks again,
>   -Caleb
>
>
>
> On Wed, May 11, 2011 at 10:50 AM, Mark Brown <
> broonie@opensource.wolfsonmicro.com> wrote:
>
>> On Wed, May 11, 2011 at 10:31:15AM -0700, Caleb Crome wrote:
>>
>> > 1)  Simply instantiate multiple TLV320IAC33 codec drivers, as the AIC33
>> > driver is already written.
>>
>> Yes.
>>
>> >     This seems like it won't work because I'd end up with multiple
>> > user-space 'cards', yet I want the card to appear as a single 16-channel
>> > sound card.  Also, when you start one PCM interface for one codec, they
>>
>> No, you shouldn't.  You'll end up with a single card.
>>
>> > would all start automatically, which I imagine the linux system wouldn't
>> > get.  Also, the PCM interface needs to be configured differently for
>> each
>> > codec (the TDM offset must be 0, 16, 32, 48, etc. bits).
>>
>> The TDM stuff should be configured with the existing TDM API (you may
>> need to implement this in the CODEC driver).
>>
>
>
