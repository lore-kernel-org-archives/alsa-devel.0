From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: add SW_LINEOUT_INSERT support
Date: Fri, 17 Oct 2008 08:21:17 -0400
Message-ID: <48F8833D.8080301@embeddedalley.com>
References: <48F7F600.3040706@embeddedalley.com> <s5hd4hz69ia.wl%tiwai@suse.de>
	<20081017103857.GA2546@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id B427024156
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 14:21:46 +0200 (CEST)
In-Reply-To: <20081017103857.GA2546@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Oct 17, 2008 at 08:06:21AM +0200, Takashi Iwai wrote:
>> Matthew Ranostay wrote:
> 
>>> Add support for detecting line out pin insertion and reporting
>>> back to userspace with the jack abstraction layer. Line outs
>>> are reported with the macro defined SW_LINEOUT_INSERT code.
> 
>>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
>> Thanks for the patch.  Added Dmitry and Mark to Cc for review.
> 
> Matthew, as a general comment it would be helpful if you would split
> your patches up to separate out changes more and post as a series 
> rather than as a single patch.  Doing that makes review easier.  For
> example, this patch includes both an addition to the jack reporting API
> and support for using it in a particular device.
Duly noted.

> 
>> Adding one element should be fine, but I'm wondering whether more and
>> more pin type would come up in future...
> 
> That was a fear here - the conclusion was that we deal with that when it
> gets to be a problem.
> 
>>>  	SND_JACK_HEADPHONE	= 0x0001,
>>>  	SND_JACK_MICROPHONE	= 0x0002,
>>>  	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
>>> +	SND_JACK_LINEOUT	= 0x0004,
>>>  };
> 
>> So, you don't need to judge different line-outs, such as front and
>> rear?
>
No, at least not at the moment.


> For line outputs I think providing that information in the device name
> would be better - the reason for providing the distinction in the switch
> is to provide information when the function of the device attached to
> the jack changes at runtime.  As far as the hardware is concerned one
> line output is much the same as another.
>
	err = snd_jack_new(codec->bus->card,
		"Jack Detection",
		SND_JACK_HEADPHONE | SND_JACK_LINEOUT, &spec->jack);

Do you mean something like this? Of course this will require some changes
in snd_jack_report.

>>> +		err = snd_jack_new(codec->bus->card,
>>> +			"Lineout Jack",
>>> +			SND_JACK_LINEOUT, &spec->lineout_jack);
> 
> "Line Out" with two words.
> 
