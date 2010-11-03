From: Christian Wisner-Carlson <christian@freedomofknowledge.org>
Subject: Re: Balanced output support for Xonar: Patches for
 Virtuoso driver to add mixer option for balanced mono output (PCM179x dacs)
Date: Wed, 3 Nov 2010 09:01:36 -0400
Message-ID: <AANLkTikR3Jz51LpuxPPjXcXsj9_o1a6yPB4Kfk+wPT+j@mail.gmail.com>
References: <AANLkTimODNVWg7qgfcnmZ_CDYr4t5QvMenDknO1O8YhX@mail.gmail.com>
	<4CCEE3FA.8040706@ladisch.de>
	<AANLkTinEWKjLX2eVABVVTXP=mZyb_hphh8N0OzoHETyD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 112D1243A6
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 14:01:37 +0100 (CET)
Received: by fxm1 with SMTP id 1so424453fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 03 Nov 2010 06:01:36 -0700 (PDT)
In-Reply-To: <AANLkTinEWKjLX2eVABVVTXP=mZyb_hphh8N0OzoHETyD@mail.gmail.com>
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

I realize that this is not completely necessary, but it really would
get rid of a lot of potential duplicate code and could allow some
current code to be simplified.

On Wed, Nov 3, 2010 at 12:50 AM, Christian Wisner-Carlson
<christian@freedomofknowledge.org> wrote:
>>> It allows for 4 balanced outputs, 8 unbalanced outputs, or any
>>> combination of balanced and unbalanced outputs. HOWEVER, it adds 4
>>> mixer controls and the code isn't very pretty.
>>
>> The controller can route any stereo pair to each DAC, so it would be a
>> good idea to have one global control that also affects this routing so
>> that, e.g., configuring the card for 4 outputs works correctly when
>> playing 4-channel data.
>
> Currently, routing is set up by void oxygen_update_dac_routing(struct
> oxygen *chip) in oxygen_mixer.c.
> However, =A0it only allows for five different routing configurations,
> which it statically defines internally as int reg_values[5].
> Do you mind (ie, would you mind merging/using it) if I defined a new stru=
ct:
> struct oxygen_routing_table =3D {
> =A0 =A0 =A0 =A0u8 channels;
> =A0 =A0 =A0 =A0unsigned int dac0;
> =A0 =A0 =A0 =A0unsigned int dac1;
> =A0 =A0 =A0 =A0unsigned int dac2;
> =A0 =A0 =A0 =A0unsigned int dac3;
> }
> that would be passed to oxygen_update_dac_routing() as a new field of
> struct oxygen? This would allow for
> arbitrary routing configurations for the dacs (needed to implement 4
> channel balanced output) and would
> not require many changes to the driver as a whole. Where should I
> define this struct? (ie, in what file?)
>
> Thanks,
> Christian Wisner-Carlson
>
