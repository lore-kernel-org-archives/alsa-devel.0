From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030 and Puredata/jack
Date: Mon, 11 Mar 2013 11:42:11 +0100
Message-ID: <513DB503.5020109@ti.com>
References: <CAAuz6aqqixPxBZQQ5GJinPDfseSVKcnBCvMnLt-6Uad4fP9uPw@mail.gmail.com>
 <513B99C0.8020805@gmail.com>
 <CAAuz6apRE90QU5Hm-+jeEB4nxcZHUNp4_Hhfcgb_p7854FiwBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E87B265290
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 11:42:18 +0100 (CET)
In-Reply-To: <CAAuz6apRE90QU5Hm-+jeEB4nxcZHUNp4_Hhfcgb_p7854FiwBw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anders Alex <alibobar@gmail.com>
Cc: alsa-devel@alsa-project.org, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/11/2013 02:42 AM, Anders Alex wrote:
> On Sat, Mar 9, 2013 at 9:21 PM, Gabriel M. Beddingfield
> <gabrbedd@gmail.com>wrote:
> =

>> Strange.  In kernel 3.2, omap-mcbsp-dai.1 (McBSP1) is used for the codec.
>>  But in the mainline it's omap-mcbsp-dai.2.
>>
>> So the question is... how is the board wired?  And does your kernel match
>> the board?
> =

> 1) no idea 2) it should, yes.

McBSP2 is connected to PCM1773 for playback
McBSP4 is connected to TWL4030 for capture

Both codec is slave, but the CLKS of McBSP is connected to TWL4030's CLKS o=
ut
256fs.

Since both PCM is hooked with the twl4030 codec driver, only stereo stream =
is
supported because the twl4030 does not support mono on the HiFi DAI (it
supports stereo or four channel).
They needed to do this so when they do playback through the PCM1773 they ne=
ed
to power on the twl4030 codec and receive the 256fs from it.

Gra=9Evydas Ignotas can correct me if I'm mistaken...

>> Looking at the source, it looks like hw:0,0 has no capture port.  Try
>> adding the -P parameter to jackd.  Playback only.
>>
> Hmm, when I do that I get:
> =

> [419034.693756] Alignment trap: not handling instruction edc46a06 at
> [<4022ce2c>]
> [419034.693878] Unhandled fault: alignment exception (0x801) at 0x4019e1e6
> =

> In dmesg.
> Apparently this is/was a known issue on jack2 and has been fixed there.
> No idea about jack1 (which I'm currently running). Will try to compile
> latest jack2 and report back on this.
> =

> =

> Also, post the output of:
>>
>>    $ cat /proc/asound/devices
>>
> =

> $ cat /proc/asound/devices
>   0: [ 0]   : control
>   1:        : sequencer
>  16: [ 0- 0]: digital audio playback
>  17: [ 0- 1]: digital audio playback
>  24: [ 0- 0]: digital audio capture
>  25: [ 0- 1]: digital audio capture
>  33:        : time
> =

> =

>>
>> -gabriel
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =



-- =

P=E9ter
