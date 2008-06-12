From: andy baxter <andy@earthsong.free-online.co.uk>
Subject: Re: alsa midi tutorial
Date: Thu, 12 Jun 2008 17:25:51 +0100
Message-ID: <48514E0F.2080901@earthsong.free-online.co.uk>
References: <48514480.90802@earthsong.free-online.co.uk>
	<200806121757.49050.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pih-relay08.plus.net (pih-relay08.plus.net [212.159.14.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F72B24A3C
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 18:25:53 +0200 (CEST)
In-Reply-To: <200806121757.49050.faber@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Faber wrote:
> Andy,
>
>   
>> What I want to do is feed drum trigger signals from an arduino board
>> (a usb development board that lets you interface electronics to the
>> computer) to a midi sequencer.
>>     
>
> Why do you need to go through the computer for this? You can use the 
> arduino's serial port to send and receive MIDI commands. It's really 
> simple and there are tons of projects on the web that do exactly that.
>   
OK, but I don't have a hardware sequencer, so I was thinking that it 
would be good to write a small program in C that would translate 
incoming usb serial data from the arduino into midi data, which I could 
then feed into any linux soft synth, sequencer, or whatever.
>   
>> I had a look at the following page from the alsa api reference:
>>
>> http://www.alsa-project.org/alsa-doc/alsa-lib/seq.html
>>
>> but I'm finding it a bit hard to follow - I'm looking for something a
>> bit simpler with code examples to work through that will give me a
>> way in to alsa midi programming.
>>
>> Does anyone know of anything like this?
>>     
>
> No, but that's the wrong page. For sending MIDI data you simply open the 
> device (snd_rawmidi_open) and send your commands (snd_rawmidi_write).
>
>   
OK - I will have a look at the page on rawmidi. I thought at first this 
was a low level interface which you didn't need unless you were doing 
something quite involved which the sequencer interface didn't provide.

andy.

P.S. apologies for not sending my first reply to the list - I'm used to 
lists that set reply-to as the list address.
