From: Andrew Reyes <dsreyes1014@gmail.com>
Subject: Re: Behringer Uphoria UMC204 usb audio capture only
 pops and clicks
Date: Wed, 23 Apr 2014 11:18:29 -0500
Message-ID: <CAEYsuVOrngrpBRw8au8H+9BAstvaD=aHcU3pcAzSGXuJaEEqDg@mail.gmail.com>
References: <CAEYsuVOBOGMwqhzx8ZROJ8+vbmfD6Ty=fnAtzccMqkFUGKPM4A@mail.gmail.com>
 <53551C5B.5010002@zonque.org>
 <CAEYsuVP1pr87v0y5SuKL87bCRr5RpfgLiSfjsZb4mis1yE_w1g@mail.gmail.com>
 <CAEYsuVML1ZFGGP35KB=3im_JTgNSCoNfPg1aMnzT6mjR=u1cJA@mail.gmail.com>
 <5355431F.3000501@zonque.org>
 <CAEYsuVNvr3WE+RCgCHKZHrBKybAc8muhx3nMu1NgfRgVbj9z1g@mail.gmail.com>
 <53555A0F.4080406@zonque.org>
 <CAEYsuVOmTuJ7dHu8mvOF0currhfgwC9WO3hitbKEAgKRBj9eoQ@mail.gmail.com>
 <5355655B.3050705@zonque.org>
 <CAEYsuVNw11e1Lzkbiwoeiz=wiXVUpwJnO51UaBy0eohL9eReEg@mail.gmail.com>
 <CAEYsuVN2Z=7oa_VB1660JpiKihoA=DxMn+Vgv-R5upoRpyhxiQ@mail.gmail.com>
 <53556961.5060600@zonque.org>
 <CAEYsuVOb=Ai=qd2F05JuoE5Xrb3gSDDuxCPHW=vLM-dcuQzdkA@mail.gmail.com>
 <CAEYsuVP2w8rQYxVReYm9jaxM40Yyta+P9OJWzEYbwcSJ7BVDRQ@mail.gmail.com>
 <CAEYsuVMhzhY8oHUn6DmXeDHLDL3xrmQo8P+xhBrvwhZaBfiegw@mail.gmail.com>
 <93266364-0c59-429e-9f8a-fe9ec89347c0@email.android.com>
 <CAEYsuVPDw7bSLJCKjAWCzZCNeKNtX3tR-Wnv+YDETy=NDt48SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com
 [209.85.216.52])
 by alsa0.perex.cz (Postfix) with ESMTP id C33A8261689
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 18:18:30 +0200 (CEST)
Received: by mail-qa0-f52.google.com with SMTP id ih12so1046566qab.25
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 09:18:29 -0700 (PDT)
In-Reply-To: <CAEYsuVPDw7bSLJCKjAWCzZCNeKNtX3tR-Wnv+YDETy=NDt48SA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok I got the two different logs and I don't what I'm looking for lol.  It's
just raw data. My last option is to try using it on Windows or Mac just to
make sure it's not the interface.


On Wed, Apr 23, 2014 at 10:40 AM, Andrew Reyes <dsreyes1014@gmail.com>wrote:

> > I can just give you a few more ideas to debug this, but that includes
> more action from your side.
>
> > * First of all, try the same device on a different computer, and/or a
> different USB port, especially if you're using an XHCI (USB3) port.
>
> > * Try the device on Mac OS X, without installing a driver and see if you
> have the same problem here.
>
> > * Use usbmon and analyze the data stream when a pop occurs. Compare that
> with settings that don't produce pops. There's good documentation on usbmon
> in Documentation/usb/ in the Linux kernel.
>
> Ok cool. I'll get right on that. I did try the first suggestion on four
> different computers and different ports and it's the same issue but just to
> be thorough I'll check again.
>
>
> On Wed, Apr 23, 2014 at 9:59 AM, Daniel Mack <daniel@zonque.org> wrote:
>
>>
>>
>> On April 23, 2014 4:40:07 PM CEST, Andrew Reyes <dsreyes1014@gmail.com>
>> wrote:
>> >Is there something else I could do to get to the problem?
>>
>> I can just give you a few more ideas to debug this, but that includes
>> more action from your side.
>>
>> * First of all, try the same device on a different computer, and/or a
>> different USB port, especially if you're using an XHCI (USB3) port.
>>
>> * Try the device on Mac OS X, without installing a driver and see if you
>> have the same problem here.
>>
>> * Use usbmon and analyze the data stream when a pop occurs. Compare that
>> with settings that don't produce pops. There's good documentation on usbmon
>> in Documentation/usb/ in the Linux kernel.
>>
>>
>> Best regards,
>> Daniel
>>
>> --
>> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
>>
>
>
