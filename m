From: =?ISO-8859-1?Q?Jean-Pierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
Subject: Re: No jack sense on Intel 82801I / IDT 92HD71B7X in a
	HP dv4
Date: Sat, 13 Jun 2009 12:32:31 +0200
Message-ID: <4A33803F.6050107@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp28.orange.fr (smtp28.orange.fr [80.12.242.101])
	by alsa0.perex.cz (Postfix) with ESMTP id E6FA62441C
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 12:34:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, gustavo@sagui.org
List-Id: alsa-devel@alsa-project.org

Hi,


> At Fri, 12 Jun 2009 15:01:09 -0300,
> Gustavo Maciel Dias Vieira wrote:
>   =

>> > =

>> > Em Qui, 2009-06-11 =E0s 21:27 +0200, Takashi Iwai escreveu:
>>     =

>>>> > > > Interrupt 22 stays always with 0. Even when correctly playing
>>>>         =

>>> > > sounds. I
>>>       =

>>>> > > > tested this on another machine with HD-Audio, and the equivalent
>>>> > > > interrupt increased when playing. Also, in this other system
>>>>         =

>>> > > interrupt 0
>>>       =

>>>> > > > (timer) is hardly issued, but in this laptop it is firing all the
>>>>         =

>>> > > time.
>>>       =

>>>> > > > =

>>>> > > > How can the driver be working without interrupts?
>>>>         =

>>> > > =

>>> > > That's weird.
>>> > > =

>>> > > Did you try enable_msi=3D1 module option, BTW?
>>>       =

>> > =

>> > Just tried now. The interrupts started flowing and, tada, jack sense
>> > works!
>> > =

>> > Thanks, Takashi, that solves it for me. Is there a way to automate this
>> > in the driver for the other less technically inclined users?
>>     =

>
> Well, as I mentioned, it's basically a bug in the lower layer like
> ACPI or BIOS.  So, the best is to fix them.  Using MSI is a kind of
> workaround, and I'm wondering whether this is specific to your device
> or in general with other HP dv4, since I didn't hear of the similar
> bug reports.
>
>
> Takashi
>   =


Weird indeed. Actually I had already reported this
behaviour, see

http://article.gmane.org/gmane.linux.alsa.devel/59809

So far I have not been able to get the interrupts at
IRQ22. They still occur at IRQ20. However the problem
is hidden when using boot options irqpoll or noapic.

This is not a hardware or bios problem, as the sound
is correct on Windows.

Initially I was using kernel 2.6.27 and alsa-driver 1.0.19,
currently using kernel 2.6.29 and alsa-driver 1.0.20 with
the same behaviour.

I have tried numerous modprobe options. Currently
I am using :

alias snd-card-0 snd-hda-intel
options sound slots=3Dsnd-hda-intel
options snd-hda-intel model=3Dhp-m4 enable_msi=3D1 bdl_pos_adj=3D32 =

probe_mask=3D0x1ff

As Gustavo seems to have succeeded, can he post
kernel and alsa-driver versions, boot parameters
and modprobe parameters ?

Thanks in advance

Jean-Pierre
