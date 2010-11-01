From: Christian Wisner-Carlson <christian@freedomofknowledge.org>
Subject: Re: Balanced output support for Xonar: Patches for
 Virtuoso driver to add mixer option for balanced mono output (PCM179x dacs)
Date: Mon, 1 Nov 2010 13:02:00 -0400
Message-ID: <AANLkTimtEefan3_5P4aTcD4sxW5Y_R_tZW=tz8jw=MMS@mail.gmail.com>
References: <AANLkTimODNVWg7qgfcnmZ_CDYr4t5QvMenDknO1O8YhX@mail.gmail.com>
	<4CCEE3FA.8040706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BEB3103805
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 18:02:01 +0100 (CET)
Received: by yxs7 with SMTP id 7so3883756yxs.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 10:02:01 -0700 (PDT)
In-Reply-To: <4CCEE3FA.8040706@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have the  H6 working somewhat. I added a lot of I2C resets (and a
loop to make sure the bus is free before trying to write to it).
HOWEVER, when the H6 is connected, and i switch from 128x OS, the
sound stops and becomes a high pitched whine or other noise, or just
stops, as if the DACs lost lock on the MCLK signal. The same thing
happens when i play ANYTHING at 96khz or 192khz sampling rate.
However, 88.2khz still plays at 64x OS. Given that a 24.576MHz
single-ended signalis being sent UNBUFFERED over an UNSHIELDED  ribbon
cable, this does not surprise me. I am guessing that the Asus drivers
probably use a lower MCLK rate. Any ideas? My old Audigy 2 buffered
the MCLK (24.576Mhz) with a 74F125, although I am reluctant to do
this. Perhaps I will try replacing the relevent part of the ribbon
cable with a shielded cable. Is this worth trying?

Christian Wisner-Carlson

On Mon, Nov 1, 2010 at 11:59 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Christian Wisner-Carlson wrote:
>> I tested this thoroughly with an Asus Xonar Essence ST, although it
>> should also work with the HDAV, Essence STX, and probably other cards.
>
> D2/D2X, Xense.
>
>> The patches that I am posting only give one control regardless of
>> whether or not more than one DAC is connected. I have another patchset
>> that gives individual control of all 4 dacs in the Xonar Essence ST+H6
>> and HDAV+H6 setups (H6 is an optional daughterboard for surround sound).
>
> BTW: any new information about the H6 problem?
>
>> It allows for 4 balanced outputs, 8 unbalanced outputs, or any
>> combination of balanced and unbalanced outputs. HOWEVER, it adds 4
>> mixer controls and the code isn't very pretty.
>
> The controller can route any stereo pair to each DAC, so it would be a
> good idea to have one global control that also affects this routing so
> that, e.g., configuring the card for 4 outputs works correctly when
> playing 4-channel data.
>
> Alternatively, having low-level controls for each detail of the hardware
> is workable when somebody (i.e., you :-) writes a special graphical tool
> to configure the Xonar outputs (any the other settings).
>
> The Xense has one PCM1796 for the front channels and a CS4362A for the
> other channels. =A0Like the stereo-only cards, this would result in an odd
> number of channels in balanced mode, which is somewhat counterintuitive
> because the controller would need to be fed an extra unused channel.
>
>> Please tell me if this is not the correct way to post a patch, and
>> tell me if it seems like a candidate to be merged.
>
> Your mailer wrapped lines; see Documentation/email-clients.txt.
> Also see Documentation/SubmittingPatches.
>
> Overall, this patch looks good. =A0But I wouldn't want to apply it without
> the followup patch that handles the D2's four DACs.
>
>> @@ -532,6 +534,13 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D PCM1796_OS_64;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D PCM1796_OS_32;
>> +
>> + =A0 =A0 if (data->monomode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D reg | PCM1796_MONO;
>> +
>> + =A0 =A0 if (data->rightmono)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D reg | PCM1796_CHSL_RIGHT;
>> +
>> =A0 =A0 =A0 for (i =3D 0; i < data->dacs; ++i)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcm1796_write_cached(chip, i, 20, reg);
>> =A0}
>
> This function's purpose is no longer to _only_ update the oversampling
> setting; please rename it to, e.g., update_reg20.
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
