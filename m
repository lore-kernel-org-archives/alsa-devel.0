From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs64xx distortion (GameTheater XP)
Date: Sat, 18 Jan 2003 17:06:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E297B71.3010106@cucumelo.org>
References: <200301160014.11787.c.esken@cityweb.de> <3E273C33.9050905@cucumelo.org> <200301181213.56670.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christian Esken <c.esken@cityweb.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>I don't buy this opinion! Measurements published in sound card tests show
>a pretty good sound quality.
>  
>
Thoose review usually compares the Hercules GTXP with the Sounblaster 
Audigy with breakout box. But about personal soundcard opinions is 
something I think we should discuss outside this mailinglist ...

>But apart from that: The sound quality in Linux has NOTHING to do with
>the capabilities of the card (as it has no problems under Windwos):
>- Sound quality of the card: good (or fair or whatever you like)
>
We dont't known what kind of dirty is hack's possibly could be 
implemented  in the Windows driver to compensate the bad sound. We know 
that the DSP is able to do much more that actually is done in the Linux 
driver, reverb effects, delay, band pass filters, mp3 decoding etc. For 
example what about having a light reverb effect on front speakers, and a 
little bit more reverb on rear speakers + some delay, and let's limit 
the volume controls a little bit to get rid of the a possible 
distorcion, and some few band pass filters. Do you think that would 
improve the sound quality ?

What actually Hercules sells is more SW than HW, there is about three 
version of the Hercules GTXP 5.1, 6.1, 7.1 The the only difference 
between theese cards seems to be the delivered SW (which you probably 
never will use under Linux)

I dont discard posibility that there's something specific about the GTXP 
hw, that we dont know and we should know that could improve sound, but I 
believe that this posibilty is very small.

>- Sound quality under Linux: very very very very bad.
>  
>
It's possible to get good sound quality under Linux with the GTXP, if 
you use an external amplifier, some options that I can mention:
- External receiver with digital in, using the SPDIF output
- External receiver using the analog inputs, using the un-amplified 
outputs from the GTXP
­ - Use any kind of active speakers (speakers with it's own amplifier 
built-in)

Just dont rely to much  on the soundcard amplifier.

>So if this problem is a known issue, sholdn't there be a hint in the
>Alsa Sound Card Matrix. I don't blame anybody (except perhaps
>CS), but I think others should be warned on possible problems.
>
>  
>
If we think that this is a problem in the driver that can be fixed in 
the driver.

/Benny



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
