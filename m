From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Mon, 07 May 2007 22:51:24 +0200
Message-ID: <463F914C.7090600@gmail.com>
References: <20070507054604.75A781CE303@ws1-6.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BFC8245BD
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2007 22:53:55 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so1628698wxd
	for <alsa-devel@alsa-project.org>; Mon, 07 May 2007 13:53:53 -0700 (PDT)
In-Reply-To: <20070507054604.75A781CE303@ws1-6.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramkromberg@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/07/2007 07:46 AM, ramkromberg@mail.com wrote:

> I have an old "AzTech Sound Galaxy Nova 16 Extra II-3D - using AZT-2316/R
>  Chipset - FCC-ID:I38-MMSN846"

I have a few similar cards. Also a "Nova 16 Extra" in fact, but that one an 
older AZT1605 based version (I38-MMSN811). My closest match is probably a 
"Sound Galaxy Waverider Pro 32-3D" (I38-MMSN811852) which is a AZT2316R + 
CS4231 (+ an AZT3321 wavetable). Have a number of AZT2316A cards as well.

> I believe the card is unsupported in alsa and I was hoping someone might
> be free to help me with this legacy card ?

It's at least "unsupported" in the sense that noone is supporting it yes :-)

As you have noticed, snd-sgalaxy will not work for this card. "sgalaxy" is 
actually a really unfortunate name for that driver as Aztech named _all_ 
their cards "Sound Galaxy" and snd-sgalaxy only drives the couple with a 
AZT1605 chip on them. The module should preferably be renamed.

As you also found out, snd-azt2320 will not work as is as that's an ISA-PnP 
only driver and the AZT2316A/R is legacy ISA. The drivers are not more than 
shells around the cs4231 library though and can be made to work with 
relative ease. I was actually working on snd-sgalaxy a while ago and briefly 
looked at my azt2316 cards as well but a few other things intervened again.

Let's first see if your card is as expected. It should have a "JMPB0" on it 
somewhere that you can use to choose between 0x22x and 0x24x as the base 
address. Look which one it's using (the windows driver will also tell). 
Then, there should be a "JMPCFG" jumper on the card somewhere where 1-2 
means "use EEPROM settings" and 2-3 "use software settings". For use in 
Linux, you should (at least for now) set it to EEPROM so that the card will 
enable itself and not wait for the driver to do so.

If you have that done, you should already be able to use it in it's basic 
Soundblaster Pro mode. Try loading snd-sb8 with:

	modprobe snd-sb8 port=0x220 irq=5 dma8=1

This is not unlikely to work (change 0x220 to 0x240 if the jumper is set to 
the other one ofcourse). If it's giving you a load "hum" on the speakers 
immediately after loading use the DOS mixer application to mute all and save 
to the EEPROM.

I can help with getting the rest to work (where "the rest" is the MIDI port 
and the cs4231 codec which it offers instead of the sb8 mode as well) in a 
few weeks time, but maybe you won't even care greatly -- it's "instead of" 
and while the cs4231 is in principle the better chip these days it's all 
water under the bridge; they're _both_ old crap. But yes, I'll also want my 
2316A/R cards supported again so if you have a while, I'll get to it...

Rene.
