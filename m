From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Pop and offsets at start of audio playback/record
 for SGTL5000 on i.MX28
Date: Fri, 14 Nov 2014 03:04:51 +0100
Message-ID: <CAOf5uw=weZczcJNegd6P9Q7tnE3grbiLzYUHJo6xEOijYfeDRQ@mail.gmail.com>
References: <54655E35.9000807@beamcommunications.com>
 <CAOf5uwkh7inpgOO8affswziTnKV3-9_4U6v2G55JnTHb-RkCyA@mail.gmail.com>
 <546561D0.9090401@beamcommunications.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 532CF2604E8
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 03:04:52 +0100 (CET)
Received: by mail-wg0-f41.google.com with SMTP id l18so2782731wgh.28
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 18:04:52 -0800 (PST)
In-Reply-To: <546561D0.9090401@beamcommunications.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Craig McQueen <craig.mcqueen@beamcommunications.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

Il 14/nov/2014 09:58 "Craig McQueen" <craig.mcqueen@beamcommunications.com>
ha scritto:
>
> On 14/11/14 12:45, Michael Trimarchi wrote:
>>
>> Hi
>>
>> Il 14/nov/2014 09:44 "Craig McQueen" <
craig.mcqueen@beamcommunications.com> ha scritto:
>> >
>> > I'm testing the 3.14.19 kernel for i.MX28 EVK, which has an SGTL5000
CODEC. I've also tested on the 3.18-rc4 kernel and confirmed this issue
still occurs.
>> >
>>
>> Are you using it in master or slave mode?
>
>

Try to change the pin mux of data line in order to be hz in idle mode and
add a small pull down resistor. Can you check if the dataline is up when
clocks go off?

Michael

> For the i.MX28 EVK, the SGTL5000 is in slave mode.
>
> --
> Craig McQueen
>
