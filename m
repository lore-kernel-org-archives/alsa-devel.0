From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: ca0106 Digital Output at 44.1kHz
Date: Thu, 17 Apr 2008 21:52:53 +0100
Message-ID: <4807B8A5.3080807@superbug.co.uk>
References: <1205410524.8486.274.camel@localhost>	
	<47E4E00C.2010108@superbug.co.uk>
	<1206445721.3683.45.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id D430F24A76
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Apr 2008 22:52:55 +0200 (CEST)
In-Reply-To: <1206445721.3683.45.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Stanley <Ben.Stanley@exemail.com.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ben Stanley wrote:
> 
> So, could we then change the number of channels available depending upon
> which card is detected? It doesn't seem to make sense to make things
> available to the user via the driver that they can't plug something into
> on their particular model card. I guess that to do this I would have to
> know how many digital output channels are supported by each card. I
> downloaded the user manuals for a few of the cards; I only got the
> impression that each card supported one digital output. Do you know
> which card you tested for multiple outputs?

Unfortunately the datasheets do not give me card specific details. Only 
how to program the ca0106 chip. The GPIO etc. for each card is 
determined by trial and error.

> 
> Now, the Creative Labs user documentation gives me the impression that I
> can use the analog output channels at the same time as the digital
> output channel. That also doesn't appear to agree with how the driver is
> written. I am currently under the impression that the driver is written
> to allow 4 stereo analog channels or 4 digital channels. At least that
> is how things look when configuring things using alsamixer. Perhaps I am
> confused and should go and look at the GPIO that you mentioned above.

This particular sound card can output to both analog and digital 
channels. The sound is simply duplicated to both. I disabled it 
happening at the same time mainly due to what happens when AC3 or DTS is 
output to the digital. One would not want that send to the analog outputs!

> 
>>> Details:
>>>
>>> The card I have is characterised by the following:
>>> http://www.soundblaster.com/products/product.asp?category=1&subcategory=205&product=14189
>>> Model: SB0570
>>> serial: 100a1102
>>> Also known as: Sound Blaster Audigy SE
>>>
>>> During initial testing, I noticed that 44.1kHz playback was not
>>> implemented. Subsequent testing shows that speaker-test works fine with
>>> 48kHz, 96kHz and 192kHz. (I only tested 16bit output so far.)
>>>
>>> I noticed in the source code that 44.1k was explicitly disabled. I added
>>> code in snd_ca0106_pcm_prepare_playback to set up this rate for S/PDIF
>>> output as per the comments in ca0106.h . Initial tests using hw:0,0 at
>>> 44.1kHz produced recognisable signals with some noisy corruption. Later
>>> I accidentally discovered that serially opening hw:0,2 , hw:0,1 and
>>> hw:0,0  at 44.1kHz then produces perfectly good 44.1kHz sampled digital
>>> audio output. Removing hw:0,1 or hw:0,2 from this sequence causes noisy
>>> corruption. It seems that channels 0-2 in reg40 must all be set to the
>>> same sampling frequency for S/PDIF to work where 44.1kHz is concerned.
>>> Conversely, to sucessfully output 48kHz again, I have to open hw:0,2 ,
>>> hw:0,1 and hw:0,0 at 48kHz to restore proper output. I do not have such
>>> troubles with 96kHz and 192kHz, for which it suffices to just open
>>> hw:0,0 at the relevant sampling rate.
>>>   
>> The ca0106 can do 44.1kHz for digital output ONLY.
>> The ca0106 cannot output 44.1kHz to the DACs so it will only work in 
>> Digital mode.
>> It is a hardware restriction. You are correct, all the inputs and 
>> outputs have to be at the same rate.
> 
> So far I haven't considered 'inputs', although I do now have the digital
> I/O module so that I can get digital signals into the card. I suspect I
> can only generate 44.1kHz and 48kHz sampled input signals to test with.
> 
> So for my card where only one output channel appears to be available
> (can you tell from the doc if this is true?), then I would just slave
> the other hardware channels to hw:0,0 settings. However, on other cards
> where the other channels are in fact available, how do you enforce the
> restriction that all the channels must have the same sampling frequency
> within the ALSA model?
> 
> I'm just trying to plan how I would fix this properly within the driver.

You could set the driver to fix to the rate of the first opened device, 
and only when all devices have been closed could the rate change again.
This is unfortunately not at all intuitive for the user. I would 
therefore add a global mixer control to set 44.1 or 48kHz. The user 
could then decide which to use. 44.1 would mean 44.1, 88.2 etc.
48 would mean 48, 96, 192.

By the way, the spdif output on the ca0106 works well at 96kHz also.

> 
>>
>>> Anyway, this is speculation. I'd love to have the docs. I haven't tried
>>> to get them. Is it likely/unlikely that I would get them?
>>>
>>>   
>> You can sign an open-source NDA and get the datasheets.
>> It lets me write drivers like the current ca0106 and E-Mu drivers.
>> If you are interested in a NDA, priv-email me.
> 
> I have applied to Creative's 'Partnership' program and faxed off the
> forms last week. I've written user-space drivers for custom wire-wrapped
> logic + PAL glued hardware before, but not for modern chips, or coded
> for kernel space. Anyway, there's a first time for everything :-)

Good luck. Who are you talking to?


James
