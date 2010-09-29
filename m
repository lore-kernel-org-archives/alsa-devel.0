From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Wed, 29 Sep 2010 15:27:19 +0200
Message-ID: <AANLkTimz3iiXPhEarEUY1Gw5GxrTuv+UXgKKZS3ObzuS@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
	<AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
	<AANLkTinYcRqMwH2FSUjXiOxZg4x09q673FL9m15YvXEa@mail.gmail.com>
	<AANLkTik8HayTEADWn74PJ0NgjGunamsSAZpy_GanuZo3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 96F7A1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 15:27:43 +0200 (CEST)
Received: by iwn4 with SMTP id 4so1075294iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2010 06:27:40 -0700 (PDT)
In-Reply-To: <AANLkTik8HayTEADWn74PJ0NgjGunamsSAZpy_GanuZo3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Sep 29, 2010 at 5:06 AM, Raymond Yau
<superquad.vortex2@gmail.com> wrote:
> 2010/9/28 Mark Goldstein <goldstein.mark@gmail.com>
>
>> Hi,
>>
>> > In theory, a motherboard with 6 audio jacks at back panel does not need
>> > retasking pink and blue jacks as output pins , it seem to me that the
>> > "smart5.1" switch is redundant for your motherboard.
>> >
>> > it seem this patch may has side effect on those via codec since they n=
eed
>> to
>> > differentate the front mic and mic at rear panel for retasking
>> >
>> >
>> http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommitdiff;h=3Dbbe9=
59733a719ecffda8ecd7d4b9631a2745e8b4;hp=3D6650d30dfe1cf9ef6e639bd898d3b2f63=
7f4bf3b
>>
>> Looks like a possibility.
>>
>> What bothers me is the fact that with git version the card is not
>> detected properly (on oS 11.1). I missed this detail in my report just
>> because I did not try alsaconf after the problem first occurred.
>> That is, alsaconf does not show it in the list of cards.
>> So I guess that the sound driver uses some defaults (it does indicate
>> the this is hda-intel) that just does not match the actual codec.
>> While when I use stable 1.0.23 version card is detected by alsaconf
>> and works correctly.
>>
>> From the other side, the problem on oS 11.3 looks very different.
>> I did not update driver there, just installed additional kernel that
>> also has alsa 1.0.23.
>>
>> How it could lead to "Capture1" switch "reversing"? And now when I
>> found it out and set it to "mute", Mic works correctly with recording
>> SW and produces distorted audio in Skype in exactly the same
>> configuration where it worked perfectly a couple of weeks ago.
>>
>> Regards,
>> --
>> Mark Goldstein
>>
>
> How did you perform the recording since there are two capturing subdevice=
s ?

When I played with alsamixer before, I saw that only Capture1 works
for me. This time I set both Capture1 and Capture2 levels to some high
value and saw that Capture2 does not change anything.
>From the other side, using hda_analyzer I noticed that that MSB of the
volume actually means "mute", that is when I see something like 9f
there is no sound recored, while 1f produces sound. And then I saw
that this bit reflects the "Mute" checkbox state.

>
> Are you sure that Skype/pulseaudo open the same subdevice ?

I think so. First, It worked before. I have no pulseaudio. Skype just
uses hw:0 device. It does some recording, but the audio is very
distorted (low volume, no high frequencies, kind of clipped). I
disabled the Skype option to adjust mixer volumes and play with it
myself.

>
> "Capture1" switch is associated with Node 0x14 [Audio Input]
>
> Refer to the graph in hda_analyzer , when you place the mouse cursor insi=
de
> the "out" box of the Node 0x1e (Front Mic Pin) , there are three red lines
> indicate the possible connections to 0x14, 0x16 and 0x17
>
> Unlike the other HDA codec , your vt1708s has only one "Input Souce" cont=
rol
> and two ADC
>
> For the other HDA codec, the number of "Input Source" controls is =A0usua=
lly
> equal to the number of ADC, this mean that some input sources (e.g. mic =
=A0)
> can only be connected to one ADC .
>
> As you can see in the graph, node 0x14 can be connected to 0x1e only
>
> All the connected audio path are displayed as blue line and it is strange
> there are no blue line connected to =A0both the node 0x13 and 0x14 [Audio
> Input]

I will not be able to check it for about a week. When I'll have access
to my PC again, I'll re-check and let you know what I see.
Thanks a lot.
-- =

Mark Goldstein
