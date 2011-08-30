From: Daniel Mack <zonque@gmail.com>
Subject: Re: Status of Zoom R16
Date: Tue, 30 Aug 2011 16:14:18 +0200
Message-ID: <CACTFLANrwV3TbK9L58DYOc_M29UuiaN4vYih=f7awQUErWmuog@mail.gmail.com>
References: <CAPk1tZaonL+bkH2sO+iUmEbAwuOWwecB9V39tQNHvQ0PKc=a+w@mail.gmail.com>
	<CACTFLAMUOjXYbjjZjjTs1bbmu=4Wr9XDeaim7s5Dvn=M1HJX7A@mail.gmail.com>
	<CAPk1tZZ2WRsc6LzztHzpuO3zoZVRXM3yD5ymeNYKJ6RzaMk7DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id EE7C32435E
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 16:14:19 +0200 (CEST)
Received: by qwf7 with SMTP id 7so3862508qwf.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2011 07:14:18 -0700 (PDT)
In-Reply-To: <CAPk1tZZ2WRsc6LzztHzpuO3zoZVRXM3yD5ymeNYKJ6RzaMk7DQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Evan <evan.ta.88@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2011 at 4:05 PM, Evan <evan.ta.88@gmail.com> wrote:
> On Tue, Aug 30, 2011 at 9:21 AM, Daniel Mack <zonque@gmail.com> wrote:
>
>> On Tue, Aug 30, 2011 at 9:04 AM, Evan Ta <evan.ta.88@gmail.com> wrote:
>> > Hi,
>> >
>> > as subj says: can you tell me how the Zoom R16 is doing? The hardware
>> looks
>> > nice, but the latest info I can find is a seemingly unresolved failure to
>> > work with Alsa as of feb 2010.
>>
>> Yes, it's currently unsupported. The device doesn't comply to the USB
>> audio spec, and nobody with such hardware has yet taken the time to
>> implement a driver.
>
>
> How hard is this? If I buy it and help with testing, is this something that
> can be done without too much hassle?

Ideally, you would have an USB hardware analyzer to sniff the traffic.
Software tracers are an alternative, but I never used any, so I can't
tell how well they work, especially for isochronous transfers.

Once you know how the device is set up and how the stream is
organized, it should just be a matter of time and your programming
skills to make it work. And there are several drivers for proprietary
USB hardware in the kernel that you can take as an example. Needless
to say that such effort would be much appreciated by many users :)


Daniel
