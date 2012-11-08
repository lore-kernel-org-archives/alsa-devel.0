From: Natanael Olaiz <nolaiz@gmail.com>
Subject: Re: Status of Zoom R16
Date: Thu, 08 Nov 2012 20:52:16 +0100
Message-ID: <509C0D70.10603@gmail.com>
References: <CAPk1tZaonL+bkH2sO+iUmEbAwuOWwecB9V39tQNHvQ0PKc=a+w@mail.gmail.com>
 <CACTFLAMUOjXYbjjZjjTs1bbmu=4Wr9XDeaim7s5Dvn=M1HJX7A@mail.gmail.com>
 <CAPk1tZZ2WRsc6LzztHzpuO3zoZVRXM3yD5ymeNYKJ6RzaMk7DQ@mail.gmail.com>
 <CACTFLANrwV3TbK9L58DYOc_M29UuiaN4vYih=f7awQUErWmuog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E69102615AA
 for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2012 20:48:45 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id hm6so1206280wib.2
 for <alsa-devel@alsa-project.org>; Thu, 08 Nov 2012 11:48:45 -0800 (PST)
In-Reply-To: <CACTFLANrwV3TbK9L58DYOc_M29UuiaN4vYih=f7awQUErWmuog@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Evan <evan.ta.88@gmail.com>
List-Id: alsa-devel@alsa-project.org

El 08/30/2011 04:14 PM, Daniel Mack escribi=F3:
> On Tue, Aug 30, 2011 at 4:05 PM, Evan <evan.ta.88@gmail.com> wrote:
>> On Tue, Aug 30, 2011 at 9:21 AM, Daniel Mack <zonque@gmail.com> wrote:
>>
>>> On Tue, Aug 30, 2011 at 9:04 AM, Evan Ta <evan.ta.88@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> as subj says: can you tell me how the Zoom R16 is doing? The hardware =
looks nice, but the latest info I can find is a seemingly unresolved  failu=
re to work with Alsa as of feb 2010.
>>> Yes, it's currently unsupported. The device doesn't comply to the USB
>>> audio spec, and nobody with such hardware has yet taken the time to
>>> implement a driver.
>>
>> How hard is this? If I buy it and help with testing, is this something t=
hat
>> can be done without too much hassle?
> Ideally, you would have an USB hardware analyzer to sniff the traffic.
> Software tracers are an alternative, but I never used any, so I can't
> tell how well they work, especially for isochronous transfers.
>
> Once you know how the device is set up and how the stream is
> organized, it should just be a matter of time and your programming
> skills to make it work. And there are several drivers for proprietary
> USB hardware in the kernel that you can take as an example. Needless
> to say that such effort would be much appreciated by many users :)

Sorry to reply such an old mail, but I want to ask: any news? I didn't
found any.

I have one R16, and I want to help to make it works as far as I can. I'm
specially interested in make it works as a MIDI controller.

Can you give me some tips about how to procede? I would go for the
software sniffer.

I'll be also glad if you can give any example of similar driver code
that I can use as a base to modify and do some tests with the device
communication.


Thanks in advance.

Best regards,
Natanael.



>
>
> Daniel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
