From: Richard Storer <rstorer@ntlworld.com>
Subject: Re: snd-usb-audio issues??
Date: Mon, 14 Apr 2014 14:51:23 +0100
Message-ID: <CAA0fz9a9hcyaJN1v4dcOjSi8g8cXNg8CRkfrG3DWMRtQkRE9eQ@mail.gmail.com>
References: <CAA0fz9ZctzKNpcMCqR==rDdnGAk6yLf2Or_z=zi4XG7-QcHBmQ@mail.gmail.com>
 <534BD57F.6000006@ladisch.de>
 <CAA0fz9Y=EhoWBr5qMRabqf6acG-3yRCqtQcbOo9Xnn3yT3f4Vw@mail.gmail.com>
 <534BDA85.5000007@ladisch.de>
 <CAA0fz9aX8kVCC-B6teSuz9B2HyiFwL4QwoBCSZt+mwXXQpuc7A@mail.gmail.com>
 <534BE215.4010209@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 47B9626548E
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 15:51:24 +0200 (CEST)
Received: by mail-qg0-f44.google.com with SMTP id a108so8396897qge.31
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 06:51:23 -0700 (PDT)
In-Reply-To: <534BE215.4010209@ladisch.de>
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

>From what I can tell with the Windows driver Mic-In and Line-In share
the same mixer slider control, this may explain why only 1 capture
control appears under Linux.
I have tried adjusting the Mic levels while capturing audio but only
the Mic levels change the Line-In levels do not change at all.

Could this be confusing the driver somehow??

Richard S.


On 14/04/2014, Clemens Ladisch <clemens@ladisch.de> wrote:
> Richard Storer wrote:
>>         bTerminalID             4
>>         wTerminalType      0x0603 Line Connector
>
>>         bDescriptorSubtype      6 (FEATURE_UNIT)
>>         bUnitID                 5
>>         bSourceID               4
>>         bmaControls( 0)      0x02
>>           Volume Control
>
> That single capture mixer control controls the line input.
> (I don't know why it's labelled as "Mic", or how the device
> switches between mic and line signal levels.)
>
>
> Regards,
> Clemens
>
