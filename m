From: "Adrian McMenamin" <adrian@mcmen.demon.co.uk>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Mon, 27 Feb 2006 17:35:22 -0000 (GMT)
Message-ID: <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
    <20060227172601.GA446@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 5B414179
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 18:35:35 +0100 (MET)
In-Reply-To: <20060227172601.GA446@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 27 February, 2006 5:26 pm, Clemens Ladisch wrote:
> Adrian McMenamin wrote:
>> How do I let my driver know that it has played a period and therefore =
it
>> needs to load more into the buffer?
>>
>> At the moment the following seems to be happening:
>>
>> Create buffer in DMA space in main CPU addressed area
>>     |
>>     |
>> Transfer contents of buffer into memory space of sound chip via DMA
>>     |
>>     |
>> Start playback
>>     |
>>     |
>> Fire interrupt for period played
>>
>> Then it gets stuck in a loop ? the interrupt is fired and handled but
>> nothing else seems to happen.
>
> ALSA will notice that something has been played when the return value o=
f
> the pointer callback changes.
>
And what happens then? ie what will the alsa subsystem do when that
changes (as it certainly will be duting the playback as it cycles through
the buffer)


> What are the contents of /proc/asound/card0/pcm0p/sub0/* while it's
> playing?
>

Cannot tell because the system is locked - ie it's repeatedly playing the
sound. I'll have to see if I can get dropbear to work (the console is
accessed over a serial line atm)


>
> Regards,
> Clemens
>




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
