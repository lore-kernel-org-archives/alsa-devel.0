From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: emu10k1 + audigy
Date: Wed, 18 Aug 2004 12:35:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408181035.i7IAZ5oW013133@www3.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Then, what way I should follow ???

>>=20
>> Hi,
>>=20
>> Question: How to add full support for audigy DSP to emu10k1 driver ???
>>
>> Audigy has 2 times more GPRs as sb live.=20
>> Audigy has 2 times more istruction as sb live.
>> Audigy has more tram lines as sb live (192 internal vs. 128 on sb
>> live, 64 external vs. 32 on sb live).
>>=20
>> I use attached patch (audigy_v4.diff) to do this, but this will break
>> binary compatibility for other app (user of emu10k1 hwdep).
>
>
>I don't think this is a big problem because there is no proper
>(completed) app for emu10k1 hwdep yet  :)=20
>
>> Uses usnigned short instead unsigned char, some members are longer, ...
>>=20
>> Is there better way to do this (support for audigy) ?
>> I would like to have audigy support in alsa cvs.
>
>
>Defining another ioctl for audigy is an option if the binary
>compatibility really matters.
>
>
>Takashi



=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
