From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: cs64xx distortion (GameTheater XP)
Date: Sat, 18 Jan 2003 19:04:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E299737.9000506@gmx.de>
References: <200301160014.11787.c.esken@cityweb.de> <3E273C33.9050905@cucumelo.org> <200301181213.56670.c.esken@cityweb.de> <3E297B71.3010106@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E297B71.3010106@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Christian Esken <c.esken@cityweb.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Benny Sjostrand wrote:

> We dont't known what kind of dirty is hack's possibly could be 
> implemented  in the Windows driver to compensate the bad sound. We 
> know that the DSP is able to do much more that actually is done in the 
> Linux driver, reverb effects, delay, band pass filters, mp3 decoding 
> etc. For example what about having a light reverb effect on front 
> speakers, and a little bit more reverb on rear speakers + some delay, 
> and let's limit the volume controls a little bit to get rid of the a 
> possible distorcion, and some few band pass filters. Do you think that 
> would improve the sound quality ?
>
> What actually Hercules sells is more SW than HW, there is about three 
> version of the Hercules GTXP 5.1, 6.1, 7.1 The the only difference 
> between theese cards seems to be the delivered SW (which you probably 
> never will use under Linux)
>
> I dont discard posibility that there's something specific about the 
> GTXP hw, that we dont know and we should know that could improve 
> sound, but I believe that this posibilty is very small.

I didn't hear this 'bad' sound quality of the GTXP because I've a cs46xx 
based terratec DMX XFire. The sound quality of the XFire is exactly the 
same as under windows, i.e. much better than a cheap $10 soundcard. 
There's not much hardware on the XFire: Basically just the CS4624, a 
CS4294 codec and two LM386 amplifiers (very cheap 1 watt amps). The 
windows driver of the XFire doesn't change the sound in any way like 
adding reverberation, stereo expanding or equalizing (It does only, if 
you tell it to do), i.e. the card acts as a transparent system that just 
outputs every sample like it was told by any application. I think that 
will be also the case for the GTXP under windows (but I can't check as I 
don't own this card). There seem to be other hardware components on the 
GTXP wich are not correctly initialized.

>
>> - Sound quality under Linux: very very very very bad.
>>  
>>
> It's possible to get good sound quality under Linux with the GTXP, if 
> you use an external amplifier, some options that I can mention:
> - External receiver with digital in, using the SPDIF output
> - External receiver using the analog inputs, using the un-amplified 
> outputs from the GTXP
> ­ - Use any kind of active speakers (speakers with it's own amplifier 
> built-in)
>
> Just dont rely to much  on the soundcard amplifier.

If the GTXP is used in the same way as under windows (e.g. line output 
connected to external amp or active speakers), the sound quality should 
be more or less the same.
As Christian says the sound quality is very ve...ry bad, I think it must 
be related with card initialization (something like the DC offset 
problem with the XFire or a not powered up amplifier).

I do not think that the driver has to do some equalization to get good 
quality. The hardware on this card should deliver good quality without 
software tricks. (Of course correct initialization is necessary which 
could perhaps easily done *with some more help provided by this "Cirrus" 
company*).

Chrisian, perhaps you can specify/describe the type of distortion more 
precisely so that it's easier to guess the reason for the bad sound.
Does it sound like overload?
Is the output unequalized, i.e. lack of low or high frequency components.
Are quiet sounds also/more/less distorted? Especially: Are sounds below 
a volume threshold not ouput, quite sounds totally muted?
You reported that lowering pcm/master volume makes the quality somewhat 
better. What about playing back quiet sounds with pcm/master volume 
turned up compared to playing back loud sounds with pcm/master volume 
turned down?
Do you get different quality depending on the analog output used (line 
out with external amp compered to speaker output)?
I don't know about the possibility of the GTXP to power down the 
internal amps. If the sound at line output is ok, that could be the 
reason for the bad quality.




-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
