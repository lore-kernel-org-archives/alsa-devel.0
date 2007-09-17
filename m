From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] sscape: support for audio part of VIVO
	cards
Date: Mon, 17 Sep 2007 16:02:13 +0200
Message-ID: <46EE88E5.1010208@gmail.com>
References: <20070916225024.b72b4547.krzysztof.h1@gmail.com>	<s5hodg1eaox.wl%tiwai@suse.de>
	<20070917155803.8ed52f7d.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id AFFAA103863
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 16:03:02 +0200 (CEST)
In-Reply-To: <20070917155803.8ed52f7d.krzysztof.h1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/17/2007 03:58 PM, Krzysztof Helt wrote:

> On Mon, 17 Sep 2007 14:30:22 +0200
> Takashi Iwai <tiwai@suse.de> wrote:
> 
>> At Sun, 16 Sep 2007 22:50:24 +0200,
>> Krzysztof Helt wrote:
>>> @@ -358,6 +360,8 @@ static void soundscape_free(struct snd_c
>>>  {
>>>  	register struct soundscape *sscape = get_card_soundscape(c);
>>>  	release_and_free_resource(sscape->io_res);
>>> +	if (sscape->wss_res)
>>> +		release_and_free_resource(sscape->wss_res);
>> You don't need NULL check here.
>>
> 
> I need it as the SS PnP does not request a separate region for codec 
> (wss_port). So the SS PnP do not allocate this resource and it must not
> be freed.

release_and_free-resource() checks for NULL itself, by design.

Rene.
