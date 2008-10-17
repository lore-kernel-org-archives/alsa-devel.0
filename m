From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: add SW_LINEOUT_INSERT support
Date: Fri, 17 Oct 2008 08:53:17 -0400
Message-ID: <48F88ABD.3010905@embeddedalley.com>
References: <48F7F600.3040706@embeddedalley.com> <s5hd4hz69ia.wl%tiwai@suse.de>
	<20081017103857.GA2546@sirena.org.uk>
	<48F8833D.8080301@embeddedalley.com>
	<20081017123928.GD2546@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 6F0F22433A
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 14:53:41 +0200 (CEST)
In-Reply-To: <20081017123928.GD2546@sirena.org.uk>
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
> On Fri, Oct 17, 2008 at 08:21:17AM -0400, Matthew Ranostay wrote:
>> Mark Brown wrote:
> 
>>> For line outputs I think providing that information in the device name
>>> would be better - the reason for providing the distinction in the switch
>>> is to provide information when the function of the device attached to
>>> the jack changes at runtime.  As far as the hardware is concerned one
>>> line output is much the same as another.
> 
>> 	err = snd_jack_new(codec->bus->card,
>> 		"Jack Detection",
>> 		SND_JACK_HEADPHONE | SND_JACK_LINEOUT, &spec->jack);
> 
>> Do you mean something like this?
> 
> I'm not sure exactly what you mean by that change.  What the code says
> is that you have a single jack and can detect at runtime if the device
> plugged into it is a line or headphone.  If that is the case then yes,
> you should do something like that though that's not a very good name for
> the jack (ideally it should correspond to something like the label given
> to the jack on the machine case).
> 
Well is generally only one HP out jack, but there can be several line-out
reported by the one instance(lineout_jack). I assume this isn't the correct usage.

>>                                   Of course this will require some changes
>> in snd_jack_report.
> 
> Could you explain what changes you think are required?  The API already
> supports multi-function jacks.
> 
