From: Todd Dailey <todd@todddailey.ca>
Subject: Re: No sound from Mac Pro headphone port
Date: Fri, 08 May 2015 10:48:15 -0400
Message-ID: <554CCCAF.6000608@todddailey.ca>
References: <554CC0EC.5000506@todddailey.ca>
 <CAN8cciYJdMeKyYL1mqUkN3bKmEhwqHN1-pZzCvBDazBPKdH7vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yonca.sibername.com (yonca.sibername.com [67.212.91.121])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A3FB265D7A
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 16:48:18 +0200 (CEST)
In-Reply-To: <CAN8cciYJdMeKyYL1mqUkN3bKmEhwqHN1-pZzCvBDazBPKdH7vw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Bingo: the pin-outs are very incorrect.

This is the (original) tech specs of the machine.

https://support.apple.com/kb/SP506?viewlocale=en_US&locale=en_US

Note:

1 x internal speaker
1 x FRONT headphone port
1 x REAR line out port
1 x REAR line in port
1 x REAR optical TOSLINK out port
1 x REAR optical TOSLINK in port

The machine does not have a built-in mic port.

-- 
TD
todd@todddailey.ca

On 08/05/15 10:36 AM, Raymond Yau wrote:
>
>
> 2015-05-08 21:58 GMT+08:00 Todd Dailey <todd@todddailey.ca
> <mailto:todd@todddailey.ca>>:
>
>     https://bugtrack.alsa-project.org/alsa-bug does not work so
>     following instructions to post bug here.
>
>     Linux 4. Mac Pro 2009. ACL889A codec.
>
>     No sound from headphone port. Seems to detect plug / unplug OK.
>
>     Works OK when machine booted to OS X or Windows 7.
>
>     Have found several bug repors on similar issues with Mac laptops but
>     no fixes.
>
>     Have written e-mail with David Henningsson on problem but unable to
>     find a solution.
>
>     ALSA-info output:
>
>     http://www.alsa-project.org/db/?f=1dc7146eb34af5ad307d029868f775fac5e2764e
>
>
> Do your macpro spec support 5.1 ?
>
> Simple mixer control 'Channel Mode',0
>    Capabilities: enum
>    Items: '2ch' '4ch' '6ch'
>    Item0: '2ch'
>
> Pin default seem incorrect
>
> 1) Headphone at ext Rear
> 2) Line Out does not support jack detection
> 3) Mic jack ????
>
> /sys/class/sound/hwC0D0/init_pin_configs:
> 0x14 0x01010150
> 0x15 0x400000f0
> 0x16 0x400000f0
> 0x17 0x400000f0
> 0x18 0x01a19070
> 0x19 0x01214040
> 0x1a 0x01813010
> 0x1b 0x90100130
> 0x1c 0x400000f0
> 0x1d 0x400000f0
> 0x1e 0x0145e160
> 0x1f 0x01c5e120
>
> /sys/class/sound/hwC0D0/driver_pin_configs:
>
>
>
> [    4.057250] sound hdaudioC0D0: ALC889A: SKU not ready 0x400000f0
> [    4.057633] sound hdaudioC0D0: autoconfig for ALC889A: line_outs=1
> (0x14/0x0/0x0/0x0/0x0) type:line
> [    4.057636] sound hdaudioC0D0:    speaker_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [    4.057638] sound hdaudioC0D0:    hp_outs=1 (0x19/0x0/0x0/0x0/0x0)
> [    4.057639] sound hdaudioC0D0:    mono: mono_out=0x0
> [    4.057641] sound hdaudioC0D0:    dig-out=0x1e/0x0
> [    4.057642] sound hdaudioC0D0:    inputs:
> [    4.057645] sound hdaudioC0D0:      Mic=0x18
> [    4.057646] sound hdaudioC0D0:      Line=0x1a
> [    4.057648] sound hdaudioC0D0:    dig-in=0x1f
>
