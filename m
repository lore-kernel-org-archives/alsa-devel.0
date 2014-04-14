From: Richard Storer <rstorer@ntlworld.com>
Subject: Re: snd-usb-audio issues??
Date: Mon, 14 Apr 2014 15:40:13 +0100
Message-ID: <CAA0fz9ap=cySB62KsnGiqrio3vPkV0JMfy=VUwfWT7ECeFtQhg@mail.gmail.com>
References: <CAA0fz9ZctzKNpcMCqR==rDdnGAk6yLf2Or_z=zi4XG7-QcHBmQ@mail.gmail.com>
 <534BD57F.6000006@ladisch.de>
 <CAA0fz9Y=EhoWBr5qMRabqf6acG-3yRCqtQcbOo9Xnn3yT3f4Vw@mail.gmail.com>
 <534BDA85.5000007@ladisch.de>
 <CAA0fz9aX8kVCC-B6teSuz9B2HyiFwL4QwoBCSZt+mwXXQpuc7A@mail.gmail.com>
 <534BE215.4010209@ladisch.de>
 <CAA0fz9a9hcyaJN1v4dcOjSi8g8cXNg8CRkfrG3DWMRtQkRE9eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id F08D0261A09
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 16:40:14 +0200 (CEST)
Received: by mail-qa0-f51.google.com with SMTP id j7so8009749qaq.38
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 07:40:13 -0700 (PDT)
In-Reply-To: <CAA0fz9a9hcyaJN1v4dcOjSi8g8cXNg8CRkfrG3DWMRtQkRE9eQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi, thanks for the info regarding live24ext_map.
I read the comments "the card may adjust microphone input level only."
but I do not understand.

Does this mean my device lacks hardware control for Line-In??

Does the Windows driver providing Line-In levels with software emulation??

I am a little confused here.

Richard S.


On 14/04/2014, Richard Storer <rstorer@ntlworld.com> wrote:
> From what I can tell with the Windows driver Mic-In and Line-In share
> the same mixer slider control, this may explain why only 1 capture
> control appears under Linux.
> I have tried adjusting the Mic levels while capturing audio but only
> the Mic levels change the Line-In levels do not change at all.
>
> Could this be confusing the driver somehow??
>
> Richard S.
>
>
> On 14/04/2014, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Richard Storer wrote:
>>>         bTerminalID             4
>>>         wTerminalType      0x0603 Line Connector
>>
>>>         bDescriptorSubtype      6 (FEATURE_UNIT)
>>>         bUnitID                 5
>>>         bSourceID               4
>>>         bmaControls( 0)      0x02
>>>           Volume Control
>>
>> That single capture mixer control controls the line input.
>> (I don't know why it's labelled as "Mic", or how the device
>> switches between mic and line signal levels.)
>>
>>
>> Regards,
>> Clemens
>>
>
