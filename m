From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: cs46xx -> Terratec DMX XFire 1024 4channel output
 success
Date: Mon, 07 Apr 2003 00:23:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E90A8E0.6060507@cucumelo.org>
References: <3E873CA2.2010607@cucumelo.org> <3E8B4877.4030306@gmx.de> <3E8F5C92.8080801@cucumelo.org> <3E901DC1.9090001@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> sorry, I don't have the spec. And I think it would take some time for 
> me to understand what's going on *exactly*.
> So I just applied your last patch. But in the beginning it didn't 
> change anything. I had a look on the code of your patch and saw this
> snd_printdd("setting EAM bit on cs4294 CODEC\n");
> line. Therefore I recompiled with --with-debug=detect, installed once 
> again and switched on the syslogd on my system. I attached the cs46xx 
> specific output as messages.gz to this mail. As you can see, the EAM 
> message is not printed.
> I commented out your check for the codec type:
>
>    if (1){   //(chip->nr_ac97_codecs == 1 &&
> //       snd_cs46xx_codec_read(chip,AC97_VENDOR_ID2,
> //                 CS46XX_PRIMARY_CODEC_INDEX) == 0x5d2d) {
>        /* set primary cs4294 codec into Extended Audio Mode */
>
> recompiled, reinstalled and...
> ... 4 channel output works!!!
> It seems like I cannot change the output volume of the 
> back('headphone') channels. The PCM slider only controls the 
> first('front') output.
>
> What information do you need to get the codec check working (alsamixer 
> tells me 'Cirrus Logic CS4294 rev 5'). Just tell me what I should do :)
>

The intention with that if(...) statment was to make sure that there was 
only one codec available and that codec was a cs4294.

Could you test it again chaning the "0x5d2d" to "0x592d" ? (my misstake ...)
If that dont work could you send me a dump of /proc/asound/card0/ac97#0regs

I believe it should be possible to control the volume from the second 
output, just need to find out how, so I'll try to find something in the 
bloody cs4294 spec., well, and hopefully something will happen to the 
code ;)

/Benny



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
