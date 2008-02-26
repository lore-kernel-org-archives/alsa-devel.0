From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Via VT82xx VT1708 ICE1724HT and higher sample
 rate/bit depth files through SPDIF
Date: Tue, 26 Feb 2008 15:36:20 +0100
Message-ID: <47C423E4.4060900@insite.cz>
References: <068801c8783e$f5456390$d450a8c0@PDSMain2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from prague.insite.cz (r3g29.net.upc.cz [213.220.198.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 8312724340
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 15:36:29 +0100 (CET)
In-Reply-To: <068801c8783e$f5456390$d450a8c0@PDSMain2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Demian Martin <demianm_1@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Martin,

> =

> First- sample rate
> =

> Even though the documents claim that it will play at 176.4 KHz and 192KHz
> whenever I play a file at these rates it down converts to =BD the rate (8=
8200
> and 96000). I tested this with the ICE1724HT (Juli@) which has almost the
> same core, I never could get 176.4KHz at the SPDIF output. I confirmed th=
at
> the ICE1724 will play the file at 176.4KHz in Windows so its not a hardwa=
re
> limitation. I tried to do the same with the VT1708 (on a Via CX700  chips=
et)
> and the Windows driver wouldn=92t let me at anything other than 48000. =


I spent a few days on this issue and confirm that ICE1724HT cannot
output 176.4kHz from its internal SPDIF transmitter, WHEN clocked by its
internal clock circuits. A scope hooked to corresponding pins/outputs
revealed the following:

All I2S lines output correct 176.4kHz signal, i.e. D/A codecs receive
proper signal.

However, I did not find a way to force ICE1724 to output 176.4kHz, it
always drops to 88.2kHz, no matter what MT01/MT02 combination is. The =

same happens with windows drivers of my Prodigy 192. The sequence is: =

44.1, 48, 88.2, 96, 88.2, 192

I have not seen any manufacturer of Envy-based cards revealing this
deficiency. The "preliminary" datasheet we all use mentions only that
the chip forces the 128x mode when switched to 176.4kHz. I believe the =

output of 88.2kHz is an undocumented feature or perhaps even a bug of =

the chip.

Juli is a card whose manufacturer may be aware of the problem. It is not
clocked by ICE1724 internal clocks fed by the two crystals. Instead, the =

crystals also provide signal to external circuits generating
clock signals of required frequency, feeding the chip in slave mode. The =

circuitry is controlled by ice1724 GPIOs.

This way the ICE1724 is not aware of its clocking frequency and cannot =

thus mis-configure its SPDIF transmitter. The windows driver does
output proper 176.4kHz.

I am working on Juli driver and have been analyzing this beast for a
few nights. The special clocking is already working at home :)


> Second, the only way I can get the 24 bit files out in a form that the ca=
rd
> can play is to pass them through dmix. But I need to reconfigure dmix for
> each sample rate. And I=92m not convinced that it isn=92t resampling twic=
e, both
> at the input and the output. Or how to configure the buffers etc. to prev=
ent
> underruns even when the only conversion is to pass a 24 bit file to the
> card.

ICE cards use 32bits format. Try aplay -v -D plughw:0 24bit.wav and you
will see the conversion to 32 bits done by the plug plugin, no dmix
involved.


> =

> I=92m trying to build a high quality music server that will pass the file=
s to
> either the internal or an external DAC at the bit depth and sample rate t=
hey
> were recorded at. I have tried to understand the various plugs and settin=
gs
> but it seems they are all focused on mixing various streams. I want to se=
nd
> the files unmixed to the output. I can=92t figure out what set of plugs a=
nd
> settings in asound.conf would enable this.

Check the plug plugin.

Regards,

Pavel Hofman.
-----------------

inSITE, s.r.o.

Kafkova 16, 160 00 Praha 6
Rubesova 29, 326 00 Plzen

Tel., fax: +420 - 37 - 74 493 58
GSM: +420 - 603 - 163 973
Email: pavel.hofman@insite.cz

www.educity.cz, www.insite.cz
www.meetings.cz, www.hrzive.cz
www.comben.cz, www.hr-online.cz
