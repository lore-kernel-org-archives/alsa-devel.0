From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: routing audio stream to multiple devices
Date: Fri, 26 Jun 2009 00:02:42 -0300
Message-ID: <d54969c50906252002q328bd6cja94210a6af9eacd6@mail.gmail.com>
References: <aceb60a00906251846v2f9607dcp8f89c4379f7bc097@mail.gmail.com>
	<d54969c50906251857n7e0073c8h9ae61943da6c5ca@mail.gmail.com>
	<aceb60a00906251950m427a1ecg82ba038561d54c6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 65B7724659
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 05:02:44 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2468502qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 20:02:43 -0700 (PDT)
In-Reply-To: <aceb60a00906251950m427a1ecg82ba038561d54c6e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Baek Chang <baeksan@ccrma.stanford.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I don't really know how to do this on dmix, nor I do know much about
alsa or dmix. But I'm quite certain this is achieveable with
pulseaudio; I have done it once using the GUI they provide.

Might be of help if you still want to use dmix:
http://alsa.opensrc.org/index.php/Dmix

2009/6/25 Baek Chang <baeksan@ccrma.stanford.edu>:
> I am trying to do this with dmix, but I can't seem to find a clear cut
> solution to this?=A0 I was under the impression that editing my asound.co=
nf
> could acheive this?=A0 Basically, it seems that you have to make a stream=
 a
> slave to two different devices.=A0 Is this possible?
>
> Thanks
> Baek
>
> On Thu, Jun 25, 2009 at 6:57 PM, Emilio L=F3pez <buhitoescolar@gmail.com>
> wrote:
>>
>> You can achieve this with pulseaudio, and maybe with alsa's dmix.
>>
>> 2009/6/25 Baek Chang <baeksan@ccrma.stanford.edu>:
>> > I was wondering if it was possible to route a single audio stream to
>> > multiple alsa devices or plugins?
>> >
>> > For example, I am playing a song and want it to stream to both my sound
>> > card
>> > at hw:0 and a bluetooth device, an alsa plugin. =A0Is this possible? =
=A0It
>> > seems
>> > that configuring asound.conf only lets you route streams serially to a
>> > single device at a time. =A0Any info would be greatly appreciated.
>> >
>> > Thanks in advance
>> > Baek
>> >
>> > --
>> > Baek Chang
>> > baeksan@ccrma.stanford.edu
>> > 407-267-6701
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >
>>
>
>
>
> --
> Baek Chang
> baeksan@ccrma.stanford.edu
> 407-267-6701
>
