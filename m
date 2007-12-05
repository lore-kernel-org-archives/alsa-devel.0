From: Die Mumie <mumie_die@yahoo.de>
Subject: Re: New Realtec ALC833 Codec in Fujitsu Siemens Xi2428
Date: Wed, 5 Dec 2007 12:26:56 +0100 (CET)
Message-ID: <787947.39976.qm@web26706.mail.ukl.yahoo.com>
References: <20071205071714.GA24527@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web26706.mail.ukl.yahoo.com (web26706.mail.ukl.yahoo.com
	[217.146.176.69]) by alsa0.perex.cz (Postfix) with SMTP id 62C88243A7
	for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2007 12:26:57 +0100 (CET)
In-Reply-To: <20071205071714.GA24527@serv.smile.org.ua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy@smile.org.ua>
Cc: ALSA Developers List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

So, first:
I have a =

-HDMI Connector
-Jack for Headphones (HP) and SPDIF
-Jack for Mic or Line
-Two built in Mics *
-Built in Speakers (I Guess that they are Stereo, but I'm not sure) *

What I can test is:
    Headphones
    Internel Speakers
    Internal Microphone

so I'm going trough the model list.

3stack-dig - Sound at HP, no IS, no Mic
6stack-dig - Front gives Sound at HP, Surround at IS, no Mic
3stack-6ch - Front gives Sound at HP, Surround at IS, no Mic
3stack-6ch-dig - Front gives Sound at HP, no IS, no Mic
6stack-dig-demo - Front gives sound at HP and IS at the same time, no switc=
hing by Jack, no Mic
acer - Front gives Sound at HP, Surround at IS, no Mic
acer-aspire - Switchs between HP and IS by plugging the HP, Headphones swit=
ch Enables/Disables sound on HP, no Mic
medion - no Sound
medion-md2 - sound on HP when HP switch is enabled, no mic
targa-dig - sound on HP when HP switch is enabled, Surround gives on IS, no=
 Mic
targa-2ch-dig - sound on HP when HP switch is enabled, no mic
laptop-eapd - Front on HP, Surround on IS, no mic
lenovo-101e -  Sound on Front Jack switching, no Mic
lenovo-nb0763 - Sound on Speaker Jack switching, no Mic
lenovo-ms7195-dig - Sound on Front same time at IS and HP, no Mic
haier-w66 - Front on HP, no Mic
6stack-hp - Nothing
3stack-hp - Front on HP, Center on IS, no Mic

I hope this helps

Andy Shevchenko <andy@smile.org.ua> schrieb: Hi Die Mumie!

 On Wed, Dec 05, 2007 at 01:47:07AM +0100, Die Mumie wrote next:

>  Also, try one of the supported models for the ALC883:
>                 3stack-dig    3-jack with SPDIF I/O
>                6stack-dig    6-jack digital with SPDIF I/O
>                3stack-6ch    3-jack 6-channel
>                3stack-6ch-dig 3-jack 6-channel with SPDIF I/O
>                6stack-dig-demo  6-jack digital for Intel demo board
>                acer          Acer laptops (Travelmate 3012WTMi, Aspire 56=
00, etc)
>                acer-aspire   Acer Aspire 9810
>                medion        Medion Laptops
>                medion-md2    Medion MD2
>                targa-dig     Targa/MSI
>                targa-2ch-dig Targs/MSI with 2-channel
>                laptop-eapd   3-jack with SPDIF I/O and EAPD (Clevo M540JE=
, M550JE)
>                lenovo-101e   Lenovo 101E
>                lenovo-nb0763 Lenovo NB0763
>                lenovo-ms7195-dig Lenovo MS7195
>                haier-w66     Haier W66
>                6stack-hp     HP machines with 6stack (Nettle boards)
>                3stack-hp     HP machines with 3stack (Lucknow, Samba boar=
ds)
>                auto          auto-config reading BIOS (default)
Did you hear some sound in the HP or internel speakers with someone of these
models? If yes, please, say what is wrong with that sound.

-- =

With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua




       =

---------------------------------
Ihr erstes Fernweh? Wo gibt es den sch=F6nsten Strand. =
